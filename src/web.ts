import { WebPlugin } from '@capacitor/core';

import type {
  SegmentAnalyticsPlugin,
  InitializeArguments,
  IdentifyArguments,
  TrackArguments,
  PageArguments,
  ScreenArguments,
  GroupArguments,
  AliasArguments,
} from './definitions';

function buildSegmentScript(writeKey: string): string {
  return `!function(){var analytics=window.analytics=window.analytics||[];if(!analytics.initialize)if(analytics.invoked)window.console&&console.error&&console.error("Segment snippet included twice.");else{analytics.invoked=!0;analytics.methods=["trackSubmit","trackClick","trackLink","trackForm","pageview","identify","reset","group","track","ready","alias","debug","page","once","off","on","addSourceMiddleware","addIntegrationMiddleware","setAnonymousId","addDestinationMiddleware"];analytics.factory=function(e){return function(){var t=Array.prototype.slice.call(arguments);t.unshift(e);analytics.push(t);return analytics}};for(var e=0;e<analytics.methods.length;e++){var key=analytics.methods[e];analytics[key]=analytics.factory(key)}analytics.load=function(key,e){var t=document.createElement("script");t.type="text/javascript";t.async=!0;t.src="https://cdn.segment.com/analytics.js/v1/" + key + "/analytics.min.js";var n=document.getElementsByTagName("script")[0];n.parentNode.insertBefore(t,n);analytics._loadOptions=e};analytics._writeKey="9KLXaUrs09zme4ewqrSKzcVtHEiOtrAf";;analytics.SNIPPET_VERSION="4.15.3";
  analytics.load("${writeKey}");
  analytics.page();
  }}();`;
}

declare global {
  interface Window {
    analytics?: any;
  }
}
export class SegmentAnalyticsWeb
  extends WebPlugin
  implements SegmentAnalyticsPlugin {
  async initialize(args: InitializeArguments): Promise<void> {
    const { writeKey } = args;
    await this.loadScript('segment', buildSegmentScript(writeKey));
  }

  async identify(args: IdentifyArguments): Promise<void> {
    if (!window.analytics) return Promise.reject('Segment is not initialized');

    const { userId, traits, options } = args;
    if (!userId)
      return Promise.reject(
        "User ID is required for 'identify' but not supplied",
      );

    window.analytics.identify(userId, traits, options);
  }

  async track(args: TrackArguments): Promise<void> {
    if (!window.analytics) return Promise.reject('Segment is not initialized');

    const { eventName, properties, options } = args;
    if (!eventName) return Promise.reject('Event name is not supplied');

    window.analytics.track(eventName, properties, options);
  }

  async screen(args: ScreenArguments): Promise<void> {
    if (!window.analytics) return Promise.reject('Segment is not initialized');

    const { screenName, category, properties, options } = args;
    if (!screenName) return Promise.reject('Screen name must be supplied');

    window.analytics.page(category, screenName, properties, options);
  }

  async page(args: PageArguments): Promise<void> {
    if (!window.analytics) return Promise.reject('Segment is not initialized');

    const { pageName, category, properties, options } = args;
    if (!pageName) return Promise.reject('Page name must be supplied');

    window.analytics.page(category, pageName, properties, options);
  }

  async group(args: GroupArguments): Promise<void> {
    if (!window.analytics) return Promise.reject('Segment is not initialized');

    const { userId, groupId, traits, options } = args;
    if (!userId) return Promise.reject('User ID was not supplied');
    if (!groupId) return Promise.reject('Group ID was not supplied');

    window.analytics.group(userId, groupId, traits, options);
  }

  async alias(args: AliasArguments): Promise<void> {
    if (!window.analytics) return Promise.reject('Segment is not initialized');

    const { newId, options } = args;
    if (!newId) return Promise.reject('New ID was not supplied');

    window.analytics.alias(newId, options);
  }

  async reset(): Promise<void> {
    if (!window.analytics) return Promise.reject('Segment is not initialized');
    window.analytics.flush();
  }

  /**
   * Loaded single script with provided id and source
   * @param id - unique identifier of the script
   * @param src - source of the script
   */
  private loadScript(id: string, script: string): Promise<any> {
    return new Promise(resolve => {
      if (document.getElementById(id)) {
        resolve(null);
      } else {
        const node = document.createTextNode(script);
        const file = document.createElement('script');
        file.type = 'text/javascript';
        file.id = id;
        file.onload = resolve;
        file.onerror = console.error;
        file.appendChild(node);
        document.head.appendChild(file);
      }
    });
  }
}

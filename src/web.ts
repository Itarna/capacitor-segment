import { WebPlugin } from '@capacitor/core';

import type { SegmentAnalyticsPlugin } from './definitions';

export class SegmentAnalyticsWeb
  extends WebPlugin
  implements SegmentAnalyticsPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}

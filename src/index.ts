import { registerPlugin } from '@capacitor/core';

import type { SegmentAnalyticsPlugin } from './definitions';

const SegmentAnalytics = registerPlugin<SegmentAnalyticsPlugin>(
  'SegmentAnalytics',
  {
    web: () => import('./web').then(m => new m.SegmentAnalyticsWeb()),
  },
);

export * from './definitions';
export { SegmentAnalytics };

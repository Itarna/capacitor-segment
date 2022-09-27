import { registerPlugin } from '@capacitor/core';
const SegmentAnalytics = registerPlugin('SegmentAnalytics', {
    web: () => import('./web').then(m => new m.SegmentAnalyticsWeb()),
});
export * from './definitions';
export { SegmentAnalytics };
//# sourceMappingURL=index.js.map
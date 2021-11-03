export interface SegmentAnalyticsPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}

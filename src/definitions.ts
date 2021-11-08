export interface SegmentAnalyticsPlugin {
  /**
   * Configures and initializes the segment plugin
   */
  initialize(args: InitializeArguments): Promise<void>;

  /**
   * Identify a user.
   */
  identify(args: IdentifyArguments): Promise<void>;

  /**
   * Track an event.
   */
  track(args: TrackArguments): Promise<void>;

  /**
   * Trigger screen view.
   */
  screen(args: ScreenArguments): Promise<void>;

  /**
   * Trigger page view.
   */
  page(args: PageArguments): Promise<void>;

  /**
   * Clear all information about the visitor & reset analytic state.
   */
  group(options: GroupArguments): Promise<void>;

  /**
   * Clear all information about the visitor & reset analytic state.
   */
  alias(options: AliasArguments): Promise<void>;

  /**
   * clears the SDK’s internal stores for the current user and group.
   */
  reset(): Promise<void>;
}

export interface InitializeArguments {
  writeKey: string;
  trackLifecycleEvents?: boolean;
  recordScreenViews?: boolean;
}

export interface IdentifyArguments {
  userId?: string;
  traits?: Record<string, unknown>;
  options?: Record<string, unknown>;
}

export interface TrackArguments {
  eventName: string;
  properties?: Record<string, unknown>;
  options?: Record<string, unknown>;
}

export interface ScreenArguments {
  screenName: string;
  category?: string;
  properties?: Record<string, unknown>;
  options?: Record<string, unknown>;
}

export interface PageArguments {
  pageName: string;
  category?: string;
  properties?: Record<string, unknown>;
  options?: Record<string, unknown>;
}

export interface GroupArguments {
  userId: string;
  groupId: string;
  traits?: Record<string, unknown>;
  options?: Record<string, unknown>;
}

export interface AliasArguments {
  newId: string;
  options?: Record<string, unknown>;
}

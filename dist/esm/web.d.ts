import { WebPlugin } from '@capacitor/core';
import type { SegmentAnalyticsPlugin, InitializeArguments, IdentifyArguments, TrackArguments, PageArguments, ScreenArguments, GroupArguments, AliasArguments } from './definitions';
declare global {
    interface Window {
        analytics?: any;
    }
}
export declare class SegmentAnalyticsWeb extends WebPlugin implements SegmentAnalyticsPlugin {
    initialize(args: InitializeArguments): Promise<void>;
    identify(args: IdentifyArguments): Promise<void>;
    track(args: TrackArguments): Promise<void>;
    screen(args: ScreenArguments): Promise<void>;
    page(args: PageArguments): Promise<void>;
    group(args: GroupArguments): Promise<void>;
    alias(args: AliasArguments): Promise<void>;
    reset(): Promise<void>;
    /**
     * Loaded single script with provided id and source
     * @param id - unique identifier of the script
     * @param src - source of the script
     */
    private loadScript;
}

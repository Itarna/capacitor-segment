import Foundation
import Capacitor
import Segment

@objc public class SegmentAnalytics: NSObject {
    @objc public func initialize(writeKey: String, trackLifecycleEvents: Bool, recordScreenViews: Bool) {
        let configuration = AnalyticsConfiguration.init(writeKey: writeKey)
        configuration.trackApplicationLifecycleEvents = trackLifecycleEvents
        configuration.recordScreenViews = recordScreenViews

        Analytics.setup(with: configuration)
        print("SegmentAnalytics: initialized")
    }

    @objc public func identify(userId: String, traits: [String: Any], options: [String: Any]) {
        Analytics.shared().identify(userId, traits: traits, options: options)
        return
    }

    @objc public func track(event: String, properties: [String: Any], options: [String: Any]) {
        Analytics.shared().track(event, properties: properties, options: options)
        return
    }

    @objc public func screen(screenName: String, properties: [String: Any], options: [String: Any]) {
        Analytics.shared().screen(screenName, properties: properties, options: options)
        return
    }

    @objc public func group(userId: String, groupId: String, traits: [String: Any], options: [String: Any]) {
        Analytics.shared().group(userId, groupId, traits: traits, options: options)
        return
    }

    @objc public func alias(newId: String, options: [String: Any]) {
        Analytics.shared().alias(newId, options: options)
        return
    }

    @objc func reset() {
        Analytics.shared().reset()
        return
    }
}

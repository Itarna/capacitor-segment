import Foundation
import Capacitor

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(SegmentAnalyticsPlugin)
public class SegmentAnalyticsPlugin: CAPPlugin {
    private var initialized = false
    private let implementation = SegmentAnalytics()

    @objc func initialize(_ call: CAPPluginCall) {
        if initialized == true {
            call.reject("Segment is already initialized")
            return
        }
        guard let writeKey: String = call.getString("writeKey") else {
            call.reject("Write key is required to initialize plugin")
            return
        }
        let trackLifecycleEvents: Bool = call.getBool("trackLifecycleEvents") ?? false;
        let recordScreenViews: Bool = call.getBool("recordScreenViews") ?? false;
        implementation.initialize(writeKey: writeKey, trackLifecycleEvents: trackLifecycleEvents, recordScreenViews: recordScreenViews)
        initialized = true
        call.resolve()
    }

    @objc func identify(_ call: CAPPluginCall) {
        if initialized != true {
            call.reject("Segment is not initialized")
            return
        }
        guard let userId: String = call.getString("userId") else {
            call.reject("User ID is required for 'identify' but not supplied")
            return
        }

        let traits: Dictionary = call.getObject("traits") ?? [:]
        let options: Dictionary = call.getObject("options") ?? [:]
        implementation.identify(userId: userId, traits: traits, options: options)
        call.resolve()
    }

    @objc func track(_ call: CAPPluginCall) {
        if initialized != true {
            call.reject("Segment is not initialized")
            return
        }
        guard let eventName: String = call.getString("eventName") else {
            call.reject("Event name is not supplied")
            return
        }

        let properties: Dictionary = call.getObject("properties") ?? [:]
        let options: Dictionary = call.getObject("options") ?? [:]
        implementation.track(eventName: eventName, properties: properties, options: options)
        call.resolve()
    }

    @objc func screen(_ call: CAPPluginCall) {
        if initialized != true {
            call.reject("Segment is not initialized")
            return
        }

        guard let screenName: String = call.getString("screenName") else {
            call.reject("Screen name is not supplied")
            return
        }

        let category: String? = call.getString("category") ?? nil
        let properties: Dictionary = call.getObject("properties") ?? [:]
        let options: Dictionary = call.getObject("options") ?? [:]

        implementation.screen(screenName: screenName, category: category, properties: properties, options: options)
        call.resolve()
    }

    @objc func page(_ call: CAPPluginCall) {
        if initialized != true {
            call.reject("Segment is not initialized")
            return
        }

        guard let pageName: String = call.getString("pageName") else {
            call.reject("Page name is not supplied")
            return
        }

        let category: String? = call.getString("category") ?? nil
        let properties: Dictionary = call.getObject("properties") ?? [:]
        let options: Dictionary = call.getObject("options") ?? [:]

        implementation.screen(screenName: pageName, category: category, properties: properties, options: options)
        call.resolve()
    }

    @objc func group(_ call: CAPPluginCall) {
        if initialized != true {
            call.reject("Segment is not initialized")
            return
        }

        guard let userId: String = call.getString("userId") else {
            call.reject("User ID was not supplied")
            return
        }

        guard let groupId: String = call.getString("groupId") else {
            call.reject("Group ID was not supplied")
            return
        }

        let traits: Dictionary = call.getObject("traits") ?? [:]
        let options: Dictionary = call.getObject("options") ?? [:]
        implementation.group(userId: userId, groupId: groupId, traits: traits, options: options)
        call.resolve()
    }

    @objc func alias(_ call: CAPPluginCall) {
        if initialized != true {
            call.reject("Segment is not initialized")
            return
        }
        guard let newId: String = call.getString("newId") else {
            call.reject("New ID was not supplied")
            return
        }

        let options: Dictionary = call.getObject("options") ?? [:]
        implementation.alias(newId: newId, options: options)
        call.resolve()
    }

    @objc func reset(_ call: CAPPluginCall) {
        if initialized != true {
            call.reject("Segment is not initialized")
            return
        }

        implementation.reset()
        call.resolve()
    }
}

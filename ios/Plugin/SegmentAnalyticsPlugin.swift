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
        guard let writeKey = call.getString("writeKey") else {
            call.reject("Write key is required to initialize plugin")
            return
        }
        let trackLifecycleEvents: Bool = call.getBool("trackLifecycleEvents", false)
        let recordScreenViews: Bool = call.getBool("recordScreenViews", false)
        implementation.initialize(writeKey: writeKey, trackLifecycleEvents: trackLifecycleEvents, recordScreenViews: recordScreenViews)
        initialized = true
        call.resolve()
    }

    @objc func identify(_ call: CAPPluginCall) {
        if initialized != true {
            call.reject("Segment is not initialized")
            return
        }
        guard let userId = call.getString("userId") else {
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
        guard let eventName = call.getString("eventName") else {
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
        guard let screenName = call.getString("screenName") else {
            call.reject("Screen name was not supplied")
            return
        }

        let properties: Dictionary = call.getObject("properties") ?? [:]
        let options: Dictionary = call.getObject("options") ?? [:]
        implementation.screen(screenName: screenName, properties: properties, options: options)
        call.resolve()
    }

    @objc func page(_ call: CAPPluginCall) {
        if initialized != true {
            call.reject("Segment is not initialized")
            return
        }

        guard let pageName = call.getString("pageName") else {
            call.reject("Page name was not supplied")
            return
        }

        let properties: Dictionary = call.getObject("properties") ?? [:]
        let options: Dictionary = call.getObject("options") ?? [:]
        implementation.screen(pageName: pageName, properties: properties, options: options)
        call.resolve()
    }

    @objc func group(_ call: CAPPluginCall) {
        if initialized != true {
            call.reject("Segment is not initialized")
            return
        }

        guard let userId = call.getString("userId") else {
            call.reject("User ID was not supplied")
            return
        }

        guard let groupId = call.getString("groupId") else {
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
        guard let newId = call.getString("newId") else {
            call.reject("New ID was not supplied")
            return
        }

        let options: Dictionary = call.getObject("options") ?? [:]
        implementation.screen(newId: newId, options: options)
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

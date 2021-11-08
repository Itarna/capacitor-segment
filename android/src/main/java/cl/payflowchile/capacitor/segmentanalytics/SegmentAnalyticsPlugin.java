package cl.payflowchile.capacitor.segmentanalytics;

import com.getcapacitor.JSObject;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.CapacitorPlugin;
import com.getcapacitor.annotation.CapacitorPlugin;

@CapacitorPlugin(name = "SegmentAnalytics")
public class SegmentAnalyticsPlugin extends Plugin {

    private SegmentAnalytics implementation;

    @Override
    public void load() {
        implementation = new SegmentAnalytics(getContext(), getBridge());
    }

    @PluginMethod(returnType = PluginMethod.RETURN_NONE)
    public void initialize(PluginCall call) {
        if (implementation.initialized) {
            call.reject("Segment is already initialized");
            return;
        }
        String writeKey = call.getString("writeKey");
        if (writeKey == null) {
            call.reject("Write key is required to initialize plugin");
            return;
        }
        Boolean trackLifecycleEvents = call.getBoolean("trackLifecycleEvents", false);
        Boolean recordScreenViews = call.getBoolean("recordScreenViews", false);

        implementation.initialize(writeKey, trackLifecycleEvents, recordScreenViews);
        call.resolve();
    }

    @PluginMethod(returnType = PluginMethod.RETURN_NONE)
    public void identify(PluginCall call) {
        if (!implementation.initialized) {
            call.reject("Segment is not initialized");
            return;
        }
        String userId = call.getString("userId");
        if (userId == null) {
            call.reject("User ID is required for identify");
            return;
        }
        JSObject traits = call.getObject("traits");
        JSObject options = call.getObject("options");

        implementation.identify(userId, traits, options);
        call.resolve();
    }

    @PluginMethod(returnType = PluginMethod.RETURN_NONE)
    public void track(PluginCall call) {
        if (!implementation.initialized) {
            call.reject("Segment is not initialized");
            return;
        }
        String eventName = call.getString("eventName");
        if (eventName == null) {
            call.reject("Event name is not supplied");
            return;
        }
        JSObject properties = call.getObject("properties");
        JSObject options = call.getObject("options");

        implementation.track(eventName, properties, options);
        call.resolve();
    }

    @PluginMethod(returnType = PluginMethod.RETURN_NONE)
    public void screen(PluginCall call) {
        if (!implementation.initialized) {
            call.reject("Segment is not initialized");
            return;
        }
        String screenName = call.getString("screenName");
        String category = call.getString("category");
        if (screenName == null) {
            call.reject("Screen name must be supplied");
            return;
        }
        JSObject properties = call.getObject("properties");
        JSObject options = call.getObject("options");

        implementation.screen(category, screenName, properties, options);
        call.resolve();
    }

    @PluginMethod(returnType = PluginMethod.RETURN_NONE)
    public void page(PluginCall call) {
        if (!implementation.initialized) {
            call.reject("Segment is not initialized");
            return;
        }
        String pageName = call.getString("pageName");
        String category = call.getString("category");
        if (pageName == null) {
            call.reject("Page name must be supplied");
            return;
        }
        JSObject properties = call.getObject("properties");
        JSObject options = call.getObject("options");

        implementation.screen(category, pageName, properties, options);
        call.resolve();
    }

    @PluginMethod(returnType = PluginMethod.RETURN_NONE)
    public void group(PluginCall call) {
        if (!implementation.initialized) {
            call.reject("Segment is not initialized");
            return;
        }
        String userId = call.getString("userId");
        String groupId = call.getString("groupId");
        if (userId == null || groupId == null) {
            call.reject("User ID and Group ID are required");
            return;
        }
        JSObject traits = call.getObject("traits");
        JSObject options = call.getObject("options");

        implementation.group(userId, groupId, traits, options);
        call.resolve();
    }

    @PluginMethod(returnType = PluginMethod.RETURN_NONE)
    public void alias(PluginCall call) {
        if (!implementation.initialized) {
            call.reject("Segment is not initialized");
            return;
        }
        String newId = call.getString("newId");
        if (newId == null) {
            call.reject("New User ID is required");
            return;
        }
        JSObject options = call.getObject("options");

        implementation.alias(newId, options);
        call.resolve();
    }

    @PluginMethod(returnType = PluginMethod.RETURN_NONE)
    public void reset(PluginCall call) {
        if (!implementation.initialized) {
            call.reject("Segment is not initialized");
            return;
        }

        implementation.reset();
        call.resolve();
    }
}

package cl.payflowchile.capacitor.segmentanalytics;

import android.app.Activity;
import android.content.Context;
import android.util.Log;
import com.getcapacitor.JSObject;
import com.segment.analytics.Analytics;
import com.segment.analytics.Analytics.Builder;
import com.segment.analytics.Options;
import com.segment.analytics.Properties;
import com.segment.analytics.Traits;
import com.segment.analytics.android.integrations.firebase.FirebaseIntegration;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import org.json.JSONException;

public class SegmentAnalytics {

    private static final String TAG = "SegmentAnalytics";

    public Analytics analytics;
    private final Context context;
    private final Activity activity;

    public boolean initialized = false;

    SegmentAnalytics(Context context, Activity activity) {
        this.context = context;
        this.activity = activity;
    }

    public void initialize(String writeKey, Boolean trackLifecycleEvents, Boolean recordScreenViews) {
        Builder builder = new Analytics.Builder(this.context, writeKey);
        builder.use(FirebaseIntegration.FACTORY);
        if (trackLifecycleEvents) {
            builder.trackApplicationLifecycleEvents();
        }
        if (recordScreenViews) {
            builder.recordScreenViews();
        }
        this.activity.runOnUiThread(
                () -> {
                    analytics = builder.build();
                    initialized = true;
                }
            );
    }

    public void identify(String userId, JSObject traits, JSObject options) {
        this.analytics.identify(userId, makeTraitsFromMap(makeMapFromJSON(traits)), makeOptionsFromJSON(options));
    }

    public void track(String eventName, JSObject properties, JSObject options) {
        this.analytics.track(eventName, makePropertiesFromMap(makeMapFromJSON(properties)), makeOptionsFromJSON(options));
    }

    public void screen(String category, String screenName, JSObject properties, JSObject options) {
        this.analytics.screen(category, screenName, makePropertiesFromMap(makeMapFromJSON(properties)), makeOptionsFromJSON(options));
    }

    public void group(String userId, String groupId, JSObject traits, JSObject options) {
        this.analytics.group(groupId, makeTraitsFromMap(makeMapFromJSON(traits)), makeOptionsFromJSON(options));
    }

    public void alias(String newId, JSObject options) {
        this.analytics.alias(newId, makeOptionsFromJSON(options));
    }

    public void reset() {
        this.analytics.reset();
    }

    private Map<String, Object> makeMapFromJSON(JSObject obj) {
        Iterator<String> keys = obj.keys();
        Map<String, Object> map = new HashMap<>();
        while (keys.hasNext()) {
            String key = keys.next();
            try {
                Object value = obj.get(key);
                map.put(key, value);
            } catch (JSONException e) {
                Log.d(TAG, "could not get value for key " + key);
            }
        }
        return map;
    }

    private Traits makeTraitsFromMap(Map<String, Object> map) {
        Traits traits = new Traits();
        traits.putAll(map);
        return traits;
    }

    private Properties makePropertiesFromMap(Map<String, Object> map) {
        Properties properties = new Properties();
        properties.putAll(map);
        return properties;
    }

    private Options makeOptionsFromJSON(JSObject obj) {
        Options options = new Options();
        Iterator<String> keys = obj.keys();
        while (keys.hasNext()) {
            String key = keys.next();
            try {
                boolean enabled = obj.getBool(key);
                options.setIntegration(key, enabled);
            } catch (Exception e) {
                Log.d(TAG, "could not get boolean for key " + key);
            }
        }
        return options;
    }
}

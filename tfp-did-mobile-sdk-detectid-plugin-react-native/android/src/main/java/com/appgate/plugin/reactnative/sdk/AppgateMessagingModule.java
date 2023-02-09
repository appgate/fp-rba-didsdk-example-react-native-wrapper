package com.appgate.plugin.reactnative.sdk;

import android.content.Context;

import androidx.annotation.NonNull;

import com.appgate.appgate_sdk.data.device.provider.PushNotificationProvider;
import com.appgate.didm_auth.DetectID;

import java.util.Map;

public class AppgateMessagingModule {

    public void onMessageReceived(Context context,Map<String, String> data) {
        if (data != null && DetectID.sdk(context).isValidPayload(data)) {
            DetectID.sdk(context).subscribePayload(data);
        }
    }

    public void onNewTokenFcm(Context context, @NonNull String token) {
        DetectID.sdk(context).receivePushServiceId(token, PushNotificationProvider.FIREBASE);
    }

    public void onNewTokenHms(Context context, @NonNull String token) {
        DetectID.sdk(context).receivePushServiceId(token, PushNotificationProvider.HUAWEI);
    }
}

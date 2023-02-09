package com.appgate.plugin.reactnative.util;

import static com.appgate.plugin.reactnative.util.LogConstants.RN_TRANSACTION_INFO;
import static com.appgate.plugin.reactnative.util.LogConstants.RN_TYPE_PUSH;
import static com.appgate.plugin.reactnative.util.TransactionInfoDomain.mapFromModelSDK;

import android.app.Activity;
import android.app.Application;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.appgate.appgate_sdk.data.utils.GsonUtil;
import com.appgate.didm_auth.DetectID;

public class DIDActivityLifecycle implements Application.ActivityLifecycleCallbacks {

    @Override
    public void onActivityCreated(@NonNull Activity activity, @Nullable Bundle savedInstanceState) {
        try {
            if (activity.getLocalClassName().equals("com.appgate.didm_auth.push_auth.alert.PushAlertActivity")) {
                DetectID.sdk(activity).getPushApi().setPushAlertOpenListener(transactionInfo -> callMainActivity(activity, GsonUtil.toJson(mapFromModelSDK(transactionInfo)), DIDTypePush.PUSH_ALERT));
            }
            if (activity.getLocalClassName().equals("com.appgate.didm_auth.push_auth.transaction.PushTransactionActivity")) {
                DetectID.sdk(activity).getPushApi().setPushTransactionOpenListener(transactionInfo -> callMainActivity(activity, GsonUtil.toJson(mapFromModelSDK(transactionInfo)), DIDTypePush.PUSH_AUTH));
            }
        } catch (Exception e) {
            Log.e("error", e.getMessage());
        }
    }

    private void callMainActivity(Activity activity, String transactionInfo, DIDTypePush didTypePush) {
        String packageName = activity.getPackageName();
        Intent launchIntent = activity.getPackageManager().getLaunchIntentForPackage(packageName);
        String className = launchIntent.getComponent().getClassName();
        try {
            Class<?> activityClass = Class.forName(className);
            Intent activityIntent = new Intent(activity, activityClass);
            activityIntent.putExtra(RN_TRANSACTION_INFO, transactionInfo);
            activityIntent.putExtra(RN_TYPE_PUSH, didTypePush.getCode());
            activityIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            activity.startActivity(activityIntent);
        } catch (Exception e) {
            Log.e("", "Class not found", e);
        }
    }

    @Override
    public void onActivityStarted(@NonNull Activity activity) {

    }

    @Override
    public void onActivityResumed(@NonNull Activity activity) {

    }

    @Override
    public void onActivityPaused(@NonNull Activity activity) {

    }

    @Override
    public void onActivityStopped(@NonNull Activity activity) {

    }

    @Override
    public void onActivitySaveInstanceState(@NonNull Activity activity, @NonNull Bundle outState) {

    }

    @Override
    public void onActivityDestroyed(@NonNull Activity activity) {

    }
}

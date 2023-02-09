package com.appgate.plugin.reactnative.module;

import static com.appgate.appgate_sdk.data.utils.GsonUtil.fromJson;
import static com.appgate.appgate_sdk.data.utils.GsonUtil.toJson;
import static com.appgate.plugin.reactnative.util.LogConstants.NAME_MODULE_PUSH;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.appgate.didm_auth.DetectID;
import com.appgate.didm_auth.push_auth.alert.PushAlertViewProperties;
import com.appgate.didm_auth.push_auth.transaction.views.PushTransactionViewProperties;
import com.appgate.plugin.reactnative.R;
import com.appgate.plugin.reactnative.util.TransactionInfoDomain;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;

public class PushModule extends ReactContextBaseJavaModule {

    public PushModule(@Nullable ReactApplicationContext reactContext) {
        super(reactContext);

        PushTransactionViewProperties pushTransactionViewProperties = DetectID.sdk(reactContext).getPushTransactionViewPropertiesInstance();
        pushTransactionViewProperties.setConfirm("Confirm");
        pushTransactionViewProperties.setDecline("Decline");
        pushTransactionViewProperties.setConfirmIconResource(R.drawable.ic_baseline_check_24);
        pushTransactionViewProperties.setDeclineIconResource(R.drawable.ic_baseline_clear_24);
        pushTransactionViewProperties.setNotificationIconResource(R.drawable.ic_baseline_face_24);
        pushTransactionViewProperties.setEnableNotificationQuickActions(true);
        DetectID.sdk(reactContext).getPushApi().setPushTransactionViewProperties(pushTransactionViewProperties);

        PushAlertViewProperties pushAlertViewProperties = new PushAlertViewProperties(reactContext);
        pushAlertViewProperties.setNotificationIconResource(R.drawable.ic_baseline_push_24);
        pushAlertViewProperties.setApprove("Approve");
        DetectID.sdk(reactContext).getPushApi().setPushAlertViewProperties(pushAlertViewProperties);

    }

    @ReactMethod
    public void setPushTransactionOpenListener(@NonNull Callback callback) {
        DetectID.sdk(getCurrentActivity()).getPushApi().setPushTransactionOpenListener(transactionInfo -> {
            String data = toJson(TransactionInfoDomain.mapFromModelSDK(transactionInfo));
            callback.invoke(data);
        });
    }

    @ReactMethod
    public void setPushTransactionServerResponseListener(@NonNull Callback callback) {
        DetectID.sdk(getCurrentActivity()).getPushApi().setPushTransactionServerResponseListener(callback::invoke);
    }

    @ReactMethod
    public void setPushAlertReceivedListener(@NonNull Callback callback) {
        DetectID.sdk(getCurrentActivity()).getPushApi().setPushAlertReceivedListener(transactionInfo -> {
            String data = toJson(TransactionInfoDomain.mapFromModelSDK(transactionInfo));
            callback.invoke(data);
        });
    }

    @ReactMethod
    public void setPushTransactionReceivedListener(@NonNull Callback callback) {
        DetectID.sdk(getCurrentActivity()).getPushApi().setPushTransactionReceivedListener(transactionInfo -> {
            String data = toJson(TransactionInfoDomain.mapFromModelSDK(transactionInfo));
            callback.invoke(data);
        });
    }

    @ReactMethod
    public void setPushAlertOpenListener(@NonNull Callback callback) {
        DetectID.sdk(getCurrentActivity()).getPushApi().setPushAlertOpenListener(transactionInfo -> {
            String data = toJson(TransactionInfoDomain.mapFromModelSDK(transactionInfo));
            callback.invoke(data);
        });
    }

    @ReactMethod
    public void confirmPushTransactionAction(String data) {
        TransactionInfoDomain transactionInfo = fromJson(data, TransactionInfoDomain.class);
        DetectID.sdk(getCurrentActivity()).getPushApi().confirmPushTransactionAction(transactionInfo.getTransaction());
    }

    @ReactMethod
    public void declinePushTransactionAction(String data) {
        TransactionInfoDomain transactionInfo = fromJson(data, TransactionInfoDomain.class);
        DetectID.sdk(getCurrentActivity()).getPushApi().declinePushTransactionAction(transactionInfo.getTransaction());
    }

    @ReactMethod
    public void approvePushAlertAction(String data) {
        TransactionInfoDomain transactionInfo = fromJson(data, TransactionInfoDomain.class);
        DetectID.sdk(getCurrentActivity()).getPushApi().approvePushAlertAction(transactionInfo.getTransaction());
    }


    @NonNull
    @Override
    public String getName() {
        return NAME_MODULE_PUSH;
    }
}

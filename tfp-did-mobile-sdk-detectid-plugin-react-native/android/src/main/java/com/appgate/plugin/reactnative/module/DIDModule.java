package com.appgate.plugin.reactnative.module;

import static com.appgate.appgate_sdk.data.utils.GsonUtil.fromJson;
import static com.appgate.plugin.reactnative.util.LogConstants.NAME_MODULE_DID;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.appgate.appgate_sdk.data.device.provider.PushNotificationProvider;
import com.appgate.appgate_sdk.encryptor.exceptions.SDKException;
import com.appgate.didm_auth.DetectID;
import com.appgate.didm_auth.common.account.entities.Account;
import com.appgate.didm_auth.common.handler.EnrollmentResultHandler;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;

import java.util.Map;


public class DIDModule extends ReactContextBaseJavaModule {

    public DIDModule(@Nullable ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @ReactMethod
    public void didRegistration(String url, Promise promise) {
        DetectID.sdk(getCurrentActivity()).didRegistration(url, new EnrollmentResultHandler() {
            @Override
            public void onSuccess() {
                promise.resolve(null);
            }

            @Override
            public void onFailure(SDKException e) {
                promise.reject(String.valueOf(e.getCode()), e.getMessage());
            }
        });
    }

    @ReactMethod
    public void didRegistrationByQRCode(String data, Promise promise) {
        DetectID.sdk(getCurrentActivity()).didRegistrationByQRCode(data, null, new EnrollmentResultHandler() {
            @Override
            public void onSuccess() {
                promise.resolve(null);
            }

            @Override
            public void onFailure(SDKException e) {
                promise.reject(String.valueOf(e.getCode()), e.getMessage());
            }
        });
    }

    @ReactMethod
    public void updateGlobalConfig(String accountString) {
        Account account = fromJson(accountString, Account.class);
        DetectID.sdk(getCurrentActivity()).updateGlobalConfig(account);
    }

    @ReactMethod
    public void isValidPayload(Map<String, String> data, Callback callback) {
        callback.invoke(DetectID.sdk(getCurrentActivity()).isValidPayload(data));
    }

    @ReactMethod
    public void subscribePayload(Map<String, String> data) {
        DetectID.sdk(getCurrentActivity()).subscribePayload(data);
    }

    @ReactMethod
    public void receivePushServiceId(String data) {
        DetectID.sdk(getCurrentActivity()).receivePushServiceId(data, PushNotificationProvider.FIREBASE);
    }

    @ReactMethod
    public void setApplicationName(String name) {
        DetectID.sdk(getCurrentActivity()).setApplicationName(name);
    }

    @ReactMethod
    public void getDeviceID(@NonNull Callback callback) {
        callback.invoke(DetectID.sdk(getCurrentActivity()).getDeviceID());
    }

    @ReactMethod
    public void getMaskedAppInstanceID(@NonNull Callback callback) {
        callback.invoke(DetectID.sdk(getCurrentActivity()).getMaskedAppInstanceID());
    }

    @ReactMethod
    public void getMobileID(@NonNull Callback callback) {
        callback.invoke(DetectID.sdk(getCurrentActivity()).getMobileID());
    }

    @NonNull
    @Override
    public String getName() {
        return NAME_MODULE_DID;
    }
}

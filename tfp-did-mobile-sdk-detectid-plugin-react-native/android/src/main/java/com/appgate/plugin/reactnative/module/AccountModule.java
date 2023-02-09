package com.appgate.plugin.reactnative.module;

import static com.appgate.appgate_sdk.data.utils.GsonUtil.fromJson;
import static com.appgate.appgate_sdk.data.utils.GsonUtil.toJson;
import static com.appgate.plugin.reactnative.util.LogConstants.NAME_MODULE_ACCOUNTS;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.appgate.didm_auth.DetectID;
import com.appgate.didm_auth.common.account.entities.Account;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;

public class AccountModule extends ReactContextBaseJavaModule {
    private static final String ERROR_MSG = "Account error";
    private static final String ERROR_CODE = "100";

    public AccountModule(@Nullable ReactApplicationContext reactContext) {
        super(reactContext);

    }

    @ReactMethod
    public void getAccounts(@NonNull Callback callback) {
        if (DetectID.sdk(getCurrentActivity()).existAccounts())
            callback.invoke(toJson(DetectID.sdk(getCurrentActivity()).getAccounts()));
        else
            callback.invoke("");
    }

    @ReactMethod
    public void getAccount(@NonNull Callback callback) {
        if (DetectID.sdk(getCurrentActivity()).existAccounts())
            callback.invoke(toJson(DetectID.sdk(getCurrentActivity()).getAccounts().get(0)));
        else
            callback.invoke("");
    }

    @ReactMethod
    public void existAccounts(@NonNull Callback callback) {
        callback.invoke(toJson(DetectID.sdk(getCurrentActivity()).existAccounts()));
    }

    @ReactMethod
    public void removeAccount(String accountString, @NonNull Promise promise) {
        if (accountString != null && DetectID.sdk(getCurrentActivity()).existAccounts()) {
            Account account = fromJson(accountString, Account.class);
            if (account != null) {
                DetectID.sdk(getCurrentActivity()).removeAccount(account);
                promise.resolve(null);
            } else
                promise.reject(ERROR_CODE, ERROR_MSG);
        } else
            promise.reject(ERROR_CODE, ERROR_MSG);
    }

    @ReactMethod
    public void setAccountUsername(String name, String accountString, @NonNull Promise promise) {
        if (accountString != null && DetectID.sdk(getCurrentActivity()).existAccounts()) {
            Account account = fromJson(accountString, Account.class);
            if (account != null) {
                DetectID.sdk(getCurrentActivity()).setAccountUsername(account, name);
                promise.resolve(null);
            }else
                promise.reject(ERROR_CODE, ERROR_MSG);
        } else
            promise.reject(ERROR_CODE, ERROR_MSG);
    }

    @NonNull
    @Override
    public String getName() {
        return NAME_MODULE_ACCOUNTS;
    }
}

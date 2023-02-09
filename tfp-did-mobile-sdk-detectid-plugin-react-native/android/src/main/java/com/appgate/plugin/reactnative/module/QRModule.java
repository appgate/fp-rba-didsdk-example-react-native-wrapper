package com.appgate.plugin.reactnative.module;

import static com.appgate.appgate_sdk.data.utils.GsonUtil.fromJson;
import static com.appgate.appgate_sdk.data.utils.GsonUtil.toJson;
import static com.appgate.plugin.reactnative.util.LogConstants.NAME_MODULE_QR;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.appgate.didm_auth.DetectID;
import com.appgate.didm_auth.common.account.entities.Account;
import com.appgate.plugin.reactnative.util.TransactionInfoDomain;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;

public class QRModule extends ReactContextBaseJavaModule {

    public QRModule(@Nullable ReactApplicationContext reactContext) {
        super(reactContext);

    }

    @ReactMethod
    public void qrAuthenticationProcess(String accountString, String data, Promise promise) {
        Account account = fromJson(accountString, Account.class);
        DetectID.sdk(getCurrentActivity()).getQrApi().setQRCodeScanTransactionListener(transactionInfo -> {
            transactionInfo.setAccount(account);
            promise.resolve(toJson(TransactionInfoDomain.mapFromModelSDK(transactionInfo)));
        });
        DetectID.sdk(getCurrentActivity()).getQrApi().setQRCodeTransactionServerResponseListener(s -> promise.reject(s, s));
        DetectID.sdk(getCurrentActivity()).getQrApi().qrAuthenticationProcess(account, data);
    }

    @ReactMethod
    public void confirmQRCodeTransactionAction(String data, @NonNull Callback callback) {
        TransactionInfoDomain transactionInfo = fromJson(data, TransactionInfoDomain.class);
        DetectID.sdk(getCurrentActivity()).getQrApi().setQRCodeTransactionServerResponseListener(callback::invoke);
        DetectID.sdk(getCurrentActivity()).getQrApi().confirmQRCodeTransactionAction(transactionInfo.getTransaction());
    }

    @ReactMethod
    public void declineQRCodeTransactionAction(String data, @NonNull Callback callback) {
        TransactionInfoDomain transactionInfo = fromJson(data, TransactionInfoDomain.class);
        DetectID.sdk(getCurrentActivity()).getQrApi().setQRCodeTransactionServerResponseListener(callback::invoke);
        DetectID.sdk(getCurrentActivity()).getQrApi().declineQRCodeTransactionAction(transactionInfo.getTransaction());
    }


    @NonNull
    @Override
    public String getName() {
        return NAME_MODULE_QR;
    }
}

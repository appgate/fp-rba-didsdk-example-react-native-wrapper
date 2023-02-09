package com.appgate.plugin.reactnative.module;

import static com.appgate.appgate_sdk.data.utils.GsonUtil.fromJson;
import static com.appgate.plugin.reactnative.util.LogConstants.NAME_MODULE_OTP;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.appgate.didm_auth.DetectID;
import com.appgate.didm_auth.common.account.entities.Account;
import com.appgate.didm_auth.otp_auth.ocra.OtpToken;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;

public class OtpModule extends ReactContextBaseJavaModule {

    public OtpModule(@Nullable ReactApplicationContext reactContext) {
        super(reactContext);

    }

    @ReactMethod
    public void getTokenValue(String accountString, @NonNull Callback callback) {
        if (accountString != null) {
            Account account = fromJson(accountString, Account.class);
            if (account != null)
                callback.invoke(DetectID.sdk(getCurrentActivity()).getOtpApi().getTokenValue(account));
        }
    }

    @ReactMethod
    public void getTokenTimeStepValue(String accountString, @NonNull Callback callback) {
        if (accountString != null) {
            Account account = fromJson(accountString, Account.class);
            if (account != null)
                callback.invoke(DetectID.sdk(getCurrentActivity()).getOtpApi().getTokenTimeStepValue(account));
        }
    }

    @ReactMethod
    public void getChallengeQuestionOtp(String accountString, String answer, @NonNull Callback callback) {
        if (accountString != null) {
            Account account = fromJson(accountString, Account.class);
            if (account != null) {
                final OtpToken challengeQuestionOtp = DetectID.sdk(getCurrentActivity()).getChallengeOtpApi().getChallengeQuestionOtp(account, answer, null, null);
                callback.invoke(challengeQuestionOtp != null ? challengeQuestionOtp.getTokenValue() : "");
            } else
                callback.invoke("");
        } else
            callback.invoke("");
    }


    @NonNull
    @Override
    public String getName() {
        return NAME_MODULE_OTP;
    }
}

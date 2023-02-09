package com.appgate.plugin.reactnative;

import androidx.annotation.NonNull;

import com.appgate.plugin.reactnative.module.AccountModule;
import com.appgate.plugin.reactnative.module.DIDModule;
import com.appgate.plugin.reactnative.module.OtpModule;
import com.appgate.plugin.reactnative.module.PushModule;
import com.appgate.plugin.reactnative.module.QRModule;
import com.facebook.react.ReactPackage;
import com.facebook.react.bridge.NativeModule;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.uimanager.ViewManager;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class DIDPackage implements ReactPackage {

    @NonNull
    @Override
    public List<NativeModule> createNativeModules(@NonNull ReactApplicationContext reactApplicationContext) {
        List<NativeModule> modules = new ArrayList<>();
        modules.add(new DIDModule(reactApplicationContext));
        modules.add(new OtpModule(reactApplicationContext));
        modules.add(new AccountModule(reactApplicationContext));
        modules.add(new QRModule(reactApplicationContext));
        modules.add(new PushModule(reactApplicationContext));
        return modules;
    }

    @NonNull
    @Override
    public List<ViewManager> createViewManagers(@NonNull ReactApplicationContext reactApplicationContext) {
        return Collections.emptyList();
    }
}

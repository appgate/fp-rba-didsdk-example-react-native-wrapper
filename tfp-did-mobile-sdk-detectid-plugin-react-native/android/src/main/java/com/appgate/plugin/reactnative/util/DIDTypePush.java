package com.appgate.plugin.reactnative.util;


public enum DIDTypePush {
    PUSH_ALERT(0),
    PUSH_AUTH(1),
    QR_AUTH(2);

    private final int code;

    DIDTypePush(int code) {
        this.code = code;
    }

    public int getCode() {
        return code;
    }
}

package com.appgate.plugin.reactnative.entities;

public class DidSdkError {
    private int code;
    private String message;

    public DidSdkError() {
    }

    public DidSdkError(int code, String message) {
        this.code = code;
        this.message = message;
    }

    public int getCode() {
        return code;
    }
    public String getMessage() {
        return message;
    }

}

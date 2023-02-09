package com.appgate.plugin.reactnative.util;

import com.appgate.didm_auth.common.account.entities.Account;
import com.appgate.didm_auth.common.transaction.TransactionInfo;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

public class TransactionInfoDomain {
    private String transactionID;
    private String timeStamp;
    private String subject;
    private String message;
    private String subjectNotification;
    private String messageNotification;
    private String urlToResponse;
    private TransactionInfo.TransactionType type;
    private TransactionInfo.BiometricTransactionType biometricTransactionType;
    private TransactionInfo.TransactionStatus status;
    private String transactionOfflineCode;
    private Account account;
    private TransactionInfo transaction;


    public TransactionInfoDomain() {
    }

    public TransactionInfoDomain(String transactionID, String timeStamp, String subject, String message, String subjectNotification, String messageNotification, String urlToResponse, TransactionInfo.TransactionType type, TransactionInfo.BiometricTransactionType biometricTransactionType, TransactionInfo.TransactionStatus status, String transactionOfflineCode, Account account,TransactionInfo transactionInfo) {
        this.transactionID = transactionID;
        this.timeStamp = timeStamp;
        this.subject = subject;
        this.message = message;
        this.subjectNotification = subjectNotification;
        this.messageNotification = messageNotification;
        this.urlToResponse = urlToResponse;
        this.type = type;
        this.biometricTransactionType = biometricTransactionType;
        this.status = status;
        this.account = account;
        this.transactionOfflineCode = transactionOfflineCode;
        this.transaction = transactionInfo;
    }

    public static TransactionInfoDomain mapFromModelSDK(TransactionInfo model) {
        return new TransactionInfoDomain(
                model.getTransactionID(),
                new SimpleDateFormat("dd/MM/yyyy - hh:mm aa", Locale.getDefault())
                        .format(new Date(model.getTimeStamp())),
                model.getSubject(),
                model.getMessage(),
                model.getSubjectNotification(),
                model.getMessageNotification(),
                model.getUrlToResponse(),
                model.getType(),
                model.getBiometricTransactionType(),
                model.getStatus(),
                model.getTransactionOfflineCode(),
                model.getAccount(),
                model
        );
    }

    public String getTransactionID() {
        return transactionID;
    }

    public String getTimeStamp() {
        return timeStamp;
    }

    public String getSubject() {
        return subject;
    }

    public String getMessage() {
        return message;
    }

    public String getSubjectNotification() {
        return subjectNotification;
    }

    public String getMessageNotification() {
        return messageNotification;
    }

    public String getUrlToResponse() {
        return urlToResponse;
    }

    public TransactionInfo.TransactionType getType() {
        return type;
    }

    public TransactionInfo.BiometricTransactionType getBiometricTransactionType() {
        return biometricTransactionType;
    }

    public TransactionInfo.TransactionStatus getStatus() {
        return status;
    }

    public String getTransactionOfflineCode() {
        return transactionOfflineCode;
    }

    public Account getAccount() {
        return account;
    }

    public TransactionInfo getTransaction() {
        return transaction;
    }
}

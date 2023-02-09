//
//  OtpModule.swift
//  DIDReact
//
//  Created by Camilo Ortegon on 10/11/22.
//

import Foundation
import didm_sdk

@objc(QrModule)
class QrModule: NSObject, QRCodeScanTransactionDelegate, QRCodeTransactionServerResponseDelegate {
    
    private var qrAuthenticationCodeReadResolve : RCTPromiseResolveBlock?
    private var qrAuthenticationCodeReadReject : RCTPromiseRejectBlock?
    private var qrCodeTransactionActionCallback : RCTResponseSenderBlock?
    
    @objc
    static func requiresMainQueueSetup() ->Bool {
        return false;
    }
    
    @objc
    public func qrAuthenticationProcess(_ accountJson: String, qrDataCaptured: String, resolve:@escaping RCTPromiseResolveBlock, reject:@escaping RCTPromiseRejectBlock) {
        self.qrAuthenticationCodeReadResolve = resolve
        self.qrAuthenticationCodeReadReject = reject
        let account = try? CodableConverter.getCodable(jsonString: accountJson) as Account
        (DetectID.sdk() as! DetectID).getQrApi().qrCodeTransactionServerResponseDelegate = self
        (DetectID.sdk() as! DetectID).getQrApi().qrCodeScanTransactionDelegate = self
        (DetectID.sdk() as! DetectID).getQrApi().qrAuthenticationProcess(account, withQrContent: qrDataCaptured)
    }
    
    @objc
    public func confirmQRCodeTransactionAction(_ transactionInfoJson: String, callback: @escaping RCTResponseSenderBlock) {
        self.qrCodeTransactionActionCallback = callback
        (DetectID.sdk() as! DetectID).getQrApi().qrCodeTransactionServerResponseDelegate = self
        (DetectID.sdk() as! DetectID).getQrApi().confirmQRCodeTransactionAction(TransactionInfoConverter.fromJsonStringToObject(transactionInfo: transactionInfoJson))
    }
    
    @objc
    public func declineQRCodeTransactionAction(_ transactionInfoJson: String, callback: @escaping RCTResponseSenderBlock) {
        self.qrCodeTransactionActionCallback = callback
        (DetectID.sdk() as! DetectID).getQrApi().qrCodeTransactionServerResponseDelegate = self
        (DetectID.sdk() as! DetectID).getQrApi().declineQRCodeTransactionAction(TransactionInfoConverter.fromJsonStringToObject(transactionInfo: transactionInfoJson))
    }
    
    func onQRCodeScanTransaction(_ transaction: TransactionInfo!) {
        if (qrAuthenticationCodeReadResolve != nil) {
            qrAuthenticationCodeReadResolve!([TransactionInfoConverter.fromObjectToJsonString(transactionInfo: transaction) as Any])
            qrAuthenticationCodeReadResolve = nil
            qrAuthenticationCodeReadReject = nil
        }
    }
    
    func onQRCodeTransactionServerResponse(_ response: String!) {
        if (qrAuthenticationCodeReadReject != nil) {
            let error = QRAuthenticationCodeReadError.serverError
            qrAuthenticationCodeReadReject!(response, error.description, error)
            qrAuthenticationCodeReadResolve = nil
            qrAuthenticationCodeReadReject = nil
        }
        if (qrCodeTransactionActionCallback != nil) {
            qrCodeTransactionActionCallback!([response!])
            qrCodeTransactionActionCallback = nil
        }
    }
}



//
//  OtpModule.m
//  DIDReact
//
//  Created by Camilo Ortegon on 10/12/22.
//

#import <Foundation/Foundation.h>

#import "React/RCTBridgeModule.h"
#import "React/RCTEventEmitter.h"

@interface RCT_EXTERN_MODULE(QrModule, NSObject)

RCT_EXTERN_METHOD(qrAuthenticationProcess:(NSString *) accountJson
    qrDataCaptured:(NSString *) qrDataCaptured
    resolve:(RCTPromiseResolveBlock)resolve
    reject:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(confirmQRCodeTransactionAction:
    (NSString *) transactionInfoJson
    callback: (RCTResponseSenderBlock)callback)

RCT_EXTERN_METHOD(declineQRCodeTransactionAction:
    (NSString *) transactionInfoJson
    callback: (RCTResponseSenderBlock)callback)

@end


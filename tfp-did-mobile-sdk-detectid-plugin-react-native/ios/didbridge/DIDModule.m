//
//  DIDModule.m
//  DIDReact
//
//  Created by Camilo Ortegon on 10/7/22.
//

#import <Foundation/Foundation.h>

#import "React/RCTBridgeModule.h"
#import "React/RCTEventEmitter.h"

@interface RCT_EXTERN_MODULE(DIDModule,NSObject)

RCT_EXTERN_METHOD(getDeviceID:(RCTResponseSenderBlock)callback)
RCT_EXTERN_METHOD(getMaskedAppInstanceID:(RCTResponseSenderBlock)callback)
RCT_EXTERN_METHOD(getMobileID:(RCTResponseSenderBlock)callback)
RCT_EXTERN_METHOD(didRegistration:(NSString)url resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject)
RCT_EXTERN_METHOD(didRegistrationByQRCode:(NSString)url resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject)
RCT_EXTERN_METHOD(updateGlobalConfig:(NSString)accountJson)
RCT_EXTERN_METHOD(isValidPayload:(NSDictionary)payload callback:(RCTResponseSenderBlock)callback)
RCT_EXTERN_METHOD(subscribePayload:(NSDictionary)payload)
RCT_EXTERN_METHOD(receivePushServiceId:(NSString)data)
RCT_EXTERN_METHOD(setApplicationName:(NSString)data)

@end

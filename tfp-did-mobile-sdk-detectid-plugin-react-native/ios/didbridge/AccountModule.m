//
//  AccountModule.m
//  DIDReact
//
//  Created by Camilo Ortegon on 10/11/22.
//

#import <Foundation/Foundation.h>

#import "React/RCTBridgeModule.h"
#import "React/RCTEventEmitter.h"

@interface RCT_EXTERN_MODULE(AccountModule,NSObject)

RCT_EXTERN_METHOD(existAccounts:(RCTResponseSenderBlock)callback)
RCT_EXTERN_METHOD(getAccounts:(RCTResponseSenderBlock)callback)
RCT_EXTERN_METHOD(removeAccount:(NSString)accountJson resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject)
RCT_EXTERN_METHOD(setAccountUsername:(NSString)name accountJson:(NSString)accountJson resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject)

@end

//
//  OtpModule.m
//  DIDReact
//
//  Created by Camilo Ortegon on 10/12/22.
//

#import <Foundation/Foundation.h>

#import "React/RCTBridgeModule.h"
#import "React/RCTEventEmitter.h"

@interface RCT_EXTERN_MODULE(OtpModule,NSObject)

RCT_EXTERN_METHOD(getTokenValue:(NSString *)accountJson callback:(RCTResponseSenderBlock)callback)
RCT_EXTERN_METHOD(getTokenTimeStepValue:(NSString *)accountJson callback:(RCTResponseSenderBlock)callback)
RCT_EXTERN_METHOD(getChallengeQuestionOtp:(NSString *)accountJson answer:(NSString *)answer callback:(RCTResponseSenderBlock)callback)

@end

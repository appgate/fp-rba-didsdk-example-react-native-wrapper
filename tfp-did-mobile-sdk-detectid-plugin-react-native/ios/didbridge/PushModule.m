//
//  PushModule.m
//  DIDReact
//
//  Created by Camilo Ortegon on 11/8/22.
//

#import <Foundation/Foundation.h>

#import "React/RCTBridgeModule.h"
#import "React/RCTEventEmitter.h"

@interface RCT_EXTERN_MODULE(PushModule,NSObject)

RCT_EXTERN_METHOD(setPushTransactionOpenListener:(RCTResponseSenderBlock)callback)
RCT_EXTERN_METHOD(setPushAlertOpenListener:(RCTResponseSenderBlock)callback)
RCT_EXTERN_METHOD(setPushTransactionServerResponseListener:(RCTResponseSenderBlock)callback)
RCT_EXTERN_METHOD(confirmPushTransactionAction:(NSString)transaction)
RCT_EXTERN_METHOD(declinePushTransactionAction:(NSString)transaction)
RCT_EXTERN_METHOD(approvePushAlertAction:(NSString)transaction)

@end

//
//  DetectIDSDK.m
//  DIDReact
//
//  Created by Camilo Ortegon on 11/4/22.
//

#import <didm_sdk/didm_sdk.h>
#import "DetectIDSDK.h"
#import "tfp_did_mobile_sdk_detectid_plugin_react_native-Swift.h"

@interface DetectIDSDK()

@property (strong, nonatomic) DIDSDK *DID;

@end


@implementation DetectIDSDK

+ (id)sdk {
    static DetectIDSDK *authSDK = nil;
    @synchronized(self){
        if (authSDK == nil) {
            authSDK = [[self alloc]init];
        }
    }
    
    return authSDK;
}

- (id)init {
    self.DID = [DIDSDK instance];
    return self;
}

- (void)registerForRemoteNotifications:(NSDictionary *)launchOptions {
    [[[DIDSDK alloc] init] registerForRemoteNotifications:self];
    [[DIDSDK instance] subscribePayload:launchOptions];
}

- (void)receivePushServiceId:(NSData*)deviceToken {
    [[DetectID sdk] receivePushServiceId:deviceToken];
}

// MARK: UNUserNotificationCenterDelegate

-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[DetectID sdk] subscribePayload:notification withCompletionHandler:completionHandler];
    });
}

-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler {
    [[DetectID sdk] handleActionWithIdentifier:response];
}

@end

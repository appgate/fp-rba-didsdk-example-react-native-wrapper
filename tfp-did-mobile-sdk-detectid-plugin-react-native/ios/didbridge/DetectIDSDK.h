//
//  DetectIDSDK.h
//  DIDReact
//
//  Created by Camilo Ortegon on 11/4/22.
//

#ifndef DetectIDSDK_h
#define DetectIDSDK_h

#endif /* DetectIDSDK_h */

#import <Foundation/Foundation.h>
#import <UserNotifications/UserNotifications.h>

@interface DetectIDSDK : NSObject<UNUserNotificationCenterDelegate>

+ (id _Nonnull)sdk;
- (void)registerForRemoteNotifications:(NSDictionary *)launchOptions;
- (void)receivePushServiceId:(NSData*)data;

@end

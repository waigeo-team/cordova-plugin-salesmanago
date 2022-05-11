#import <Cordova/CDV.h>
#import "AppDelegate.h"
#import "AMNotification.h"

#ifndef SalesManagoPlugin_h
#define SalesManagoPlugin_h

@interface SalesManagoPlugin : CDVPlugin

- (void) initialize:(CDVInvokedUrlCommand*)command;
- (void) didFinishLaunchingWithOptions:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
- (void) didRegisterForRemoteNotificationsWithDeviceToken:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;
- (void) syncEmail:(CDVInvokedUrlCommand*)command;
- (void) syncPhone:(CDVInvokedUrlCommand*)command;
- (void) syncPushToken:(CDVInvokedUrlCommand*)command;
- (BOOL) loadPayloadForNotification:(NSDictionary *)userInfo andApplication:(UIApplication *)application loadCompletionHandlerWithError:(AMNotificationHandlerWithError)completionHandler;
- (void) didReceiveRemoteNotification:(AMNotification *) notification;

@end

#endif /* SalesManagoPlugin_h */
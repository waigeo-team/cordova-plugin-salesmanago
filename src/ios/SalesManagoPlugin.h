#import <Cordova/CDV.h>
#import "AppDelegate.h"
#import "AMNotification.h"

#ifndef SalesManagoPlugin_h
#define SalesManagoPlugin_h

@interface SalesManagoPlugin : CDVPlugin

- (void) initialize:(CDVInvokedUrlCommand*)command;
- (void) didFinishLaunchingWithOptions:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
//- (void) didReceiveRemoteNotification:(AMNotification *) notification;
- (void) didRegisterForRemoteNotificationsWithDeviceToken:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;
- (void) syncEmail:(CDVInvokedUrlCommand*)command;
- (void) syncPhone:(CDVInvokedUrlCommand*)command;
- (void) syncPushToken:(CDVInvokedUrlCommand*)command;

@end

#endif /* SalesManagoPlugin_h */
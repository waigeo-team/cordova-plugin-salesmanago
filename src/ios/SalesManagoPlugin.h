#import <Cordova/CDV.h>
#import "AppDelegate.h"

#ifndef SalesManagoPlugin_h
#define SalesManagoPlugin_h

@interface SalesManagoPlugin : CDVPlugin

- (void) initialize:(CDVInvokedUrlCommand*)command;
- (void) didFinishLaunchingWithOptions:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
- (void) syncEmail:(NSString *)email;
- (void) syncPhone:(NSString *)phone;

@end

#endif /* SalesManagoPlugin_h */
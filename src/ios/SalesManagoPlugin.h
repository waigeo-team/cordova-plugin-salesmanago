#import <Cordova/CDV.h>
#import "AppDelegate.h"

#ifndef SalesManagoPlugin_h
#define SalesManagoPlugin_h

@interface SalesManagoPlugin : CDVPlugin

- (void) initialize:(CDVInvokedUrlCommand*)command;
- (void) toto:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

@end

#endif /* SalesManagoPlugin_h */
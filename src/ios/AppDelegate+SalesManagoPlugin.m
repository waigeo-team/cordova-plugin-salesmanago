#import "AppDelegate+SalesManagoPlugin.h"
#import "SalesManagoPlugin.h"
#import <objc/runtime.h>

@implementation AppDelegate (SalesManagoPlugin)

// Borrowed from http://nshipster.com/method-swizzling/
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];

        SEL originalSelector = @selector(application:didFinishLaunchingWithOptions:);
        SEL swizzledSelector = @selector(identity_application:didFinishLaunchingWithOptions:);

        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);

        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));

        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (BOOL)identity_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // always call original method implementation first
    BOOL handled = [self identity_application:application didFinishLaunchingWithOptions:launchOptions];

    [UNUserNotificationCenter currentNotificationCenter].delegate = self;

    NSLog(@"DidFinishLaunching");

    // Override point for customization after application launch.
    SalesManagoPlugin* salesManagoPlugin = [self getPluginInstance];
    [salesManagoPlugin didFinishLaunchingWithOptions:application didFinishLaunchingWithOptions:launchOptions];
    
    return handled;
}

- (SalesManagoPlugin*) getPluginInstance {
    return [self.viewController getCommandInstance:@"SalesManagoPlugin"];
}

/*- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    BOOL amPush = [[AMMonitor sharedInstance] loadPayloadForNotification:userInfo andApplication:application loadCompletionHandlerWithError:^(AMNotification *notification, NSError *error) {
        if (error) {
            NSLog(@"Error occured while downloading notification :  %@", [error localizedDescription]);
            completionHandler(UIBackgroundFetchResultNoData);
            return;
        } else {
            completionHandler(UIBackgroundFetchResultNewData);
        }        

        SalesManagoPlugin* salesManagoPlugin = [self getPluginInstance];
        [salesManagoPlugin didReceiveRemoteNotification:notification];
    }];
    
    if (!amPush) {
       // handle not appmanago notifications here
       completionHandler(UIBackgroundFetchResultNewData);
    }
}*/

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    SalesManagoPlugin* salesManagoPlugin = [self getPluginInstance];
    [salesManagoPlugin didRegisterForRemoteNotificationsWithDeviceToken:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

@end
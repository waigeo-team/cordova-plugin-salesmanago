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
    
    /*if (launchOptions) {
        [[AMMonitor sharedInstance] loadPayloadForNotification:launchOptions andApplication:application loadCompletionHandlerWithError:^(AMNotification *notification, NSError *error) {
            if (error) {
                NSLog(@"Error occured while downloading notification :  %@", [error localizedDescription]);
                return;
            }
            // implement your own logic or use default
            [[AMMonitor sharedInstance] handleNotification:notification notificationHandler:nil dialogHandler:dialogHandler urlHandler:nil inAppHandler:nil];
        }];
    }
    
    // only for iOS > 8 (implentation for previous version omitted)
    UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    [[UIApplication sharedApplication] registerForRemoteNotifications];*/

    return handled;
}

- (SalesManagoPlugin*) getPluginInstance {
    return [self.viewController getCommandInstance:@"SalesManagoPlugin"];
}

/*
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    SalesManagoPlugin* fcmPlugin = [self getPluginInstance];
    if (application.applicationState != UIApplicationStateActive) {
        [fcmPlugin sendBackgroundNotification:userInfo];
    } else {
        [fcmPlugin sendNotification:userInfo];
    }

    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)messaging:(FIRMessaging *)messaging didReceiveRegistrationToken:(NSString *)fcmToken {
    SalesManagoPlugin* fcmPlugin = [self getPluginInstance];

    [fcmPlugin sendToken:fcmToken];
}

# pragma mark - UNUserNotificationCenterDelegate
// handle incoming notification messages while app is in the foreground
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    NSDictionary *userInfo = notification.request.content.userInfo;
    SalesManagoPlugin* fcmPlugin = [self getPluginInstance];

    [fcmPlugin sendNotification:userInfo];

    completionHandler([self getPluginInstance].forceShow);
}

// handle notification messages after display notification is tapped by the user
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void (^)(void))completionHandler {
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    SalesManagoPlugin* fcmPlugin = [self getPluginInstance];

    [fcmPlugin sendBackgroundNotification:userInfo];

    completionHandler();
}
*/
@end
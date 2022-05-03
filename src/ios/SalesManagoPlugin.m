#import "SalesManagoPlugin.h"
#import "AMMonitor.h"
#import "AMNotification.h"

@implementation SalesManagoPlugin

- (void)initialize:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];

    NSLog(@"Launching Sales Manago Plugin");

    /*VGPlayerLib* sharedInstance =[VGPlayerLib sharedInstance];
    if(sharedInstance)
    {
        // Fetch options from command arguments
        NSDictionary* options = [command.arguments objectAtIndex:0];
        if(options) [self setupPlayer:sharedInstance withOptions:options];
        UIViewController *vgc = [sharedInstance getPlayer];
        if(vgc)
        {
            [vgc setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
            [self.viewController presentViewController:vgc animated:YES completion:NULL];
        }
        else
        {
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"UIViewController was null"];
        }
    }
    else
    {
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"VGPlayerLib instance was null"];
    }*/

    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void)pluginInitialize {
    NSLog(@"pluginInitialize Sales Manago Plugin");
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishLaunching:) name:UIApplicationDidFinishLaunchingNotification object:nil];
}

- (void)finishLaunching:(NSNotification *)notification {
    NSLog(@"didFinishLaunchingWithOptions Sales Manago Plugin");
}

/*- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"didFinishLaunchingWithOptions Sales Manago Plugin");

    // Override point for customization after application launch.
    [[AMMonitor sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
    if (launchOptions) {
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
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    return YES;
}

void (^dialogHandler)(AMNotification *) = ^(AMNotification *notification) {
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:notification.payload[@"dialogOk"] style:UIAlertActionStyleDefault
    handler:^(UIAlertAction *action) {
        [[AMMonitor sharedInstance] trackNotificationCallback:notification]; 
    }];
    [[AMMonitor sharedInstance] displayDialog:notification withOkAction:okAction];
};*/

@end
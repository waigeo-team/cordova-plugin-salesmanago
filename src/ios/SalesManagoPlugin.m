#import "SalesManagoPlugin.h"
#import "AMMonitor.h"
#import "AMNotification.h"
#import "AppDelegate.h"

@implementation SalesManagoPlugin

- (void)initialize:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void)didFinishLaunchingWithOptions:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
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
}

- (void)didRegisterForRemoteNotificationsWithDeviceToken:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"Registrer For Remote Notification *******************");
    NSLog(@"%@", deviceToken);
    [[AMMonitor sharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)syncEmail:(CDVInvokedUrlCommand*)command {
    NSString* email = [command argumentAtIndex:0];
    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [[AMMonitor sharedInstance] syncEmail:email];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void)syncPhone:(CDVInvokedUrlCommand*)command {
    NSString* phone = [command argumentAtIndex:0];
    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [[AMMonitor sharedInstance] syncMsisdn:phone];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void)syncPushToken:(CDVInvokedUrlCommand*)command {
    NSLog(@"syncPushToken");
}

- (BOOL)loadPayloadForNotification:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {	
    NSLog(@"loadPayloadForNotification");
		
	BOOL amPush = [[AMMonitor sharedInstance] loadPayloadForNotification:userInfo andApplication:application loadCompletionHandlerWithError:^(AMNotification *notification, NSError *error) {
            if (error) {
                NSLog(@"Error occured while downloading notification :  %@", [error localizedDescription]);
                return;
            }
            // implement your own logic or use default
            [[AMMonitor sharedInstance] handleNotification:notification notificationHandler:nil dialogHandler:dialogHandler urlHandler:nil inAppHandler:nil];
        }];
	
	
}


	
	BOOL amPush = [[AMMonitor sharedInstance] loadPayloadForNotification:userInfo andApplication:application loadCompletionHandlerWithError:^(AMNotification *notification, NSError *error) {
		if (error) {
		  NSLog(@"Error occured while downloading notification :  %@", [error localizedDescription]);
		  completionHandler(UIBackgroundFetchResultNoData);
		  return;
		} else {
		  completionHandler(UIBackgroundFetchResultNewData);
		}
		
		// implement your own logic or use default
		//[[AMMonitor sharedInstance] handleNotification:notification notificationHandler:nil dialogHandler:dialogHandler urlHandler:nil inAppHandler:nil]; 
		
	    
		//[salesManagoPlugin didFinishLaunchingWithOptions:application didFinishLaunchingWithOptions:launchOptions];    

	}];
        
    if (!amPush) {
       // handle not appmanago notifications here
       completionHandler(UIBackgroundFetchResultNewData);
    }
	
	

void (^dialogHandler)(AMNotification *) = ^(AMNotification *notification) {
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:notification.payload[@"dialogOk"] style:UIAlertActionStyleDefault
    handler:^(UIAlertAction *action) {
        [[AMMonitor sharedInstance] trackNotificationCallback:notification]; 
    }];
    [[AMMonitor sharedInstance] displayDialog:notification withOkAction:okAction];
};

@end
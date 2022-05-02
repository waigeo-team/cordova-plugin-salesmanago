#import "SalesManagoPlugin.h"
#import "AMMonitor.h"

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

@end
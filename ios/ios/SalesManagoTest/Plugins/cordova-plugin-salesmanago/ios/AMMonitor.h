//
// Created by Benhauer on 11.06.15.
// Copyright (c) 2015 Benhauer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


extern NSString *const AMMonitorDidRecievePushPayloadNotification;

static const int MINUTE = 60 * 1000;
extern int AMNotificationAlreadyProcessed;
extern int AMNotificationHandlerError;

@class AMProperties;
@class AMNotification;
@class AMPush;

typedef void (^AMNotificationHandler)(AMNotification *notification);

typedef void (^AMNotificationHandlerWithError)(AMNotification *notification, NSError *error);


#define AMActionTypeDismissed           @"DISMISSED"
#define AMActionTypeActionTaken         @"ACTION_TAKEN"
#define AMActionTypeDisplayed           @"DISPLAYED"
typedef NSString* AMActionType;


@interface AMMonitor : NSObject

//Returns shared instance of AMMonitor
+ (instancetype)sharedInstance;

//Initializes AMmonitor after application launch.
- (void)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

//this method checks if token for notification is not changed and sends it if necessary to server.
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)token;

//records app end event when application enters background
- (void)applicationDidEnterBackground:(UIApplication *)application;

//records app start event when will enter foregrond
- (void)applicationWillEnterForeground:(UIApplication *)application;

//method allows to track START, END and CLICK events
- (void)trackEventWithEventType:(NSString *)eventType andSimpleId:(NSString *)simpleId andProperties:(AMProperties *)properties;

//This method allows to track custom event, AmProperties may be empty, but cannot be nil.
//eventType parameter coresponds to name given for custom event in Appmanago panel
- (void)trackCustomEvent:(AMProperties *)amProperties withEventType:(NSString *)eventType;

// This method recognizes if NSDictionary userInfo contains parameters of Appmanago push (required : mid, cid, pushId, url, type) .
// If required  parameters are present method downloads payload and executes completion handler.
- (BOOL)loadPayloadForNotification:(NSDictionary *)userInfo andApplication:(UIApplication *)application loadCompletionHandler:(AMNotificationHandler)completionHandler __attribute__((deprecated));

// This method recognizes if NSDictionary userInfo contains parameters of Appmanago push (required : mid, cid, pushId, url, type) .
// If required  parameters are present method downloads payload and executes completion handler.
// If anything will fail error will be present in completion handler.
- (BOOL)loadPayloadForNotification:(NSDictionary *)userInfo andApplication:(UIApplication *)application loadCompletionHandlerWithError:(AMNotificationHandlerWithError)completionHandler;

// This method loads notifications of type INAPP and NOTIFICATION, which payload was not downloaded due to app termination
- (void)loadUnrecievedNotificationsAndProcess:(AMNotificationHandlerWithError)notificationHandler;

//This method enables you to associate email with uuid in Appmanago
//Calling this method with the same parameter won't cause more than one successful request
- (void)syncEmail:(NSString *)email;

//This methods allows you to send location to Appmanago. It allows to send one reuqest per minute, if you try call
//method sooner it will return NO
- (BOOL)recordLocationWithLatitude:(NSString *)latitude andLongitude:(NSString *)longitude;

//Call this method when you want to notify Appmanago than action for this inApp notification was taken.
//Default handlers for notification also can call this method. Calling this method more than once for notification
//will cause inconsistencies in statistics
//Possible action types: DISMISSED, ACTION_TAKEN, DISPLAYED
//actionId is optional and represents id of button selected by user
- (void)trackInAppCallback:(AMNotification *)notification withActionType:(AMActionType)actionType withActionId:(NSString *)actionId;
    
//Call this method when you want to notify Appmanago than action for this notification was taken.
//Default handlers for notification also can call this method. Calling this method more than once for notification
//will cause inconsistencies in statistics
- (void)trackNotificationCallback:(AMNotification *)notification withActionType:(AMActionType)actionType;

- (void)trackNotificationCallback:(AMNotification *)notification;

//helper method that handles notification recieved from AppAmanago
- (void)handleNotification:(AMNotification *)notification notificationHandler:(AMNotificationHandler)notificationHandler dialogHandler:(AMNotificationHandler)dialogHandler urlHandler:(AMNotificationHandler)urlHandler inAppHandler:(AMNotificationHandler)inAppHandler;

//helper method creating sceleton for displaying dialog. It will be created with parameters given in Appmanago and default
//cancel action dismissing dialog, you have to specify
- (void)displayDialog:(AMNotification *)notification withOkAction:(UIAlertAction *)okAction;

// method creating and displaying default in app dialog
//cancel action dismissing dialog, you have to specify
- (void)displayInAppDialog:(AMNotification *)notification;

//This method enables to set properties for user
- (void)setUserProperties:(AMProperties *)amProperties;

//This method allows you to synchronize phone number, preferrably it should contains only + and numbers
- (void)syncMsisdn:(NSString *)msisdn;

//This method records once per minute entrance to given beacon.
- (void)enteredBeaconWith:(NSUUID *)uuid andMinor:(NSNumber *)minor andMajor:(NSNumber *)major;

//This method records once per minute exit from given beacon.
- (void)exitedBeaconWith:(NSUUID *)uuid andMinor:(NSNumber *)minor andMajor:(NSNumber *)major;

- (NSArray<AMPush*>*) getPushHistory;
@end

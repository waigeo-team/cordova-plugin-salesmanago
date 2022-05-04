//
//  AMNotification.h
//  AMMonitor
//
//  Created by Benhauer on 14.03.2016.
//  Copyright © 2016 Benhauer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMNotification : NSObject

@property(readonly) NSString *messageId;
@property(readonly) NSString *pushId;
@property(readonly) NSString *conversationId;
@property(readonly) NSString *type;
@property(readonly) NSString *url;
@property(readonly) NSDictionary *payload;
@property(readonly) NSDictionary *aps;
@property(readonly) BOOL wasAppActive ;

- (id) initWithMessageId:(NSString *)aMessageId
               andPushId:(NSString *)aPushId
       andConversationId:(NSString *)aConversatrionId
                 andType:(NSString *)aType
                  andUrl:(NSString *)aUrl
              andPayload:(NSDictionary *) aPayload
                  andAps:(NSDictionary *)aAps
         andWasAppActive:(BOOL) aWasAppActive ;


@end

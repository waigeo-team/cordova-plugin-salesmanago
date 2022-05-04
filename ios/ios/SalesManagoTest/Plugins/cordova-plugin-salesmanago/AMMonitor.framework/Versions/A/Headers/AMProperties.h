//
// Created by Benhauer on 25.09.15.
// Copyright (c) 2015 Benhauer. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AMProperties : NSObject

@property NSMutableDictionary *properties;
@property NSMutableDictionary *propertiesType;

- (void)addNumber:(int)number withName:(NSString *)name;

- (void)addDecimalNumber:(NSDecimalNumber *)number withName:(NSString *)name;

- (void)addString:(NSString *)string withName:(NSString *)name;

- (void)addBoolean:(bool)b withName:(NSString *)name;

- (void)addDate:(long)timestampMillis withName:(NSString *)name;
@end

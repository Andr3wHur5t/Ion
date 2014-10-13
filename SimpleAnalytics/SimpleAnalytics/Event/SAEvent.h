//
//  SAEvent.h
//  SimpleAnalytics
//
//  Created by Andrew Hurst on 10/10/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SADescription.h"

@interface SAEvent : NSObject
#pragma mark Construction
/**
 * Constructs at the current time with the inputted description.
 * @param description - the description of the event.
 */
- (instancetype) initWithDescription:(SADescription *)description;

/**
 * Constructs a event at the current time using the inputted desctiption.
 * @param description - the desctiption of the event.
 */
+ (instancetype) eventWithDescription:(SADescription *)description;

#pragma mark Meta
/**
 * Description of the event.
 */
@property (strong, nonatomic, readonly) SADescription *description;

/**
 * The time of the event.
 */
@property (strong, nonatomic, readonly) NSDate *time;

#pragma mark Interface
/**
 * Adds to the default event manager.
 */
- (void) record;

@end

@interface SANamedEvent : SAEvent
/**
 * Constructs with the inputted name.
 * @param name - the name of the object.
 */
- (instancetype) initWithName:(NSString *)name;

#pragma mark Meta
/**
 * Our named description of the event.
 */
@property (strong, nonatomic, readonly) SANamedDescription *description;
@end

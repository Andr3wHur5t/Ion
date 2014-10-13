//
//  SADescription.h
//  SimpleAnalytics
//
//  Created by Andrew Hurst on 10/10/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * An abstract description class.
 */
@interface SADescription : NSObject
@end

#pragma mark Named Description
@interface SANamedDescription : SADescription
/**
 * Constructs a description witht the specified name.
 * @param name - the name of the event.
 */
- (instancetype) initWithName:(NSString *)name;

/**
 * Name of the event.
 */
@property (strong, nonatomic, readonly) NSString *name;
@end
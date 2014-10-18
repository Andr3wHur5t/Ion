//
//  NSObject+FOObject.h
//  FOUtilities
//
//  Created by Andrew Hurst on 10/7/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSObject (FOObject)
#pragma mark Extension Map
/**
 * A mutable dictionary to store category variables in.
 */
@property (strong, nonatomic, readonly) NSMutableDictionary* categoryVariables;

/**
 * Depricate
 */
@property (weak, nonatomic, readonly) NSMutableDictionary* catagoryVariables DEPRECATED_ATTRIBUTE;

#pragma mark Delayed Blocks

/**
 * Performs a block after the set delay.
 * @param block - the block to call.
 */
- (void) performBlock:(void(^)( )) block afterDelay:(double) delay;
@end

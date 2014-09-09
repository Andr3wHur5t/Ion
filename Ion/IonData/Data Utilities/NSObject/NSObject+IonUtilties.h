//
//  NSObject+IonUtilties.h
//  Ion
//
//  Created by Andrew Hurst on 8/25/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (IonUtilties)
#pragma mark Extension Map

/**
 * The catagory extension map whe we should store all catagory extension variables.
 */
@property (strong, nonatomic, readonly) NSMutableDictionary* catagoryVariables;

#pragma mark Delayed Blocks

/**
 * Performs a block after the set delay.
 * @param {void(^)( )} the block to call.
 * @returns {void}
 */
- (void) performBlock:(void(^)( )) block afterDelay:(double) delay;

@end
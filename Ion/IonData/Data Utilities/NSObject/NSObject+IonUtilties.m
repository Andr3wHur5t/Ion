//
//  NSObject+IonUtilties.m
//  Ion
//
//  Created by Andrew Hurst on 8/25/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "NSObject+IonUtilties.h"

@implementation NSObject (IonUtilties)



#pragma mark Delayed Blocks

/**
 * Performs a block after the set delay.
 * @param {void(^)( )} the block to call.
 * @returns {void}
 */
- (void) performBlock:(void(^)( )) block afterDelay:(double) delay {
    if ( !block )
        return;
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC);
    dispatch_after( popTime, dispatch_get_main_queue(), ^(void){
        block( );
    });
}

@end

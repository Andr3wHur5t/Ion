//
//  NSObject+FOObject.m
//  FOUtilities
//
//  Created by Andrew Hurst on 10/7/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "NSObject+FOObject.h"
#import <objc/runtime.h>


static void* sIonCatagoryVariablesKey = "CatagoryVariablesKey";

@implementation NSObject (FOObject)
#pragma mark Catagory variables

/**
 * The catagory extension map whe we should store all catagory extension variables.
 */
- (NSMutableDictionary *)categoryVariables {
    NSMutableDictionary* obj = objc_getAssociatedObject( self, sIonCatagoryVariablesKey);
    if ( !obj || ![obj isKindOfClass:[NSMutableDictionary class]] ) {
        obj = [[NSMutableDictionary alloc] init];
        objc_setAssociatedObject(self, sIonCatagoryVariablesKey, obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC );
    }
    return obj;
}


- (NSMutableDictionary *)catagoryVariables {
    return [self categoryVariables];
}


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

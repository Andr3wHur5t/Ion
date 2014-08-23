//
//  NSValue+TypeExtension.m
//  Ion
//
//  Created by Andrew Hurst on 8/21/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "NSValue+TypeExtension.h"

@implementation NSValue (TypeExtension)

#pragma mark CGFloat
/**
 * Converts to a CGFloat
 * @returns {CGFloat}
 */
- (CGFloat) toFloat {
    CGFloat val;
    [self getValue: &val];
    return val;
}

/**
 * Gets a NSValue from a CGFloat.
 * @param {CGFloat} the value to construct with.
 * @returns {NSValue*}
 */
+ (NSValue*) valueWithFloat:(CGFloat) val {
    return [NSValue valueWithBytes: &val objCType: @encode(CGFloat)];
}

@end

//
//  NSValue+FOTypeExtension.m
//  FOUtilities
//
//  Created by Andrew Hurst on 10/9/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "NSValue+FOTypeExtension.h"

@implementation NSValue (FOTypeExtension)
#pragma mark CGFloat

- (CGFloat) toFloat {
    CGFloat val;
    [self getValue: &val];
    return val;
}

+ (NSValue *)valueWithFloat:(CGFloat) value {
    return [NSValue valueWithBytes: &value objCType: @encode(CGFloat)];
}

@end

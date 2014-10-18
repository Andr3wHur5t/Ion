//
//  NSValue+FOTypeExtension.h
//  FOUtilities
//
//  Created by Andrew Hurst on 10/9/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSValue (FOTypeExtension)
#pragma mark CGFloat
/**
 * Converts to a CGFloat.
 */
- (CGFloat) toFloat;

/**
 * Gets a NSValue from a CGFloat.
 * @param value - the value to construct with.
 */
+ (NSValue *)valueWithFloat:(CGFloat) value;
@end

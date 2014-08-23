//
//  NSValue+TypeExtension.h
//  Ion
//
//  Created by Andrew Hurst on 8/21/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface  NSValue (TypeExtension)


#pragma mark CGFloat
/**
 * Converts to a CGFloat
 * @returns {CGFloat}
 */
- (CGFloat) toFloat;

/**
 * Gets a NSValue from a CGFloat.
 * @param {CGFloat} the value to construct with.
 * @returns {NSValue*}
 */
+ (NSValue*) valueWithFloat:(CGFloat) val;

@end

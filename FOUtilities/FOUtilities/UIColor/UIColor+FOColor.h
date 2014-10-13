//
//  UIColor+FOColor.h
//  FOUtilities
//
//  Created by Andrew Hurst on 10/9/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * Utility Color Macro
 * From: http://stackoverflow.com/a/3532264/3624745
 */
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0f green:((float)((rgbValue & 0xFF00) >> 8))/255.0f blue:((float)(rgbValue & 0xFF))/255.0f alpha:1.0f]

@interface UIColor (FOColor)

#pragma mark Conversions

/**
 * This converts a UIColor to a #RRGGBBAA hex string.
 * @returns A hex string representing the color object.
 */
- (NSString*) toHex;

/**
 * This converts a NSString in Hex Format to a UIColor
 * Hex String to UIColor From Stack overflow: http://stackoverflow.com/a/7180905/3624745
 * @param hexString - the string to retrieve the color from.
 */
+ (UIColor*) colorFromHexString:(NSString *)hexString;

@end

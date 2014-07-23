//
//  UIColor+IonColor.h
//  Ion
//
//  Created by Andrew Hurst on 7/14/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * Utility Color Macro
 * From: http://stackoverflow.com/a/3532264/3624745
 */
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@class IonKVPAccessBasedGenerationMap;

@interface UIColor (IonColor)

#pragma mark Utilities

/**
 * This converts a UIColor to a #RRGGBBAA hex string.
 * @returns {NSString*} the hex string representing the color object.
 */
- (NSString*) toHex;

/**
 * This converts a NSString in Hex Format to a UIColor
 * Hex String to UIColor From Stack overflow: http://stackoverflow.com/a/7180905/3624745
 * @param {NSString*} the string to generate the color from.
 * @retuns {UIColor*} the generated color.
 */
+ (UIColor*) colorFromHexString:(NSString*) hexString;

/**
 * This converts a NSString at an inputted range in to an RGBA Element.
 * Hex String to UIColor From Stack overflow: http://stackoverflow.com/a/7180905/3624745
 * @param {NSInteger} the starting index
 * @param {NSInteger} the amount of char to use to get the element
 * @retuns {CGFloat} the net color component
 */
+ (CGFloat) colorComponentFrom:(NSString*) string start:(NSUInteger) start length:(NSUInteger) length;

#pragma mark Verification

/**
 * This checks if the inputted string is a valid hex.
 * @param {NSString*} this is the string to be validated
 * @returns {BOOL} true if the hex is valid, false if it has failed
 */
+ (BOOL) stingIsValidHex:(NSString*)str;

@end

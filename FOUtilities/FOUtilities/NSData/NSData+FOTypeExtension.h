//
//  NSData+FOTypeExtension.h
//  FOUtilities
//
//  Created by Andrew Hurst on 10/9/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSData (FOTypeExtension)
#pragma mark String Conversions
/**
 * Converts to a NSString using UTF-8.
 */
- (NSString *)toString;

/**
 * Gets NSData from a string.
 * @param string - the string to convert into UTF-8 data.
 */
+ (NSData *)dataFromString:(NSString *)string;

/**
 * Quick convert to a standard base 64 encoding.
 */
- (NSString *)toBase64;

#pragma mark JSON Dictionary Conversions
/**
 * Gets a NSDictionary representation of the JSON data.
 */
- (NSDictionary *)toJsonDictionary;

/**
 * Converts a dictionary into a JSON encoded data object.
 * @param dictionary - the dictionary to convert
 * @param isPretty - if the dictionary should have white space to make it more human readable.
 */
+ (NSData *)dataFromJsonEncodedDictionary:(NSDictionary *)dictionary makePretty:(BOOL) isPretty;

#pragma mark NSNumber Conversion
/**
 * Constructs NSData from the NSNumber.
 * @param number - the number to construct from.
 */
+ (NSData *)dataFromNumber:(NSNumber *)number;

/**
 * Gets the number representation of the data object.
 */
- (NSNumber *)toNumber;

#pragma mark Image Conversion
/**
 * Converts gets an images equivilant of the data.
 */
- (UIImage *)toImage;

/**
 * Converts an image into a data object representing its PNG.
 * @param image - the image to convert
 */
+ (NSData *)dataFromImage:(UIImage *)image;

#pragma mark Object Conversion
/**
 * Converts the inputted id into NSData using the prefered format.
 * @param object the object to convert
 * @returns {NSData*} the resulting data, or NULL if invalid.
 */
+ (NSData*) dataFromObject:(id) object;

@end

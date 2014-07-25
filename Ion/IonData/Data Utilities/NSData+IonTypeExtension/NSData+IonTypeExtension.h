//
//  NSData+IonTypeExtension.h
//  Ion
//
//  Created by Andrew Hurst on 7/24/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSData (IonTypeExtension)

#pragma mark String Conversions

/**
 * Converts To a NSString.
 * @returns {NSString*} the string or NULL if invalid
 */
- (NSString*) toString;

/**
 * Gets NSData from a string.
 * @param {NSString*} the string to convert.
 * @returns {NSData*} the data, or NULL if invalid
 */
+ (NSData*) dataFromString:(NSString*) string;

#pragma mark JSON Dictionary Conversions


/**
 * Gets a NSDictionary representation of the JSON data.
 * @returns {NSDictionary*} a valid dictionary, or NULL if invalid.
 */
- (NSDictionary*) toJsonDictionary;

/**
 * Converts a dictionary into a JSON encoded data object.
 * @param {NSDictionary*} the dictionary to convert
 * @param {BOOL} if the dictionary should have white space to make it more human readable.
 * @returns {NSDictionary*}
 */
+ (NSData*) dataFromJsonEncodedDictionary:(NSDictionary*) dictionary makePretty:(BOOL) isPretty;

@end

//
//  NSData+IonTypeExtension.h
//  Ion
//
//  Created by Andrew Hurst on 7/24/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSData+IonCrypto.h"

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

/**
 * Quick convert to a standard base 64 encoding.
 * @returns {NSSting*} the base 64 encoding.
 */
- (NSString*) toBase64;

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

#pragma mark NSNumber Conversion

/**
 * Constructs NSData from the NSNumber.
 * @param {NSNumber*} the number to construct from.
 * @returns {NSData*}
 */
+ (NSData*) dataFromNumber:(NSNumber*) number;

/**
 * Gets the number representation of the data object
 * @returns {NSNumber*} the number representation.
 */
- (NSNumber*) toNumber;

#pragma mark Object Conversion 

/**
 * Converts the inputted id into NSData using the prefered format.
 * @param {id} the object to convert
 * @returns {NSData*} the resulting data, or NULL if invalid.
 */
+ (NSData*) dataFromObject:(id) object;

/**
 * Converts data to an object using the specified format.
 * @returns {id} the resulting object from decoding, or self if invalid.
 */
- (id) toObject;

@end

//
//  NSData+IonTypeExtension.m
//  Ion
//
//  Created by Andrew Hurst on 7/24/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "NSData+IonTypeExtension.h"


@implementation NSData (IonTypeExtension)

#pragma mark String Conversions

/**
 * Converts To a NSString.
 * @returns {NSString*} the string or NULL if invalid
 */
- (NSString*) toString {
    return [[NSString alloc] initWithData: self encoding: NSUTF8StringEncoding];
}

/**
 * Gets NSData from a string.
 * @param {NSString*} the string to convert.
 * @returns {NSData*} the data, or NULL if invalid
 */
+ (NSData*) dataFromString:(NSString*) string {
    NSData* data;
    if ( !string )
        return NULL;
    
    data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    return data;
}

/**
 * Quick convert to a standard base 64 encoding.
 * @returns {NSSting*} the base 64 encoding.
 */
- (NSString*) toBase64 {
    return [self base64EncodedStringWithOptions: 0];
}

#pragma mark JSON Dictionary Conversions

/**
 * Gets a NSDictionary representation of the JSON data.
 * @returns {NSDictionary*} a valid dictionary, or NULL if invalid.
 */
- (NSDictionary*) toJsonDictionary {
    NSDictionary* jsonObj;
    jsonObj = [NSJSONSerialization JSONObjectWithData: self
                                              options: 0
                                                error: NULL];
    if ( ![jsonObj isKindOfClass:[NSDictionary class]] )
        return NULL;
    
    return jsonObj;
}

/**
 * Converts a dictionary into a JSON encoded data object.
 * @param {NSDictionary*} the dictionary to convert
 * @param {BOOL} if the dictionary should have white space to make it more human readable.
 * @returns {NSDictionary*}
 */
+ (NSData*) dataFromJsonEncodedDictionary:(NSDictionary*) dictionary makePretty:(BOOL) isPretty {
    NSData* data;
    NSJSONWritingOptions options;
    if ( !dictionary || ![dictionary isKindOfClass:[NSDictionary class]] )
        return NULL;
    
    if ( isPretty )
        options = NSJSONWritingPrettyPrinted;
    
    
    data = [NSJSONSerialization dataWithJSONObject: dictionary options: options error: NULL];
    
    return data;
}



#pragma mark NSNumber Conversion

/**
 * Constructs NSData from the NSNumber.
 * @param {NSNumber*} the number to construct from.
 * @returns {NSData*}
 */
+ (NSData*) dataFromNumber:(NSNumber*) number {
    return [NSData dataWithBytes:&number length:sizeof(number)];
}

/**
 * Gets the number representation of the data object
 * @returns {NSNumber*} the number representation.
 */
- (NSNumber*) toNumber {
    NSNumber* num;
    [self getBytes:&num length:sizeof(num)];
    return num;
}

#pragma mark Image Conversion

/**
 * Converts gets an images equivilant of the data.
 * @returns {UIImage*}
 */
- (UIImage*) toImage {
    return [UIImage imageWithData: self];
}

/**
 * Converts an image into a data object representing its PNG.
 * @param {UIImage*} the image to convert
 * @returns {void}
 */
+ (NSData*) dataFromImage:(UIImage*) image {
    return UIImagePNGRepresentation( image );
}

#pragma mark Object Conversion

/**
 * Converts the inputted id into NSData using the prefered format.
 * @param {id} the object to convert
 * @returns {NSData*} the resulting data, or NULL if invalid.
 */
+ (NSData*) dataFromObject:(id) object {
    NSData* resultData;
    if ( !object )
        return NULL;
    
    // Are we already in the correct format?
    if ( [object isKindOfClass: [NSData class]] )
        resultData = object;
    
    // TODO: make a customizable encoding system...
    // This is polyfill!
    
    // String
    if ( !resultData && [object isKindOfClass:[NSString class]] )
        resultData = [NSData dataFromString: object];
    
    // Dictionary to JSON... Duh
    if ( !resultData && [object isKindOfClass:[NSDictionary class]] )
        resultData = [NSData dataFromJsonEncodedDictionary: object makePretty:TRUE];
    
    // Image
    if ( !resultData && [object isKindOfClass: [UIImage class]] )
        resultData = [NSData dataFromImage: object];
    
    // Try Converting it Using NSCoder...
    if ( !resultData )
        resultData = [NSKeyedArchiver archivedDataWithRootObject: object];
    
    return resultData;
}


@end

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

#pragma mark JSON Dictionary Conversions

/**
 * Gets a NSDictionary representation of the JSON data.
 * @returns {NSDictionary*} a valid dictionary, or NULL if invalid.
 */
- (NSDictionary*) toJsonDictionary {
    id jsonObj;
    
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

@end

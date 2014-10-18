//
//  NSData+FOTypeExtension.m
//  FOUtilities
//
//  Created by Andrew Hurst on 10/9/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "NSData+FOTypeExtension.h"

@implementation NSData (FOTypeExtension)
#pragma mark String Conversions

- (NSString*) toString {
    return [[NSString alloc] initWithData: self encoding: NSUTF8StringEncoding];
}

+ (NSData*) dataFromString:(NSString *)string {
    NSData* data;
    NSParameterAssert( [string isKindOfClass: [NSString class]] );
    if ( ![string isKindOfClass: [NSString class]] )
        return NULL;
    
    data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    return data;
}

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

+ (NSData *)dataFromJsonEncodedDictionary:(NSDictionary *)dictionary makePretty:(BOOL) isPretty {
    NSJSONWritingOptions options;
    NSParameterAssert( [dictionary isKindOfClass: [NSDictionary class]] );
    if ( ![dictionary isKindOfClass:[NSDictionary class]] )
        return NULL;
    
    if ( isPretty )
        options = NSJSONWritingPrettyPrinted;

    return [NSJSONSerialization dataWithJSONObject: dictionary options: options error: NULL];
}

#pragma mark NSNumber Conversion

+ (NSData *)dataFromNumber:(NSNumber *)number {
    NSParameterAssert( [number isKindOfClass: [NSNumber class]] );
    if ( ![number isKindOfClass: [NSNumber class]] )
        return NULL;
    return [NSData dataWithBytes:&number length:sizeof(number)];
}

- (NSNumber *)toNumber {
    NSNumber *num;
    [self getBytes: &num length: sizeof(num)];
    return num;
}

#pragma mark Image Conversion

- (UIImage *)toImage {
    return [UIImage imageWithData: self];
}

+ (NSData *)dataFromImage:(UIImage*) image {
    NSParameterAssert( [image isKindOfClass: [UIImage class]] );
    if ( ![image isKindOfClass: [UIImage class]] )
        return NULL;
    return UIImagePNGRepresentation( image );
}

#pragma mark Object Conversion

+ (NSData *)dataFromObject:(id) object {
    NSData *resultData;
    NSParameterAssert( object );
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

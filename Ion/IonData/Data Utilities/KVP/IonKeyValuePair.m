//
//  IonKeyValuePair.m
//  Ion
//
//  Created by Andrew Hurst on 7/18/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonKeyValuePair.h"
#import "IonKVPAccessBasedGenerationMap.h"
#import "IonAttrubutesStanderdResolution.h"
#import "IonImageRef.h"
#import "IonStyle.h"
#import "IonGradientConfiguration.h"
#import "UIColor+IonColor.h"
#import "IonThemePointer.h"
#import "IonKVPAccessBasedGenerationMap.h"

@implementation IonKeyValuePair

/**
 * This will resolve a KVP object using a map and an Attrbute Set.
 * @param {id} the value to process
 * @param {IonThemeAttributes*} the theme attrubute set to do our searches on if needed.
 * @returns {IonKeyValuePair*} representation, or NULL of invalid
 */
+ (IonKeyValuePair*) resolveWithValue:(id) value andAttrubutes:(IonKVPAccessBasedGenerationMap*) attributes {
    IonKeyValuePair* result;
    if ( !value || !attributes )
        return NULL;
    
    result = [[IonKeyValuePair alloc] init];
    
    // Set
    result.value = value;
    result.attributes = attributes;
    
    return result;
}

#pragma mark External Interface 

/**
 * This returns the string description of our value
 * @returns {NSString*}
 */
- (NSString*) description {
    return [_value description];
}



#pragma Conversions

/**
 * This gets the string form of our value.
 * @returns {NSString*} representation, or NULL if incorect type.
 */
- (NSString*) toString {
    if ( !_value )
        return NULL;
    if ( ![_value isKindOfClass:[NSString class]] )
        return NULL;
    
    return (NSString*)_value;
}

/**
 * This gets the NSNumber form of our value.
 * @returns {NSNumber*} representation, or NULL if incorect type.
 */
- (NSNumber*) toNumber {
    if ( !_value )
        return NULL;
    if ( ![_value isKindOfClass:[NSNumber class]] )
        return NULL;
    
    return (NSNumber*)_value;
}

/**
 * This gets the NSDictionary form of our value.
 * @returns {NSDictionary*} representation, or NULL if incorect type.
 */
- (NSDictionary*) toDictionary {
    if ( !_value )
        return NULL;
    if ( ![_value isKindOfClass:[NSDictionary class]] )
        return NULL;
    
    return (NSDictionary*)_value;
}

/**
 * This gets the BOOL form of our value.
 * @returns {BOOL} representation, or NO if incorect type.
 */
- (BOOL) toBOOL {
    if ( !_value )
        return NO;
    if ( ![_value isKindOfClass:[NSNumber class]] )
        return NO;
    
    return [(NSNumber*)_value boolValue];
}

/**
 * This gets the IonKVPAccessBasedGenerationMap form of our value.
 * @returns {IonKVPAccessBasedGenerationMap*} representation, or NULL if incorect type.
 */
- (IonKVPAccessBasedGenerationMap*) toKVPAccessBasedGenerationMap {
    NSDictionary* map = [self toDictionary];
    if ( !map )
        return NULL;
    
    return [[IonKVPAccessBasedGenerationMap alloc] initWithRawData:map];
}

/**
 * This gets the IonKVPAccessBasedGenerationMap in balanced mode of our value.
 * @returns {IonKVPAccessBasedGenerationMap*} representation, or NULL if incorect type.
 */
- (IonKVPAccessBasedGenerationMap*) toBalancedKVPAccessBasedGenerationMap {
    NSDictionary* map = [self toDictionary];
    if ( !map )
        return NULL;
    
    return [[IonKVPAccessBasedGenerationMap alloc] initWithRawData: map ];
}

/**
 * This gets the IonImageRef form of our value.
 * @returns {IonImageRef*} representation, or NULL if incorect type.
 */
- (IonImageRef*) toImageRef {
    NSString* fileNameString = [self toString];
    if ( !fileNameString || !_attributes )
        return NULL;
    
    return [IonImageRef resolveWithValue: fileNameString andAttrubutes: _attributes];
}

/**
 * This gets the IonGradientConfiguration form of our value.
 * @returns {IonGradientConfiguration*} representation, or NULL if incorect type.
 */
- (IonGradientConfiguration*) toGradientConfiguration {
    NSDictionary* map = [self toDictionary];
    if ( !map || !_attributes )
        return NULL;
    
    return [IonGradientConfiguration resolveWithMap: map andAttrubutes: _attributes];
}


/**
 * Gets the 2 Vector Value as a point.
 * @param {id} the key for x1
 * @param {id} the key for y1
 * @returns {CGPoint} representation, or CGPointUndefined if incorect type.
 */
- (CGPoint) toVec2UsingX1:(id) x1key andY1:(id) y1Key {
    NSDictionary* config;
    NSNumber *x1, *y1;
    if ( !_value || !x1key || !y1Key )
        return CGPointUndefined;
    
    config = [self toDictionary];
    if ( !config )
        return CGPointUndefined;
    
    x1 = [config objectForKey: x1key];
    y1 = [config objectForKey: y1Key];
    if ( !x1 || ![x1 isKindOfClass: [NSNumber class]] ||
         !y1 || ![y1 isKindOfClass: [NSNumber class]])
        return CGPointUndefined;
    
    return (CGPoint){ [x1 floatValue], [y1 floatValue] };
}

/**
 * Gets the 2 Vector Value as a point.
 * @param {id} the key for x1
 * @param {id} the key for y1
 * @param {id} the key for x2
 * @param {id} the key for y2
 * @returns {CGRect} representation, or CGRectUndefined if incorect type.
 */
- (CGRect) toVec4UsingX1:(id) x1key y1:(id) y1Key x2:(id) x2Key andY2:(id) y2Key {
    NSDictionary* config;
    NSNumber *x1, *y1, *x2, *y2;
    if ( !_value || !x1key || !y1Key )
        return CGRectUndefined;
    
    config = [self toDictionary];
    if ( !config )
        return CGRectUndefined;
    
    x1 = [config objectForKey: x1key];
    y1 = [config objectForKey: y1Key];
    x2 = [config objectForKey: x2Key];
    y2 = [config objectForKey: y2Key];
    if ( !x1 || ![x1 isKindOfClass: [NSNumber class]] ||
         !y1 || ![y1 isKindOfClass: [NSNumber class]] ||
         !y2 || ![y2 isKindOfClass: [NSNumber class]] ||
         !x2 || ![x2 isKindOfClass: [NSNumber class]])
        return CGRectUndefined;
    
    return (CGRect){ [x1 floatValue], [y1 floatValue], [x2 floatValue], [y2 floatValue] };
}

/**
 * Gets the CGPoint of the value.
 * @returns {CGPoint} representation, or CGPointUndefined if incorect type.
 */
- (CGPoint) toPoint {
    return [self toVec2UsingX1: @"x" andY1: @"y"];
}

/**
 * Gets the CGSize of the value.
 * @returns {CGPoint} representation, or CGSizeUndefined if incorect type.
 */
- (CGSize) toSize {
    CGPoint refrence = [self toVec2UsingX1: @"width" andY1: @"height"];
    if ( CGPointEqualToPoint( refrence, CGPointUndefined ) )
        return CGSizeUndefined;
    
    return (CGSize){ refrence.x, refrence.y };
}

/**
 * Gets the CGRect of the value.
 * @returns {CGPoint} representation, or CGPointUndefined if incorect type.
 */
- (CGRect) toRect {
    return [self toVec4UsingX1: @"x" y1: @"y" x2: @"width" andY2: @"height"];
}

@end

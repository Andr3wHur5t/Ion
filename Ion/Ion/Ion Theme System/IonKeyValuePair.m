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
 * This gets the UIColor form of our value.
 * @returns {UIColor*} representation, or NULL if incorect type.
 */
- (UIColor*) toColor {
    NSString* colorString = [self toString];
    if ( !colorString || !_attributes )
        return NULL;
        
    return [UIColor resolveWithValue: colorString andAttrubutes: _attributes];
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
 * This gets the IonStyle form of our value.
 * @returns {IonStyle*} representation, or NULL if incorect type.
 */
- (IonStyle*) toStyle {
    NSDictionary* map = [self toDictionary];
    if ( !map || !_attributes )
        return NULL;
    
    return [IonStyle resolveWithMap: map andAttrubutes: _attributes];
}

/**
 * This gets the IonThemePointer form of our value.
 * @returns {IonThemePointer*} representation, or NULL if incorect type.
 */
- (IonThemePointer*) toThemePointer {
    NSDictionary* map = [self toDictionary];
    if ( !map || !_attributes )
        return NULL;
    
    return [[IonThemePointer alloc] initWithMap: map andAttrubutes: _attributes];
}

/**
 * This gets the IonThemePointer form of our value.
 * @returns {IonThemePointer*} representation, or NULL if incorect type.
 */
- (IonThemePointer*) toThemePointerWithAttrbutes:(IonKVPAccessBasedGenerationMap*) attributes {
    NSDictionary* map = [self toDictionary];
    if ( !map || !_attributes )
        return NULL;
    
    return [[IonThemePointer alloc] initWithMap: map andAttrubutes: attributes];
}

@end

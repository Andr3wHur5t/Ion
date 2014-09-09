//
//  IonApplication+plistGetters.m
//  Ion
//
//  Created by Andrew Hurst on 8/29/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonApplication+plistGetters.h"

@implementation IonApplication (plistGetters)
#pragma mark Untyped Getters
/**
 * Gets the plist value for the specified key.
 * @param {NSString*} the key to get the value for.
 * @returns {id} the object from the plist.
 */
+ (id) plistValueForKey:(NSString*) key {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey: key];
}

/**
 * Gets a plist value typed to a class.
 * @returns {id} the typed value, or NULL if incorrect type.
 */
+ (id) plistValueForKey:(NSString*) key typedToClass:(Class) type {
    id value;
    value = [[self class] plistValueForKey:key];
    if ( !value || ![value isKindOfClass: type] )
        return NULL;
    return value;
}

#pragma mark Typed Getters
/**
 * Gets the current on boarding screen version from the plist.
 * @returns {NSString*} the value stored in the plist, or v0.0 if non-existent
 */
+ (NSString*) currentOnBoardingVersion {
    NSString* value;
    value = [[self class] plistValueForKey: sIonApplication_CurrentOnBoardingScreenVersion
                              typedToClass: [NSString class]];
    return value ? value : @"v0.0";
}

/**
 * Gets if the application is in demo mode from the plist.
 * @returns {BOOL} the value stored in the plist, or FALSE if non-existent
 */
+ (BOOL) isInDemoMode {
    NSNumber* value;
    value = [[self class] plistValueForKey: sIonApplication_IsDemoModeKey
                              typedToClass: [NSNumber class]];
    return value ? [value boolValue] : FALSE;
}
@end

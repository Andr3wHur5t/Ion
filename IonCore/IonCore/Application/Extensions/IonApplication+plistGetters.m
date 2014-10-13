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

+ (id) plistValueForKey:(NSString *)key {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey: key];
}

+ (id) plistValueForKey:(NSString *)key typedToClass:(Class) type {
    id value;
    value = [[self class] plistValueForKey: key];
    if ( !value || ![value isKindOfClass: type] )
        return NULL;
    return value;
}

#pragma mark Typed Getters

+ (NSString*) currentOnBoardingVersion {
    NSString* value;
    value = [[self class] plistValueForKey: sIonApplication_CurrentOnBoardingScreenVersion
                              typedToClass: [NSString class]];
    return value ? value : @"v0.0";
}

+ (BOOL) isInDemoMode {
    NSNumber* value;
    value = [[self class] plistValueForKey: sIonApplication_IsDemoModeKey
                              typedToClass: [NSNumber class]];
    return value ? [value boolValue] : FALSE;
}

@end

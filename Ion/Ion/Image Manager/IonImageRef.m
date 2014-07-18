//
//  IonImageRef.m
//  Ion
//
//  Created by Andrew Hurst on 7/18/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonImageRef.h"
#import "IonThemeAttributes.h"

@implementation IonImageRef


/**
 * This will resolve a KVP object using a map and an Attrbute Set.
 * @param {NSString*} the string to process
 * @param {IonThemeAttributes*} the theme attrubute set to do our searches on if needed.
 * @returns {IonImageRef*} representation, or NULL of invalid
 */
+ (IonImageRef*) resolveWithValue:(id) value andAttrubutes:(IonThemeAttributes*) attributes {
    IonImageRef* result;
    if ( !value || !attributes )
        return NULL;
    if ( ![value isKindOfClass:[NSString class]] )
        return NULL;
    
    result = [[IonImageRef alloc] init];
    
    // Set
    result.fileName = value;
    result.attributes = attributes;
    
    
    return result;
}

#pragma mark Externial Interface

/**
 * This will present the file name as our description in debug.
 * @return {NSString*}
 */
- (NSString*) description {
    return [_fileName description];
}

@end

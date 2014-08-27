//
//  IonKVP+IonTheme.m
//  Ion
//
//  Created by Andrew Hurst on 7/23/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonKVP+IonTheme.h"
#import "IonThemePointer.h"
#import "IonStyle.h"
#import "IonAttrubutesStanderdResolution.h"

@implementation IonKeyValuePair (IonTheme)

/**
 * This gets the UIColor form of our value.
 * @returns {UIColor*} representation, or NULL if incorect type.
 */
- (UIColor*) toColor {
    NSString* colorString = [self toString];
    if ( !colorString || !self.attributes ) {
        return NULL;
    }
    
    return [self.attributes resolveColorAttribute: colorString];
}


/**
 * This gets the IonStyle form of our value.
 * @returns {IonStyle*} representation, or NULL if incorect type.
 */
- (IonStyle*) toStyle {
    NSDictionary* map = [self toDictionary];
    if ( !map || !self.attributes )
        return NULL;
    
    return [IonStyle resolveWithMap: map andAttributes: self.attributes];
}

/**
 * This gets the IonThemePointer form of our value.
 * @returns {IonThemePointer*} representation, or NULL if incorect type.
 */
- (IonThemePointer*) toThemePointer {
    NSDictionary* map = [self toDictionary];
    if ( !map || !self.attributes )
        return NULL;
    
    return [[IonThemePointer alloc] initWithMap: map andAttrubutes: self.attributes];
}

/**
 * This gets the IonThemePointer form of our value.
 * @returns {IonThemePointer*} representation, or NULL if incorect type.
 */
- (IonThemePointer*) toThemePointerWithAttrbutes:(IonKVPAccessBasedGenerationMap*) attributes {
    NSDictionary* map = [self toDictionary];
    if ( !map || !self.attributes )
        return NULL;
    
    return [[IonThemePointer alloc] initWithMap: map andAttrubutes:self.attributes];
}

@end

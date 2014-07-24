//
//  NSDictionary+IonThemeResolution.m
//  Ion
//
//  Created by Andrew Hurst on 7/23/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "NSDictionary+IonThemeResolution.h"

@implementation NSDictionary (IonThemeResolution)

/**
 * Returns the specified keys' value as a UIColor.
 * @param {id} the key of the value.
 * @param {IonTheme*} the theme to get color refrences from.
 * @returns {UIColor*} the resulting color, or NULL if Invalid.
 */
- (UIColor*) colorForKey:(id) key usingTheme:(IonTheme*) theme {
    NSString* colorString;
    if ( !key || !theme )
        return NULL;
    
    colorString = [self objectForKey: key];
    if ( !colorString || ![colorString isKindOfClass: [NSString class]] )
        return NULL;
    
    return [theme resolveColorAttribute: colorString];
}

@end

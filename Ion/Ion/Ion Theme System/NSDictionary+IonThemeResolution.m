//
//  NSDictionary+IonThemeResolution.m
//  Ion
//
//  Created by Andrew Hurst on 7/23/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "NSDictionary+IonThemeResolution.h"
#import "NSDictionary+IonTypeExtension.h"
#import <IonData/IonData.h>

@implementation NSDictionary (IonThemeResolution)

/**
 * Returns the specified keys' value as a UIColor.
 * @param {id} the key of the value.
 * @param {IonTheme*} the theme to get color references from.
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


/**
 * Gets the specified value as a IonGradientConfiguration, which was resolved using the provided theme.
 * @param {id} the key to get the gradient from.
 * @param {IonTheme*} the theme to get references from.
 * @returns {IonGradientConfiguration*} the resulting gradientConfiguration, or NULL if Invalid.
 */
- (IonGradientConfiguration*) gradientForKey:(id) key usingTheme:(IonTheme*) theme {
    NSMutableDictionary* dict;
    NSArray* colorWeights;
    if ( !key )
        return NULL;
    
    dict = [[self dictionaryForKey: key] mutableCopy];
    if ( !dict )
        return NULL;
    
    // Get the unresolved color weights
    colorWeights = [dict normalizedColorWeightsForKey: sIonColorWeightsKey usingTheme: theme];
    if ( !colorWeights )
        return NULL;
    
    // Update color weights to the normalized color weights
    [dict setObject:colorWeights forKey: sIonColorWeightsKey];
    
    return [dict toLinearGradientConfiguration];
}

/**
 * Resolves color weight colors to Hex Strings, using the inputted theme.
 * @param {id} the key of the color weight array.
 * @param {IonTheme*} the theme to get references from.
 * @returns {NSArray*} of the resolved color weights, or NULL if invalid.
 */
- (NSArray*) normalizedColorWeightsForKey:(id) key usingTheme:(IonTheme*) theme {
    NSMutableArray* colorWeights;
    NSDictionary* dict;
    if ( !key || !theme )
        return NULL;
    
    
    for ( NSInteger i = 0; i < [colorWeights count]; ++i ) {
        dict = [colorWeights objectAtIndex: i];
        // Check if there is data to normalize
        if ( dict )
            dict = [dict normalizeColorWeightUsingTheme: theme];
        
        // Check again to see if the normalized data is valid
        if ( dict )
            [colorWeights setObject: dict atIndexedSubscript: i];
        else
            [colorWeights removeObjectAtIndex: i];
        
        dict = NULL;
    }
    
    return colorWeights;
}

/**
 * Resolves a color weights' color to a Hex String, using the inputted theme.
 * @param {IonTheme*} the theme to get references from.
 * @returns {NSArray*} of the resolved color weight dictionary, or NULL if invalid.
 */
- (NSDictionary*) normalizeColorWeightUsingTheme:(IonTheme*) theme {
    UIColor* color;
    NSMutableDictionary* dict;
    if ( !theme )
        return NULL;
    
    dict = [[NSMutableDictionary alloc] initWithDictionary: self];
    
    // Resolve color
    color = [self colorForKey: sIonColorKey usingTheme: theme];
    if ( !color )
        return NULL;
    [dict setObject: [color toHex] forKey: sIonColorKey];
    
    return [NSDictionary dictionaryWithDictionary: dict];
}

@end

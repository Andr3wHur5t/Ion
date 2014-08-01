//
//  NSDictionary+IonThemeResolution.h
//  Ion
//
//  Created by Andrew Hurst on 7/23/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IonTheme.h"

@interface NSDictionary (IonThemeResolution)

/**
 * Gets the specified value as a UIColor after resolving it.
 * @param {id} the key of the value.
 * @param {IonTheme*} the theme to get color references from.
 * @returns {UIColor*} the resulting color, or NULL if Invalid.
 */
- (UIColor*) colorForKey:(id) key usingTheme:(IonTheme*) theme;

/**
 * Gets the specified value as a IonGradientConfiguration, which was resolved using the provided theme.
 * @param {id} the key to get the gradient from.
 * @param {IonTheme*} the theme to get references from.
 * @returns {IonGradientConfiguration*} the resulting gradientConfiguration, or NULL if Invalid.
 */
- (IonGradientConfiguration*) gradientForKey:(id) key usingTheme:(IonTheme*) theme;

/**
 * Resolves color weight colors to Hex Strings, using the inputted theme.
 * @param {id} the key of the color weight array.
 * @param {IonTheme*} the theme to get references from.
 * @returns {NSArray*} of the resolved color weights, or NULL if invalid.
 */
- (NSArray*) normalizedColorWeightsForKey:(id) key usingTheme:(IonTheme*) theme;

/**
 * Resolves a color weights' color to a Hex String, using the inputted theme.
 * @param {IonTheme*} the theme to get references from.
 * @returns {NSArray*} of the resolved color weight dictionary, or NULL if invalid.
 */
- (NSDictionary*) normalizeColorWeightUsingTheme:(IonTheme*) theme;

@end

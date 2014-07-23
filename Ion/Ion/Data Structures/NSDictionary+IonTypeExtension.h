//
//  NSDictionary+IonTypeExtension.h
//  Ion
//
//  Created by Andrew Hurst on 7/22/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIColor+IonColor.h"
#import "IonTheme.h"
#import "IonMath.h"



@class UIColor;
@interface NSDictionary (IonTypeExtension)

/**
 * This returns the specified value as a UIColor.
 * @param {id} the key of the value.
 * @param {IonTheme*} the theme to get color refrences from.
 * @returns {UIColor*} the resulting color, or NULL if Invalid.
 */
- (UIColor*) colorForKey:(id) key usingTheme:(IonTheme*) theme;

/**
 * Gets the CGPoint Equivlent of the value.
 * @param {id} the key to get the value from.
 * @returns {CGPoint} a valid CGPoint, or a CGPointUndefined.
 */
- (CGPoint) pointForKey:(id) key;

/**
 * Gets the CGSize Equivlent of the value.
 * @param {id} the key to get the value from.
 * @returns {CGPoint} a valid CGSize, or a CGPointUndefined.
 */
- (CGSize) sizeForKey:(id) key;

/**
 * Gets the CGRect Equivlent of the value.
 * @param {id} the key to get the value from.
 * @returns {CGPoint} a valid CGSize, or a CGPointUndefined.
 */
- (CGRect) rectForKey:(id) key;
@end

//
//  NSDictionary+IonTypeExtension.h
//  Ion
//
//  Created by Andrew Hurst on 7/22/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IonMath.h"

@class UIColor;
@class IonImageRef;
@class IonColorWeight;
@class IonGradientConfiguration;
@class IonLinearGradientConfiguration;

/**
 * Contains commonly used dictionary utilities, as well as Ion type conversions.
 * Type conversion function name notation is as fallows: <typeShortName>forKey:(id) key;
 * if the type is derived from a dictionary you should also use: to<typeShortName>;
 */
@interface NSDictionary (IonTypeExtension)
#pragma mark Fundamental Objects

/**
 * Gets the NSString of the keyed value.
 * @param {id} the key to get the value from.
 * @retruns {NSString*} a valid NSString, or NULL if invalid.
 */
- (NSString*) stringForKey:(id) key;

/**
 * Gets the NSDictionary of the keyed value.
 * @param {id} the key to get the value from.
 * @retruns {NSDictionary*} a valid NSDictionary, or NULL if invalid.
 */
- (NSDictionary*) dictionaryForKey:(id) key;

/**
 * Gets the NSArray of the keyed value.
 * @param {id} the key to get the value from.
 * @retruns {NSArray*} a valid NSArray, or NULL if invalid.
 */
- (NSArray*) arrayForKey:(id) key;

/**
 * Gets the NSNumber of the keyed value.
 * @param {id} the key to get the value from.
 * @retruns {NSNumber*} a valid NSNumber, or NULL if invalid.
 */
- (NSNumber*) numberForKey:(id) key;

/**
 * Gets the BOOL of the keyed value.
 * @param {id} the key to get the value from.
 * @retruns {BOOL} a valid BOOL, or false.
 */
- (BOOL) boolForKey:(id) key;

#pragma mark Configuration Objects

/**
 * Gets the UIColor of the keyed value.
 * Note: will only convert from Hex in any of the following formats #RBG #RBGA #RRBBGG #RRBBGGAA
 * @param {id} the key to get the value from.
 * @retruns {UIColor*} a valid UIColor, or NULL if invalid.
 */
- (UIColor*) colorFromKey:(id) key;

/**
 * Gets the IonColorWeight of the keyed value.
 * @param {id} the key to get the value from.
 * @retruns {IonColorWeight*} a valid IonColorWeight, or NULL if invalid.
 */
- (IonColorWeight*) colorWeightForKey:(id) key;

/**
 * Gets the IonColorWeight equivalent of the dictionary.
 * @retruns {IonColorWeight*} a valid IonColorWeight, or NULL if invalid.
 */
- (IonColorWeight*) toColorWeight;

/**
 * Gets an NSArray of IonColorWeights from the keyed value.
 * @param {id} the key to get the value from.
 * @retruns {NSArray*} a valid NSArray of IonColorWeights, or NULL if invalid.
 */
- (NSArray*) colorWeightsForKey:(id) key;

/**
 * Gets the IonGradientConfiguration of the keyed value.
 * @param {id} the key to get the value from.
 * @retruns {IonGradientConfiguration*} a valid IonGradientConfiguration, or NULL if invalid.
 */
- (IonGradientConfiguration*) gradientConfigurationForKey:(id) key;

/**
 * Gets the IonGradientConfiguration equivalent of the dictionary.
 * @retruns {IonColorWeight*} a valid IonGradientConfiguration, or NULL if invalid.
 */
- (IonGradientConfiguration*) toGradientConfiguration;

/**
 * Gets the IonLinearGradientConfiguration of the keyed value.
 * @param {id} the key to get the value from.
 * @retruns {IonLinearGradientConfiguration*} a valid IonLinearGradientConfiguration, or NULL if invalid.
 */
- (IonLinearGradientConfiguration*) linearGradientConfigurationForKey:(id) key;

/**
 * Gets the IonGradientConfiguration equivalent of the dictionary.
 * @retruns {IonColorWeight*} a valid IonLinearGradientConfiguration, or NULL if invalid.
 */
- (IonLinearGradientConfiguration*) toLinearGradientConfiguration;

/**
 * Gets the IonImageRef of the keyed value.
 * @param {id} the key to get the value from.
 * @retruns {IonImageRef*} a valid IonImageRef, or NULL if invalid.
 */
- (IonImageRef*) imageRefFromKey:(id) key;
 

#pragma mark Multidimensional Vectors

/**
 * Gets the CGPoint equivalent of the value.
 * @param {id} the key to get the value from.
 * @returns {CGPoint} a valid CGPoint, or a CGPointUndefined.
 */
- (CGPoint) pointForKey:(id) key;

/**
 * Gets the CGPoint equivalent of the dictionary.
 * @returns {CGPoint} a valid CGPoint, or a CGPointUndefined.
 */
- (CGPoint) toPoint;

/**
 * Gets the CGSize equivalent of the value.
 * @param {id} the key to get the value from.
 * @returns {CGPoint} a valid CGSize, or a CGPointUndefined.
 */
- (CGSize) sizeForKey:(id) key;

/**
 * Gets the CGSize equivalent of the dictionary.
 * @returns {CGPoint} a valid CGSize, or a CGPointUndefined.
 */
- (CGSize) toSize;

/**
 * Gets the CGRect equivalent of the value.
 * @param {id} the key to get the value from.
 * @returns {CGPoint} a valid CGSize, or a CGPointUndefined.
 */
- (CGRect) rectForKey:(id) key;

/**
 * Gets the CGRect equivalent of the dictionary.
 * @returns {CGPoint} a valid CGSize, or a CGPointUndefined.
 */
- (CGRect) toRect;

#pragma mark Primitive Processors

/**
 * Gets the 2 Vector Value as a point.
 * @param {id} the key for x1
 * @param {id} the key for y1
 * @returns {CGPoint} representation, or CGPointUndefined if incorrect type.
 */
- (CGPoint) toVec2UsingX1:(id) x1key andY1:(id) y1Key;

/**
 * Gets the 2 Vector Value as a point.
 * @param {id} the key for x1
 * @param {id} the key for y1
 * @param {id} the key for x2
 * @param {id} the key for y2
 * @returns {CGRect} representation, or CGRectUndefined if incorrect type.
 */
- (CGRect) toVec4UsingX1:(id) x1key y1:(id) y1Key x2:(id) x2Key andY2:(id) y2Key;

#pragma mark Utilities

/**
 * Enumerates through all keys of the dictionary and preforms the block.
 * @param { void(^)( id key, BOOL* stop ) } the block to be called for each key.
 * @returns {void}
 */
- (void) enumerateKeysUsingBlock:(void(^)( id key, BOOL* stop )) block;

/**
 * Gets a new dictionary matching our dictionary which was overridden by the inputted dictionary.
 * @param {NSDictionary*} the dictionary that will override ours.
 * @returns {NSDictionary*}
 */
- (NSDictionary*) overriddenByDictionary:(NSDictionary*) overridingDictionary;

/**
 * Gets a new dictionary matching our dictionary which was recursively overridden by the inputted dictionary.
 * @param {NSDictionary*} the dictionary that will override ours.
 * @returns {NSDictionary*}
 */
- (NSDictionary*) overriddenByDictionaryRecursively:(NSDictionary*) overridingDictionary;
@end

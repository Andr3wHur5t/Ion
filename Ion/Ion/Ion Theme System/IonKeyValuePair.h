//
//  IonKeyValuePair.h
//  Ion
//
//  Created by Andrew Hurst on 7/18/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IonKVPAccessBasedGenerationMap.h"
#import "IonMath.h"

@class IonStyle;
@class IonGradientConfiguration;
@class IonImageRef;
@class IonThemePointer;
@class IonThemeAttributes;

@interface IonKeyValuePair : NSObject

/**
 * This is where we hold the KVP value
 */
@property (strong, nonatomic) id value;

/**
 * This is where we hold the parent attributes refrence.
 */
@property (strong, nonatomic) IonKVPAccessBasedGenerationMap* attributes;

/**
 * This will resolve a KVP object using a map and an Attrbute Set.
 * @param {id} the value to process
 * @param {IonThemeAttributes*} the theme attrubute set to do our searches on if needed.
 * @returns {IonKeyValuePair*} representation, or NULL of invalid
 */
+ (IonKeyValuePair*) resolveWithValue:(id) value andAttrubutes:(IonKVPAccessBasedGenerationMap*) attributes;

#pragma Conversions

/**
 * This gets the string form of our value.
 * @returns {NSString*} representation, or NULL if incorect type.
 */
- (NSString*) toString;

/**
 * This gets the NSNumber form of our value.
 * @returns {NSNumber*} representation, or NULL if incorect type.
 */
- (NSNumber*) toNumber;

/**
 * This gets the NSDictionary form of our value.
 * @returns {NSDictionary*} representation, or NULL if incorect type.
 */
- (NSDictionary*) toDictionary;

/**
 * This gets the BOOL form of our value.
 * @returns {BOOL} representation, or NO if incorect type.
 */
- (BOOL) toBOOL;

/**
 * This gets the IonKVPAccessBasedGenerationMap form of our value.
 * @returns {IonKVPAccessBasedGenerationMap*} representation, or NULL if incorect type.
 */
- (IonKVPAccessBasedGenerationMap*) toKVPAccessBasedGenerationMap;

/**
 * This gets the IonKVPAccessBasedGenerationMap in balanced mode of our value.
 * @returns {IonKVPAccessBasedGenerationMap*} representation, or NULL if incorect type.
 */
- (IonKVPAccessBasedGenerationMap*) toBalancedKVPAccessBasedGenerationMap;

/**
 * This gets the UIColor form of our value.
 * @returns {UIColor*} representation, or NULL if incorect type.
 */
- (UIColor*) toColor;

/**
 * This gets the IonImageRef form of our value.
 * @returns {IonImageRef*} representation, or NULL if incorect type.
 */
- (IonImageRef*) toImageRef;

/**
 * This gets the IonGradientConfiguration form of our value.
 * @returns {IonGradientConfiguration*} representation, or NULL if incorect type.
 */
- (IonGradientConfiguration*) toGradientConfiguration;

/**
 * This gets the IonStyle form of our value.
 * @returns {IonStyle*} representation, or NULL if incorect type.
 */
- (IonStyle*) toStyle;

/**
 * This gets the IonThemePointer form of our value.
 * @returns {IonThemePointer*} representation, or NULL if incorect type.
 */
- (IonThemePointer*) toThemePointer;

/**
 * This gets the IonThemePointer form of our value.
 * @returns {IonThemePointer*} representation, or NULL if incorect type.
 */
- (IonThemePointer*) toThemePointerWithAttrbutes:(IonKVPAccessBasedGenerationMap*) attributes;


/**
 * ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== =====
 *                              Vector Conversions
 * ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== =====
 */

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
/**
 * Gets the CGPoint of the value.
 * @returns {CGPoint} representation, or CGPointUndefined if incorect type.
 */
- (CGPoint) toPoint;
/**
 * Gets the CGSize of the value.
 * @returns {CGPoint} representation, or CGSizeUndefined if incorect type.
 */
- (CGSize) toSize;

/**
 * Gets the CGRect of the value.
 * @returns {CGPoint} representation, or CGPointUndefined if incorect type.
 */
- (CGRect) toRect;

@end

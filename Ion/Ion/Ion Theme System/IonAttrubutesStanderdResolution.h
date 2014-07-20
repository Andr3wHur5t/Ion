//
//  IonAttrubutesStanderdResolution.h
//  Ion
//
//  Created by Andrew Hurst on 7/19/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonKVPAccessBasedGenerationMap.h"

@class IonKeyValuePair;
@class IonImageRef;
@class IonStyle;
@class IonGradientConfiguration;
@class UIColor;


/** Group Definitions
 */
static const NSString* sColorsGroupKey = @"colors";
static const NSString* sGradientsGroupKey = @"gradients";
static const NSString* sImagesGroupKey = @"images";
static const NSString* sKVPGroupKey = @"kvp";
static const NSString* sStylesGroupKey = @"styles";

@interface IonKVPAccessBasedGenerationMap (StanderdResolution)

/**
 * This resolves a color key into a UIColor.
 * @param {NSString*} the key for us to look for.
 * @returns {IonGradientConfiguration*} representation of the input, or NULL if invalid.
 */
- (UIColor*) resolveColorAttrubute:(NSString*) value;

/**
 * This resolves a gradient key into a gradientConfiguration
 * @param {NSString*} the key for us to look for.
 * @returns {IonGradientConfiguration*} representation of the input, or NULL if invalid.
 */
- (IonGradientConfiguration*) resolveGradientAttribute:(NSString*) value;

/**
 * This resolves a style key into a IonStyle object.
 * @param {NSString*} the key for us to look for.
 * @returns {IonStyle*} representation of the input, or NULL if invalid.
 */
- (IonStyle*) resolveStyleAttribute:(NSString*) value;

/**
 * This resolves a Image key into a UIImage object.
 * @param {NSString*} the key for us to look for.
 * @returns {UIImage*} representation of the input, or NULL if invalid.
 */
- (IonImageRef*) resolveImageAttribute:(NSString*) value;

/**
 * This resolves a KVP key into a KVP object.
 * @param {NSString*} the key for us to look for.
 * @returns {UIImage*} representation of the input, or NULL if invalid.
 */
- (IonKeyValuePair*) resolveKVPAttribute:(NSString*) value;

#pragma mark Color Getter

/**
 * This will get the color from the color map.
 * @param {NSString*} color key to look for.
 * @returns {UIColor*} representation of the input, or NULL if invalid.
 */
- (UIColor*) colorFromMapWithKey:(NSString*) colorKey;

#pragma mark Group Getters
/**
 * This will get the color group map.
 * @returns {IonKVPAccessBasedGenerationMap*} representation of the group, or NULL if invalid.
 */
- (IonKVPAccessBasedGenerationMap*) colorMap;

/**
 * This will get the color group map.
 * @returns {IonKVPAccessBasedGenerationMap*} representation of the group, or NULL if invalid.
 */
- (IonKVPAccessBasedGenerationMap*) gradientMap;

/**
 * This will get the color group map.
 * @returns {IonKVPAccessBasedGenerationMap*} representation of the group, or NULL if invalid.
 */
- (IonKVPAccessBasedGenerationMap*) imageMap;

/**
 * This will get the color group map.
 * @returns {IonKVPAccessBasedGenerationMap*} representation of the group, or NULL if invalid.
 */
- (IonKVPAccessBasedGenerationMap*) kvpMap;

/**
 * This will get the color group map.
 * @returns {IonKVPAccessBasedGenerationMap*} representation of the group, or NULL if invalid.
 */
- (IonKVPAccessBasedGenerationMap*) styleMap;



@end

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
static NSString* sColorsGroupKey = @"colors";
static NSString* sGradientsGroupKey = @"gradients";
static NSString* sImagesGroupKey = @"images";
static NSString* sKVPGroupKey = @"kvp";
static NSString* sStylesGroupKey = @"styles";

/** The Attribute Generation Block;
 * @param {IonKVPAccessBasedGenerationMap*} this is the context of generation, this is normaly the root map, or the parrent map.
 * @param {IonKeyValuePair*} this is the data in KeyValuePair fourm.
 * @retruns {id} the object that should be cached, and returned.
 */
typedef id(^IonAttributeGenerationBlock)(IonKVPAccessBasedGenerationMap* context, IonKeyValuePair* data);

@interface IonKVPAccessBasedGenerationMap (StanderdResolution)

@property (strong, nonatomic) IonKVPAccessBasedGenerationMap* parrentMap;

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

/**
 * This will resolve the map for the specified key.
 * @returns {IonKVPAccessBasedGenerationMap*} representation of the map, or NULL if invalid.
 */
- (IonKVPAccessBasedGenerationMap*) resolveMapAttribute:(NSString*) key;
#pragma mark Color Getter

/**
 * This will get the color from the color map.
 * @param {NSString*} color key to look for.
 * @returns {UIColor*} representation of the input, or NULL if invalid.
 */
- (UIColor*) colorFromMapWithKey:(NSString*) colorKey;





@end
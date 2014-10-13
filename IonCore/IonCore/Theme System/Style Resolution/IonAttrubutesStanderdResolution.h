//
//  IonAttrubutesStanderdResolution.h
//  Ion
//
//  Created by Andrew Hurst on 7/19/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <IonData/IonData.h>

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
 * @param context - this is the context of generation, this is normally the root map, or the parent map.
 * @param data - this is the data in KeyValuePair forum.
 * @retruns {id} the object that should be cached, and returned.
 */
typedef id(^IonAttributeGenerationBlock)(IonKVPAccessBasedGenerationMap *context, IonKeyValuePair *data);

@interface IonKVPAccessBasedGenerationMap (StanderdResolution)

@property (strong, nonatomic) IonKVPAccessBasedGenerationMap*parentMap;

/**
 * This resolves a color key into a UIColor.
 * @param value - the key for us to look for.
 * @return {IonGradientConfiguration*} representation of the input, or NULL if invalid.
 */
- (UIColor*) resolveColorAttribute:(NSString *)value;

/**
 * This resolves a gradient key into a gradientConfiguration
 * @param value - the key for us to look for.
 * @return {IonGradientConfiguration*} representation of the input, or NULL if invalid.
 */
- (IonGradientConfiguration*) resolveGradientAttribute:(NSString *)value;

/**
 * Gets the Root Style.
 */
- (IonStyle *)rootStyle;

/**
 * This will resolve the map for the specified key.
 * @param key - the key of the attribute to resolve.
 * @return representation of the map, or NULL if invalid.
 */
- (IonKVPAccessBasedGenerationMap*) resolveMapAttribute:(NSString*) key;
#pragma mark Color Getter

/**
 * This will get the color from the color map.
 * @param colorKey - color key to look for.
 * @return {UIColor*} representation of the input, or NULL if invalid.
 */
- (UIColor*) colorFromMapWithKey:(NSString *)colorKey;





@end

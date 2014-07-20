//
//  IonAttrubutesStanderdResolution.m
//  Ion
//
//  Created by Andrew Hurst on 7/19/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonAttrubutesStanderdResolution.h"
#import "IonKeyValuePair.h"
#import "UIColor+IonColor.h"
#import "IonStyle.h"

@implementation IonKVPAccessBasedGenerationMap (StanderdResolution)

/**
 * This will resolve a color with the inputed key;
 * @param {NSString} the key to search for.
 * @return {UIColor} representation of the input, or NULL if invalid.
 */
- (UIColor*) resolveColorAttrubute:(NSString*) value {
    return [UIColor resolveWithValue: value andAttrubutes: self];
}

/**
 * This resolves a gradient key into a gradientConfiguration
 * @param {NSString*} the key for us to look for.
 * @returns {IonGradientConfiguration*} representation of the input, or NULL if invalid.
 */
- (IonGradientConfiguration*) resolveGradientAttribute:(NSString*) value {
    return  [[[self gradientMap] objectForKey: value] toGradientConfiguration];
}

/**
 * This resolves a style key into a IonStyle object.
 * @param {NSString*} the key for us to look for.
 * @returns {IonStyle*} representation of the input, or NULL if invalid.
 */
- (IonStyle*) resolveStyleAttribute:(NSString*) value {
    IonStyle* style = [[[self styleMap] objectForKey: value] toStyle];
    [style setResolutionAttributes: self];
    
    return style;
}

/**
 * This resolves a Image key into a UIImage object.
 * @param {NSString*} the key for us to look for.
 * @returns {UIImage*} representation of the input, or NULL if invalid.
 */
- (IonImageRef*) resolveImageAttribute:(NSString*) value {
    return [[[self imageMap] objectForKey: value] toImageRef];
}

/**
 * This resolves a KVP key into a KVP object.
 * @param {NSString*} the key for us to look for.
 * @returns {UIImage*} representation of the input, or NULL if invalid.
 */
- (IonKeyValuePair*) resolveKVPAttribute:(NSString*) value {
    return [[self kvpMap] objectForKey: value];
}


#pragma mark Color Getter

/**
 * This will get the color from the color map.
 * @param {NSString*} color key to look for.
 * @returns {UIColor*} representation of the input, or NULL if invalid.
 */
- (UIColor*) colorFromMapWithKey:(NSString*) colorKey {
    return (UIColor*)[[self colorMap] objectForKey: colorKey];
}

#pragma mark Group Getters
/**
 * This will get the color group map.
 * @returns {IonKVPAccessBasedGenerationMap*} representation of the group, or NULL if invalid.
 */
- (IonKVPAccessBasedGenerationMap*) colorMap {
    return [[self KVPForKey: sColorsGroupKey] toKVPAccessBasedGenerationMap];
}

/**
 * This will get the color group map.
 * @returns {IonKVPAccessBasedGenerationMap*} representation of the group, or NULL if invalid.
 */
- (IonKVPAccessBasedGenerationMap*) gradientMap {
    return [[self KVPForKey: sGradientsGroupKey] toKVPAccessBasedGenerationMap];
}

/**
 * This will get the color group map.
 * @returns {IonKVPAccessBasedGenerationMap*} representation of the group, or NULL if invalid.
 */
- (IonKVPAccessBasedGenerationMap*) imageMap {
    return [[self KVPForKey: sImagesGroupKey] toKVPAccessBasedGenerationMap];
}

/**
 * This will get the color group map.
 * @returns {IonKVPAccessBasedGenerationMap*} representation of the group, or NULL if invalid.
 */
- (IonKVPAccessBasedGenerationMap*) kvpMap {
    return [[self KVPForKey: sKVPGroupKey] toKVPAccessBasedGenerationMap];
}

/**
 * This will get the color group map.
 * @returns {IonKVPAccessBasedGenerationMap*} representation of the group, or NULL if invalid.
 */
- (IonKVPAccessBasedGenerationMap*) styleMap {
    return [[self KVPForKey: sStylesGroupKey] toKVPAccessBasedGenerationMap];
}

@end

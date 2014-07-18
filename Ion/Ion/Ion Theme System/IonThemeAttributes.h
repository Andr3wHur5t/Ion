//
//  IonThemeAttributes.h
//  Ion
//
//  Created by Andrew Hurst on 7/16/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IonAccessBasedGenerationMap.h"


@class IonGradientConfiguration;

/** Group Definitions
 */
static const NSString* sColorsKey = @"colors";
static const NSString* sGradientsKey = @"gradients";
static const NSString* sImagesKey = @"images";
static const NSString* sKVPKey = @"kvp";
static const NSString* sStylesKey = @"styles";

@class IonStyle;

@interface IonThemeAttributes : NSObject

/** This is the map where we hold all of our colors
 */
@property (strong, nonatomic, readonly) IonAccessBasedGenerationMap* colors;

/** This is the map where we hold all of our image refrences
 */
@property (strong, nonatomic, readonly) IonAccessBasedGenerationMap* images;

/** This is the map where we hold all of our gradients
 */
@property (strong, nonatomic, readonly) IonAccessBasedGenerationMap* gradients;

/** This is the map where we hold all of our key value pairs
 */
@property (strong, nonatomic, readonly) IonAccessBasedGenerationMap* kvp;

/** This is the map where we hold all of our styles
 */
@property (strong, nonatomic, readonly) IonAccessBasedGenerationMap* styles;

#pragma mark Interfaces

/**
 * This will construct our attribute using the inputed configuration object.
 * @param {NSDictionary*} the configuration to use.
 * @returns {instancetype}
 */
- (instancetype) initWithConfiguration:(NSDictionary*) configuration;

/**
 * This sets the configuration of the atrubute groups using the inputed configuration.
 * @param {NSDictionary*} the configuration to set the attrubuite groups to.
 * @returns {void}
 */
- (void) setAttributeGroupsWithConfiguration:(NSDictionary*) config;


#pragma mark Attrubute Resolution

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
- (UIImage*) resolveImageAttribute:(NSString*) value;

/**
 * This resolves a KVP key into a KVP object.
 * @param {NSString*} the key for us to look for.
 * @returns {UIImage*} representation of the input, or NULL if invalid.
 */
- (NSObject*) resolveKVPAttribute:(NSString*) value;

@end

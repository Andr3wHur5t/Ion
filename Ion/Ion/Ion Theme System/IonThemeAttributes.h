//
//  IonThemeAttributes.h
//  Ion
//
//  Created by Andrew Hurst on 7/16/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IonAccessBasedGenerationMap.h"

#import "IonStyle.h"
#import "IonGradientConfiguration.h"
#import "UIColor+IonColor.h"

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
 * This will init the attributes using the inputed configuration.
 * @param {NSDictionary*} a configuration dictionary
 * @returns {instancetype}
 */
- (instancetype) initWithConfiguration:(NSDictionary*) configuration;

/**
 * This sets the configuration of the atrubute groups using the inputed configuration.
 * @param {NSDictionary*} the configuration to set the attrubuite groups to.
 * @returns {void}
 */
- (void) setAttributeGroupsWithConfiguration:(NSDictionary*) config;


#pragma mark search queries

/**
 * This will try to find a style using the inputed name
 * @param {NSString*} the name of the style we want.
 * @returns {IonStyle} a style object, or NULL if nothing could be found
 */
- (IonStyle*) styleWithName:(NSString*) name;

/**
 * This will try to find a color using the inputed name
 * @param {NSString*} the name of the color we want.
 * @returns {UIColor*} a color object, or NULL if nothing could be found.
 */
- (UIColor*) colorWithName:(NSString*) name;

/**
 * This will try to find a gradient using the inputed name
 * @param {NSString*} the name of the gradient we want.
 * @returns {IonGradientConfiguration} a gradient configuration object, or NULL if nothing could be found.
 */
- (IonGradientConfiguration*) gradientWithName:(NSString*) name;


@end

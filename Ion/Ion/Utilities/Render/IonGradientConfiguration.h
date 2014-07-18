//
//  IonColorWeight.h
//  Ion
//
//  Created by Andrew Hurst on 7/13/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IonThemeAttributes.h"

/**
 * ==================== Ion Color Weight ====================
 */

@interface IonColorWeight : NSObject

/**
 * This generates the color weight array from the inputted gradient map.
 * @param {NSDictionary*} the gradient map.
 * @returns {NSArray} the resulting color weight array, or NULL if invalid.
 */
+ (NSArray*) colorWeightArrayFromMap:(NSDictionary*) map andAttrubutes:(IonThemeAttributes*) attributes

/**
 * This generates the color weight array from the inputted gradient map.
 * @param {NSDictionary*} the gradient map.
 * @returns {NSArray} the resulting color weight array, or NULL if invalid.
 */
+ (IonColorWeight*) colorWeightFromMap:(NSDictionary*) map andAttrubutes:(IonThemeAttributes*) attributes;

/**
 * This is a convience constructor.
 * @param {UIColor*} the color to assign to the inputted weight
 * @param {CGFloat*} the weight to assign to the inputted color
  * @returns {instancetype}
 */
- (instancetype) initWithColor:(UIColor*) color andWeight:(CGFloat) weight;

/**
 * This creates a color weight set using a NSDictionary configuration.
 * if any data is invalid it will return NULL.
 * @param {NSDictionary*} the configuration of the color weight
 @ @returns {instancetype}
 */
- (instancetype) initWithConfiguration:(NSDictionary*) config;

/**
 * This is the color value, this says what the color will be.
 */
@property (strong, nonatomic) UIColor* color;

/**
 * This is the weight object it says where the color will be.
 */
@property (assign, nonatomic) CGFloat weight;

@end


/**
 * ==================== Ion Gradient Configuration ====================
 */

@interface IonGradientConfiguration : NSObject

/**
 * This is a resolution constructor, so we can resolve a configurationObject from the inputed map.
 * @param {NSDictionary*} the map we will resolve from.
 * @param {IonThemeAttributes*} the attributes we should search to get correct values.
 * @returns {IonGradientConfiguration*}
 */
+ (IonGradientConfiguration*) resolveWithMap:(NSDictionary*) map andAttrubutes:(IonThemeAttributes*) attributes;

/**
 * This is a convience constructor.
 * @param {NSArray*} the color weights for the configuration.
  * @returns {instancetype}
 */
- (instancetype) initWithColorWeights:(NSArray*) colorWeights;

/**
 * This is the color weights that will be used in the creation of the gradient.
 */
@property (strong, nonatomic) NSArray* colorWeights;

@end

/**
 * ==================== Ion Linear Gradient Configuration ====================
 */

@interface IonLinearGradientConfiguration : IonGradientConfiguration

/**
 * This is a resolution constructor, so we can resolve a configurationObject from the inputed map.
 * @param {NSDictionary*} the map we will resolve from.
 * @param {IonThemeAttributes*} the attributes we should search to get correct values.
 * @returns {IonLinearGradientConfiguration*}
 */
+ (IonLinearGradientConfiguration*) resolveWithMap:(NSDictionary*) map
                                     andAttrubutes:(IonThemeAttributes*) attributes;
/**
 * This is a convience constructor.
 * @param {NSArray*} the color weights for the configuration.
 * @param {CGFloat} the angle of the linear gradient.
 * @returns {instancetype}
 */
- (instancetype) initWithColor:(NSArray*) colorWeights andAngel:(CGFloat) angle;

/**
 * This is the angle in radians that the gradient will be at
 */
@property (assign, nonatomic) CGFloat angle;

@end
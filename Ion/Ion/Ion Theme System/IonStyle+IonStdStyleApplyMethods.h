//
//  IonStyle+IonStdStyleApplyMethods.h
//  Ion
//
//  Created by Andrew Hurst on 7/21/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonStyle.h"
#import "UIView+IonBackgroundUtilities.h"
#import "IonThemePointer.h"

/** Keys for style
 */
static NSString* sStyleSTDBackgroundKey = @"background";
static NSString* sStyleSTDCornerRadiusKey = @"cornerRadius";
static NSString* sStyleSTDBorderKey = @"border";
static NSString* sStyleSTDShadowKey = @"shadow";
static NSString* sStyleSTDParametersKey = @"parameters";

/** Keys For Border
 */
static NSString* sBorderColorKey = @"color";
static NSString* sBorderWidthKey = @"width";

/** Keys For shadow
 */
static NSString* sShadowColorKey = @"color";
static NSString* sShadowOffsetKey = @"offset";
static NSString* sShadowRadiusKey = @"radius";




/**
 * This is where we apply our style properties
 */
@interface IonStyle (IonStdStyleApplyMethods)

/**
 * Adds the STD proprieties to the method map.
 * @returns {void}
 */
- (void) addIonStdStyleApplyProprieties;

#pragma mark Processors

/**
 * Sets the background of the view if provided a valid effect pointer.
 * @param {UIView*} the view to set to.
 * @param {NSDitionary*} the effect pointer.
 * @returns {id} null when finshed.
 */
- (id) setBackgroundOnView:(UIView*) view withPointer:(NSDictionary*) pointer;


/**
 * Sets the corner radius on the inputted view to the inputted value.
 * @param {UIView*} the view to set to.
 * @param {NSNumber*} the radius to use.
 * @returns {id} null when finshed.
 */
- (id) setCornerRadius:(UIView*) view withRaidus:(NSNumber*) radius;

/**
 * Sets the border color, and width on the inputted view to match the inputted config.
 * @param {UIView*} the view to set to.
 * @param {NSDictionary*} the configuration object to use.
 * @returns {id} null when finshed.
 */
- (id) setBorder:(UIView*) view withConfig:(NSDictionary*) config;

/**
 * Sets the shadow on the inputted view to match the inputted config.
 * @param {UIView*} the view to set to.
 * @param {NSDictionary*} the configuration object to use.
 * @returns {id} null when finshed.
 */
- (id) setShadow:(UIView*) view withConfig:(NSDictionary*) config;

@end

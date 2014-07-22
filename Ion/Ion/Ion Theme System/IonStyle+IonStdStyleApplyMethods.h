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

/** Keys For Border
 */
static NSString* sBorderColorKey = @"color";
static NSString* sBorderWidthKey = @"color";

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
 * This adds the STD proprieties to the method map.
 * @returns {void}
 */
- (void) addIonStdStyleApplyProprieties;

#pragma mark Processors

/**
 * This sets the background of the view if it has a valid effect pointer.
 * @param {UIView*} the view to set the background of.
 * @returns {id} null when finished.
 */
- (id) setBackgroundOnView:(UIView*) view;

@end

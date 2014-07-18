//
//  IonStyle.h
//  Ion
//
//  Created by Andrew Hurst on 7/16/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IonThemeAttributes.h"

@interface IonStyle : NSObject
#pragma mark External Interface

/**
 * This will resolve a style using a map and an Attrbute Set.
 * @param {NSDictionary*} the map to process
 * @param {IonThemeAttributes*} the theme attrubute set to do our searches on if needed.
 * @returns {UIColor*} representation, or NULL of invalid
 */
+ (IonStyle*) resolveWithMap:(NSDictionary*) map andAttrubutes:(IonThemeAttributes*) attributes;

/**
 * This applys the current style to the inputted view.
 * @param {UIVIew*} the view to apply the style to.
 * @returns {void}
 */
- (void) applyToView:(UIView*)view;

/**
 * This overrides the current styles proproties with the inputed style.
 * @param {IonStyle*} the style to override the current style
 * @returns {IonStyle*} the net style of the overide
 */
- (IonStyle*) overideStyleWithStyle:(IonStyle*)overideingStyle;
@end

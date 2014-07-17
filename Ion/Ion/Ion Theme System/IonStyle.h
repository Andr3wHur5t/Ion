//
//  IonStyle.h
//  Ion
//
//  Created by Andrew Hurst on 7/16/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IonStyle : NSObject
#pragma mark External Interface

/**
 * This is a Parseing constructor
 */
- (instancetype) initWithConfiguration:(NSDictionary*) config;

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

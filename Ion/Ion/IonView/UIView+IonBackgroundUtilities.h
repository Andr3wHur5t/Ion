//
//  UIView+IonBackgroundUtilities.h
//  Ion
//
//  Created by Andrew Hurst on 7/13/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IonRenderUtilities.h"

@interface UIView (IonBackgroundUtilities)

#pragma mark Gradient Backgrounds

/**
 * This sets the background to a linear gradient with the specified confiuration.
 * @param {IonLinearGradientConfiguration*} the gradient configuration to use in generation of the gradent
 * @returns {void}
 */
- (void) setBackgroundToLinearGradient:(IonLinearGradientConfiguration*)gradientConfig;

/**
 * This sets the background to a linear gradient with the specified confiuration.
 * @param {IonLinearGradientConfiguration*} the gradient configuration to use in generation of the gradient
 * @param {(void(^)())} the compleation to be called when finished
 * @returns {void}
 */
- (void) setBackgroundToLinearGradient:(IonLinearGradientConfiguration*)gradientConfig compleation:(void(^)())compleation;


#pragma mark Image Backgrounds

/**
 * This sets the current background image.
 * @parma {UIImage*} the image to be set to the background
 */
-(void) setBackgroundImage:(UIImage*)image;






/** TODO: Add Easy Mask Mode */

/** TODO: Add Easy Background image setting */

/** TODO: Add Border Size Setting, Note causes Offscreen calls*/




@end

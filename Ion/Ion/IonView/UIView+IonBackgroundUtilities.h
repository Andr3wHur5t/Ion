//
//  UIView+IonBackgroundUtilities.h
//  Ion
//
//  Created by Andrew Hurst on 7/13/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IonData/IonRenderUtilities.h>


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
- (void) setBackgroundToLinearGradient:(IonLinearGradientConfiguration*)gradientConfig compleation:( void(^)( ) )compleation;


#pragma mark Image Backgrounds

/**
 * This sets the image to the specified CALayer and configures it.
 * @param {UIImage*} the image to be set
 * @param {CALayer*} the layer for the image to be set to
 */
+ (void) setImage:(UIImage*)image toLayer:(CALayer*)layer;

/**
 * This sets the current background image.
 * @parma {UIImage*} the image to be set to the background
 */
-(void) setBackgroundImage:(UIImage*)image;

/**
 * This sets the mask Image of the view.
 * @param {UIImage*} The image to be set as the mask
 * @return {void}
 */
- (void) setMaskImage:(UIImage*)image;


/** TODO: Add Border Size Setting, Note causes Offscreen calls*/




@end

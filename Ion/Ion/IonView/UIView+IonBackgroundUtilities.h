//
//  UIView+IonBackgroundUtilities.h
//  Ion
//
//  Created by Andrew Hurst on 7/13/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IonData/IonRenderUtilities.h>

typedef enum : NSUInteger {
    IonBackgroundRenderFilled = 0,
    IonBackgroundRenderContained = 1
} IonBackgroundRenderOptions;

@interface UIView (IonBackgroundUtilities)

#pragma mark Gradient Backgrounds

/**
 * Sets the background to a linear gradient with the specified configuration.
 * @param {IonLinearGradientConfiguration*} the gradient configuration to use in generation of the gradient
 * @returns {void}
 */
- (void) setBackgroundToLinearGradient:(IonLinearGradientConfiguration*)gradientConfig;

/**
 * Sets the background to a linear gradient with the specified configuration.
 * @param {IonLinearGradientConfiguration*} the gradient configuration to use in generation of the gradient
 * @param {(void(^)())} the completion to be called when finished
 * @returns {void}
 */
- (void) setBackgroundToLinearGradient:(IonLinearGradientConfiguration*)gradientConfig completion:( void(^)( ) )completion;


#pragma mark Image Backgrounds

/**
 * Sets the image to the specified CALayer and configures it.
 * @param {UIImage*} the image to be set
 * @param {CALayer*} the layer for the image to be set to
 * @param {IonBackgroundRenderOptions} the mode which to render the image.
 */
+ (void) setImage:(UIImage*)image toLayer:(CALayer*)layer renderMode:(IonBackgroundRenderOptions) renderMode;

#pragma mark Background
/**
 * Sets the current background image.
 * @parma {UIImage*} the image to be set to the background
 */
-(void) setBackgroundImage:(UIImage*)image;

/**
 * Sets the current background image.
 * @parma {UIImage*} the image to be set to the background
 * @param {IonBackgroundRenderOptions} the mode which to render the image.
 */
-(void) setBackgroundImage:(UIImage*)image renderMode:(IonBackgroundRenderOptions) renderMode;

/**
 * Sets the current background image from the key in fill mode.
 * @param {NSString*} the key of the image you want to set.
 * @returns {void*}
 */
- (void) setBackgroundImageUsingKey:(NSString*) key;

/**
 * Sets the current background image from the key in fill mode.
 * @param {NSString*} the key of the image you want to set.
 * @param {IonBackgroundRenderOptions} the mode which to render the image.
 * @returns {void*}
 */
- (void) setBackgroundImageUsingKey:(NSString*) key inRenderMode:(IonBackgroundRenderOptions) renderMode;

#pragma mark Mask
/**
 * This sets the mask Image of the view.
 * @param {UIImage*} The image to be set as the mask
 * @return {void}
 */
- (void) setMaskImage:(UIImage*)image;

/**
 * This sets the mask Image of the view in the specified render mode.
 * @param {UIImage*} The image to be set as the mask
 * @param {IonBackgroundRenderOptions} the mode which to render the image.
 * @return {void}
 */
- (void) setMaskImage:(UIImage*)image renderMode:(IonBackgroundRenderOptions) renderMode;

/**
 * Sets the current mask image from the key in contained mode.
 * @param {NSString*} the key of the image you want to set.
 * @returns {void*}
 */
- (void) setMaskImageUsingKey:(NSString*) key;

/**
 * Sets the current mask image from the key in fill mode.
 * @param {NSString*} the key of the image you want to set.
 * @param {IonBackgroundRenderOptions} the mode which to render the image.
 * @returns {void*}
 */
- (void) setMaskImageUsingKey:(NSString*) key inRenderMode:(IonBackgroundRenderOptions) renderMode;



#pragma mark Utilities

/**
 * Reports if the view is visible.
 * @returns {BOOL}
 */
- (BOOL) isVisible;

@end

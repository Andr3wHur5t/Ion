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
 * @param {IonLinearGradientConfiguration*} the gradient configuration to use in
 * generation of the gradient
 */
- (void)setBackgroundToLinearGradient:
        (IonLinearGradientConfiguration *)gradientConfig;

/**
 * Sets the background to a linear gradient with the specified configuration.
 * @param {IonLinearGradientConfiguration*} the gradient configuration to use in
 * generation of the gradient
 * @param {(void(^)())} the completion to be called when finished
 */
- (void)setBackgroundToLinearGradient:
            (IonLinearGradientConfiguration *)gradientConfig
                           completion:(void (^)())completion;

#pragma mark Image Backgrounds

/*!
 @brief Sets the image to the specified CALayer and configures it.

 @param image the image to be set
 @param layer the layer for the image to be set to
 @param renderMode the mode which to render the image.
 */
+ (void)setImage:(UIImage *)image
         toLayer:(CALayer *)layer
      renderMode:(IonBackgroundRenderOptions)renderMode;

/*!
 @brief Sets the image to the specified CALayer and configures it.

 @param image the image to be set
 @param layer the layer for the image to be set to
 @param renderMode the mode which to render the image.
 @param completion the completion to call when the operation completes or fails
 */
+ (void)setImage:(UIImage *)image
         toLayer:(CALayer *)layer
      renderMode:(IonBackgroundRenderOptions)renderMode
      completion:(void (^)(NSError *))completion;

#pragma mark Background
/*!
 @brief Sets the background image of the view.

 @param image      The image to set to the background.
 */
- (void)setBackgroundImage:(UIImage *)image;

/*!
 @brief Sets the background image of the view.

 @param image      The image to set to the background.
 @param renderMode The mode to render the background image in.
 */
- (void)setBackgroundImage:(UIImage *)image
                renderMode:(IonBackgroundRenderOptions)renderMode;

/*!
 @brief Sets the background image of the view.

 @param image      The image to set to the background.
 @param renderMode The mode to render the background image in.
 @param completion The completion to call.
 */
- (void)setBackgroundImage:(UIImage *)image
                renderMode:(IonBackgroundRenderOptions)renderMode
                completion:(void (^)(NSError *))completion;

/*!
 @brief Set the background image to the image with the specified key.

 @param key The key of the image to use.
 */
- (void)setBackgroundImageUsingKey:(NSString *)key;

/*!
 @brief Set the background image to the image with the specified key.

 @param key        The key of the image to use.
 @param renderMode The mode to render the image in.
 */
- (void)setBackgroundImageUsingKey:(NSString *)key
                      inRenderMode:(IonBackgroundRenderOptions)renderMode;

/*!
 @brief Set the background image to the image with the specified key.

 @param key         The key of the image to use.
 @param renderMode  The mode to render the image in.
  @param completion The completion to call.
 */
- (void)setBackgroundImageUsingKey:(NSString *)key
                      inRenderMode:(IonBackgroundRenderOptions)renderMode
                        completion:(void (^)(NSError *))completion;

#pragma mark Mask
/*!
 @brief Sets the mask layer using the inputted image.

 @param image      The image to use as the mask
 */
- (void)setMaskImage:(UIImage *)image;

/*!
 @brief Sets the mask layer using the inputted image.

 @param image      The image to use as the mask
 @param renderMode The mode used to render the mask image.
 */
- (void)setMaskImage:(UIImage *)image
          renderMode:(IonBackgroundRenderOptions)renderMode;

/*!
 @brief Sets the mask layer using the inputted image.

 @param image      The image to use as the mask
 @param renderMode The mode used to render the mask image.
 @param completion The completion to call when the mask image has been set.
 */
- (void)setMaskImage:(UIImage *)image
          renderMode:(IonBackgroundRenderOptions)renderMode
          completion:(void (^)(NSError *))completion;

/*!
 @brief Sets the mask layer using the inputted image key.

 @param key        The key of the image to use as the mask.
 */
- (void)setMaskImageUsingKey:(NSString *)key;

/*!
 @brief Sets the mask layer using the inputted image key.

 @param key        The key of the image to use as the mask.
 @param renderMode The mode used to render the mask image.
 */
- (void)setMaskImageUsingKey:(NSString *)key
                inRenderMode:(IonBackgroundRenderOptions)renderMode;

/*!
 @brief Sets the mask layer using the inputted image key.

 @param key        The key of the image to use as the mask.
 @param renderMode The mode used to render the mask image.
 @param completion The completion to call when the mask image has been set.
 */
- (void)setMaskImageUsingKey:(NSString *)key
                inRenderMode:(IonBackgroundRenderOptions)renderMode
                  completion:(void (^)(NSError *))completion;

#pragma mark Utilities

/*!
 @brief Reports if the view is visible.
 */
- (BOOL)isVisible;

@end

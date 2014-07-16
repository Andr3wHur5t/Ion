//
//  UIView+IonBackgroundUtilities.m
//  Ion
//
//  Created by Andrew Hurst on 7/13/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "UIView+IonBackgroundUtilities.h"


@implementation UIView (IonBackgroundUtilities)

#pragma mark Gradient Backgrounds
/**
 * This sets the background to a linear gradient with the specified confiuration.
 * @param {IonLinearGradientConfiguration*} the gradient configuration to use in generation of the gradient
 * @param {(void(^)())} the compleation to be called when finished
 * @returns {void}
 */
- (void) setBackgroundToLinearGradient:(IonLinearGradientConfiguration*)gradientConfig compleation:( void(^)( ) )compleation {
    CGSize netSize = self.frame.size;
    
    // Generate and set the gradient
    [IonRenderUtilities renderLinearGradient:gradientConfig
                                  resultSize:netSize
                             withReturnBlock:^(UIImage *image) {
                                 [self setBackgroundImage:image];
                                 
                                 if ( compleation )
                                     compleation();
                             }];
}

/**
 * This sets the background to a linear gradient with the specified confiuration.
 * @param {IonLinearGradientConfiguration*} the gradient configuration to use in generation of the gradent
 * @returns {void}
 */
- (void) setBackgroundToLinearGradient:(IonLinearGradientConfiguration*)gradientConfig {
    [self setBackgroundToLinearGradient:gradientConfig compleation:NULL];
}



#pragma mark Image Backgrounds

/**
 * This sets the image to the specified CALayer and configures it.
 * @param {UIImage*} the image to be set
 * @param {CALayer*} the layer for the image to be set to
 */
+ (void) setImage:(UIImage*)image toLayer:(CALayer*)layer {
    
    // Scale the view to match the image
    CGFloat nativeWidth = CGImageGetWidth(image.CGImage);
    CGFloat nativeHeight = CGImageGetHeight(image.CGImage);
    CGRect startFrame = CGRectMake(0.0, 0.0, nativeWidth, nativeHeight);
    
    // TODO: Center Image, Resize image, Store in data store.
    
    layer.contents = (__bridge id)(image.CGImage);
    layer.bounds = startFrame;
}

/**
 * This sets the current background image.
 * @param {UIImage*} the image to be set to the background
 */
- (void) setBackgroundImage:(UIImage*)image {
    if ( !image )
        return;
    
    [UIView setImage:image toLayer:self.layer];
}

/**
 * This sets the mask Image of the view.
 * @param {UIImage*} The image to be set as the mask
 * @return {void}
 */
- (void) setMaskImage:(UIImage*)image {
    if ( !image )
        return;
    
    // Create the mask if it dosn't already exsist
    if ( !self.layer.mask )
        self.layer.mask = [[CALayer alloc] init];
    
    // Set the image of the mask
    [UIView setImage:image toLayer:self.layer.mask];
}


@end

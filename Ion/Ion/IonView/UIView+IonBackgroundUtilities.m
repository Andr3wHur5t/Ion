//
//  UIView+IonBackgroundUtilities.m
//  Ion
//
//  Created by Andrew Hurst on 7/13/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "UIView+IonBackgroundUtilities.h"
#import "IonMath.h"


@implementation UIView (IonBackgroundUtilities)

#pragma mark Gradient Backgrounds
/**
 * This sets the background to a linear gradient with the specified configuration.
 * @param {IonLinearGradientConfiguration*} the gradient configuration to use in generation of the gradient
 * @param {(void(^)())} the completion to be called when finished
 * @returns {void}
 */
- (void) setBackgroundToLinearGradient:(IonLinearGradientConfiguration*)gradientConfig completion:( void(^)( ) )completion {
    CGSize netSize = self.frame.size;
    
    // Generate and set the gradient
    [IonRenderUtilities renderLinearGradient:gradientConfig
                                  resultSize:netSize
                             withReturnBlock:^(UIImage *image) {
                                 [self setBackgroundImage:image];
                                 
                                 if ( completion )
                                     completion();
                             }];
}

/**
 * This sets the background to a linear gradient with the specified configuration.
 * @param {IonLinearGradientConfiguration*} the gradient configuration to use in generation of the gradient
 * @returns {void}
 */
- (void) setBackgroundToLinearGradient:(IonLinearGradientConfiguration*)gradientConfig {
    [self setBackgroundToLinearGradient:gradientConfig completion:NULL];
}



#pragma mark Image Backgrounds

/**
 * This sets the image to the specified CALayer and configures it.
 * @param {UIImage*} the image to be set
 * @param {CALayer*} the layer for the image to be set to
 */
+ (void) setImage:(UIImage*)image toLayer:(CALayer*)layer {
    
    // Resize image to fit
    [IonRenderUtilities renderImage: image
                           withSize: layer.frame.size
                     andReturnBlock: ^( UIImage *resImage ) {
                         NSLog(@"Img: %@", resImage );
                         
                         layer.contents = (__bridge id)(resImage.CGImage);
                     }];
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
    
    // Create the mask if it doesn't already exist
    if ( !self.layer.mask )
        self.layer.mask = [[CALayer alloc] init];
    
    // Set the image of the mask
    [UIView setImage:image toLayer:self.layer.mask];
}


@end

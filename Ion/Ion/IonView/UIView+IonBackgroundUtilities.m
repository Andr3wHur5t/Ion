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
- (void) setBackgroundToLinearGradient:(IonLinearGradientConfiguration*)gradientConfig compleation:(void(^)())compleation {
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
 * This sets the current background image.
 * @parma {UIImage*} the image to be set to the background
 */
-(void) setBackgroundImage:(UIImage*)image {
    CGFloat nativeWidth = CGImageGetWidth(image.CGImage);
    CGFloat nativeHeight = CGImageGetHeight(image.CGImage);
    CGRect      startFrame = CGRectMake(0.0, 0.0, nativeWidth, nativeHeight);
    
    self.layer.contents = (__bridge id)(image.CGImage);
    
    self.layer.frame = startFrame;
}



@end

//
//  UIView+IonBackgroundUtilities.m
//  Ion
//
//  Created by Andrew Hurst on 7/13/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "UIView+IonBackgroundUtilities.h"
#import "IonMath.h"
#import "UIView+IonTheme.h"

@implementation UIView (IonBackgroundUtilities)

#pragma mark Gradient Backgrounds
/**
 * This sets the background to a linear gradient with the specified configuration.
 * @param {IonLinearGradientConfiguration*} the gradient configuration to use in generation of the gradient
 * @param {(void(^)())} the completion to be called when finished
 * @returns {void}
 */
- (void) setBackgroundToLinearGradient:(IonLinearGradientConfiguration*)gradientConfig
                            completion:( void(^)( ) )completion {
    CGSize netSize = self.frame.size;
    
    // Generate and set the gradient
    [IonRenderUtilities renderLinearGradient:gradientConfig
                                  resultSize:netSize
                             withReturnBlock:^(UIImage *image) {
                                 self.layer.contents = (__bridge id)(image.CGImage);
                                 
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
 * @param {IonBackgroundRenderOptions} the mode which to render the image.
 * @returns {void}
 */
+ (void) setImage:(UIImage*)image toLayer:(CALayer*)layer renderMode:(IonBackgroundRenderOptions) renderMode {
    void(^returnBlock)( UIImage *resImage );
    if ( !image || !layer )
        return;
    
    // Our Return Block
    returnBlock = ^( UIImage *resImage ) {
        layer.contents = (__bridge id)(resImage.CGImage);
    };
    
    // Check if the image is already the corrent size
    if ( CGSizeEqualToSize( image.size, layer.frame.size) ) {
        returnBlock( image ); // call the return block because we are already the correct size.
        return;
    }
    
    if ( renderMode == IonBackgroundRenderContained )
        [IonRenderUtilities renderImage: image
                           withinSize: layer.frame.size
                     andReturnBlock: returnBlock];
    else
        [IonRenderUtilities renderImage: image
                             withSize: layer.frame.size
                         andReturnBlock: returnBlock];
    NSLog(@"IMG");
}

/**
 * This sets the current background image.
 * @param {UIImage*} the image to be set to the background
 */
- (void) setBackgroundImage:(UIImage*)image {
    [self setBackgroundImage: image renderMode: IonBackgroundRenderFilled];
}

/**
 * This sets the current background image.
 * @parma {UIImage*} the image to be set to the background
 * @param {IonBackgroundRenderOptions} the mode which to render the image.
 * @returns {void}
 */
- (void) setBackgroundImage:(UIImage*)image renderMode:(IonBackgroundRenderOptions) renderMode {
    if ( !image ) {
        self.themeConfiguration.themeShouldBeAppliedToSelf = TRUE;
        return;
    }
    
    self.themeConfiguration.themeShouldBeAppliedToSelf = FALSE;
    [UIView setImage:image toLayer:self.layer renderMode: renderMode];
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
    [UIView setImage:image toLayer:self.layer.mask renderMode: IonBackgroundRenderContained];
}


@end

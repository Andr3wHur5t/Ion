//
//  UIView+IonBackgroundUtilities.m
//  Ion
//
//  Created by Andrew Hurst on 7/13/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "UIView+IonBackgroundUtilities.h"
#import "UIView+IonTheme.h"
#import <IonData/IonData.h>
#import <SimpleMath/SimpleMath.h>


@implementation UIView (IonBackgroundUtilities)

#pragma mark Gradient Backgrounds
/**
 * This sets the background to a linear gradient with the specified configuration.
 * @param {IonLinearGradientConfiguration*} the gradient configuration to use in generation of the gradient
 * @param {(void(^)())} the completion to be called when finished  
 */
- (void) setBackgroundToLinearGradient:(IonLinearGradientConfiguration*)gradientConfig
                            completion:( void(^)( ) )completion {
    CGSize netSize = CGSizeEqualToSize( self.frame.size, CGSizeZero)? (CGSize){ 300, 300 } : self.frame.size;
    NSLog(@"Applying Background to view with size: %@", NSStringFromCGSize(netSize) );
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
 */
+ (void) setImage:(UIImage*)image toLayer:(CALayer*)layer renderMode:(IonBackgroundRenderOptions) renderMode {
    void(^returnBlock)( UIImage *resImage );
    if ( !image || !layer )
        return;
    if ( CGSizeEqualToSize( CGSizeZero, layer.frame.size) ) {
        NSLog( @"%s - Attempted to set image to a view with a size of {0,0} aborting.", __PRETTY_FUNCTION__ );
        return;
    }
    // Our Return Block
    returnBlock = ^( UIImage *resImage ) {
        layer.contents = (id)(resImage.CGImage);
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
}


#pragma mark Background


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
 */
- (void) setBackgroundImage:(UIImage*)image renderMode:(IonBackgroundRenderOptions) renderMode {
    if ( !image ) {
        self.styleCanSetBackground = TRUE;
        return;
    }
    
//    self.themeConfiguration.themeShouldBeAppliedToSelf = FALSE;
    self.styleCanSetBackground = FALSE;
    [UIView setImage:image toLayer:self.layer renderMode: renderMode];
}

/**
 * Sets the current background image from the key in fill mode.
 * @param {NSString*} the key of the image you want to set.
 * @return {void*}
 */
- (void) setBackgroundImageUsingKey:(NSString*) key {
    [self setBackgroundImageUsingKey: key inRenderMode: IonBackgroundRenderFilled];
}

/**
 * Sets the current background image from the key in fill mode.
 * @param {NSString*} the key of the image you want to set.
 * @param {IonBackgroundRenderOptions} the mode which to render the image.
 * @return {void*}
 */
- (void) setBackgroundImageUsingKey:(NSString*) key inRenderMode:(IonBackgroundRenderOptions) renderMode {
    [[IonImageManager interfaceManager] imageForKey: key
                                           withSize: self.frame.size
                                           contined: renderMode == IonBackgroundRenderContained
                                  andReturnCallback: ^(UIImage *image) {
                                      [self setBackgroundImage: image renderMode: renderMode];
                                  }];
}

#pragma mark Mask

/**
 * This sets the mask Image of the view.
 * @param {UIImage*} The image to be set as the mask
 * @return {void}
 */
- (void) setMaskImage:(UIImage*)image {
    [self setMaskImage: image renderMode: IonBackgroundRenderContained];
}

/**
 * This sets the mask Image of the view in the specified rneder mode.
 * @param {UIImage*} The image to be set as the mask
 * @param {IonBackgroundRenderOptions} the mode which to render the image.
 * @return {void}
 */
- (void) setMaskImage:(UIImage*)image renderMode:(IonBackgroundRenderOptions) renderMode {
    if ( !image )
        return;
    
    if ( !self.layer.mask )
        self.layer.mask = [CALayer layer];
    
    self.layer.mask.frame = self.bounds;
    [UIView setImage: image toLayer: self.layer.mask renderMode: renderMode];
}

/**
 * Sets the current mask image from the key in contained mode.
 * @param {NSString*} the key of the image you want to set.
 * @return {void*}
 */
- (void) setMaskImageUsingKey:(NSString*) key {
     [self setMaskImageUsingKey: key inRenderMode: IonBackgroundRenderContained];
}

/**
 * Sets the current mask image from the key in fill mode.
 * @param {NSString*} the key of the image you want to set.
 * @param {IonBackgroundRenderOptions} the mode which to render the image.
 * @return {void*}
 */
- (void) setMaskImageUsingKey:(NSString*) key inRenderMode:(IonBackgroundRenderOptions) renderMode {
    [[IonImageManager interfaceManager] imageForKey: key
                                           withSize: self.frame.size
                                           contined: renderMode == IonBackgroundRenderContained
                                  andReturnCallback: ^(UIImage *image) {
                                      [self setMaskImage: image renderMode: renderMode];
                                  }];
}


#pragma mark Utilities

/**
 * Reports if the view is visible.
 * @return {BOOL}
 */
- (BOOL) isVisible {
    return self.isHidden && self.alpha != 0.0f;
}

@end

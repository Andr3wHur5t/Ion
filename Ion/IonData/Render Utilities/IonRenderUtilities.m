//
//  IonRenderUtilities.m
//  Ion
//
//  Created by Andrew Hurst on 7/13/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonRenderUtilities.h"
#import "IonMath.h"

static const char* IonRenderQueueLabel = "ION_RENDER_QUEUE";



@implementation IonRenderUtilities

#pragma mark Primary Utilities

/**
 * This renders the inputed render block in the render thread, and returns the result in the result block.
 * Note: this uses CGContext based rendering.
 * @param {void^()} the work to be rendered
 * @param {CGSize} the size of the context
 * @param {CGFloat} this is the scale of the context
 * @param {bool} states if the context and the resulting image have an alpha channel
 * @param {void^(UIImage*)} the block to be called once the work is done
 * @returns {void}
 */
+ (void) renderBlock: (void(^)()) block
   inContextWithSize: (CGSize) contextSize
               scale: (CGFloat) scale
        thatHasAlpha: (bool) isAlpha
      andReturnBlock: (IonRenderReturnBlock) returnBlock {
    if ( scale == 0.0f )
        scale = 1.0f;
    if ( CGSizeEqualToSize( contextSize, CGSizeZero ) )
        contextSize = (CGSize){ 100.0f, 100.0f };
    
    // Check if we have work to do, and that we have a place to return the results of our labor.
    if ( block && returnBlock ) {
        dispatch_async( [IonRenderUtilities renderDispatchQueue], ^{
            UIImage* resultImage;
            
            // Create the context for drawing
            UIGraphicsBeginImageContextWithOptions( contextSize, !isAlpha , scale );
            
            // Render Inputed work
            block();
            
            // Record Result
            resultImage = UIGraphicsGetImageFromCurrentImageContext();
            
            // Clean Up
            UIGraphicsEndImageContext();
            
            // Return result on the main thread
            dispatch_async( dispatch_get_main_queue(), ^{
                returnBlock( resultImage );
            });
            
        });
    } else {
        [NSException exceptionWithName:@"Missing Argument!"
                                reason:@"IonRenderUtilities was told to do work with out any work Block or any Result block."
                              userInfo:NULL];
    }
}

/**
 * This renders the inputed render block in the render thread, and returns the result in the result block.
 * Note: this uses CGContext based rendering.
 * @param {void^()} the work to be rendered
 * @param {CGSize} the size of the context
 * @param {bool} states if the context and the resulting image have an alpha channel
 * @param {void^(UIImage*)} the block to be called once the work is done
 * @returns {void}
 */
+ (void) renderBlock: (void(^)()) block
   inContextWithSize: (CGSize) contextSize
        thatHasAlpha: (bool) isAlpha
      andReturnBlock: (IonRenderReturnBlock) returnBlock {
    
    [IonRenderUtilities renderBlock: block
                  inContextWithSize: contextSize
                              scale: 1.0f
                       thatHasAlpha: isAlpha
                     andReturnBlock: returnBlock];
}

/**
 * This renders the inputed render block in the render thread, and returns the result in the result block.
 * Note: this uses CGContext based rendering.
 * @param {void^()} the work to be rendered
 * @param {CGSize} the size of the context
 * @param {void^(UIImage*)} the block to be called once the work is done
 * @returns {void}
 */
+ (void) renderBlock: (void(^)()) block
   inContextWithSize: (CGSize) contextSize
      andReturnBlock: (IonRenderReturnBlock) returnBlock {
    
    [IonRenderUtilities renderBlock: block
                  inContextWithSize: contextSize
                              scale: 1.0f
                       thatHasAlpha: true
                     andReturnBlock: returnBlock];
}



/**
 * This renders the inputed render block in the render thread, and returns the result in the result block.
 * Note: this uses CGContext based rendering.
 * @param {void^()} the work to be rendered
 * @param {CGSize} the size of the context
 * @param {CGFloat} this is the scale of the context
 * @param {bool} states if the context and the resulting image have an alpha channel
 * @param {void^(UIImage*)} the block to be called once the work is done
 * @returns {void}
 */
+ (void) renderTestingInMainBlock: (void(^)()) block
   inContextWithSize: (CGSize) contextSize
               scale: (CGFloat) scale
        thatHasAlpha: (bool) isAlpha
      andReturnBlock: (IonRenderReturnBlock) returnBlock {
    
    // Check if we have work to do, and that we have a place to return the results of our labor.
    if ( block && returnBlock ) {
        
            UIImage* resultImage;
            
            // Create the context for drawing
            UIGraphicsBeginImageContextWithOptions( contextSize, !isAlpha , scale );
            
            // Render Inputed work
            block();
            
            // Record Result
            resultImage = UIGraphicsGetImageFromCurrentImageContext();
            
            // Clean Up
            UIGraphicsEndImageContext();
            
            // Return result on the main thread
            returnBlock(resultImage);
    } else {
        [NSException exceptionWithName:@"Missing Argument!"
                                reason:@"IonRenderUtilities was told to do work with out any work Block or any Result block."
                              userInfo:NULL];
    }
}

#pragma mark Gradient Utilities

/**
 * This takes an inputed set of color weights, and converts them into a CGGradientRef.
 * @peram {NSArray} the array of color weights to be converted.
 * @returns {CGGradientRef}
 */
+ (CGGradientRef) referenceGradientFromColorWeights:(NSArray*) colorWeights {
    @autoreleasepool {
        CGGradientRef result;
        CGColorSpaceRef space;
        NSMutableArray* colors;
        CGFloat* weights;
        if ( !colorWeights )
            return NULL;
    
        
        space = CGColorSpaceCreateDeviceRGB();
        colors = [[NSMutableArray alloc] init];
        weights = (CGFloat*)malloc( sizeof( float ) * [colorWeights count] );
        unsigned int index = 0;
        for( IonColorWeight* colorWeight in colorWeights) {
            [colors addObject: (id)colorWeight.color.CGColor ];
            weights[index] = colorWeight.weight;
            ++index;
        }
        result = CGGradientCreateWithColors(space, (CFArrayRef)colors, weights );
        
        // Clean Up
        CFBridgingRelease( space );
        free( weights );
        colors = NULL;
        return result;
    }
}

/**
 * This will create a linear gradient in a render block.
 * @param {IonContextState} the context state of the render block
 * @param {NSArray*} color weights to be used in the creation of the gradient
 * @param {CGFloat} the angle of the gradient
 * @returns {void}
 */
+ (void) linearGradientWithContextState:(IonContextState)state
                   gradientColorWeights:(NSArray*)colorWeights
                                  angle:(CGFloat)angle {
    CGPoint startPoint, endPoint;
    CGGradientRef gradColorRef;
    
    startPoint = [IonMath pointAtEdgeOfFrame: state.contextSize angleOfRay: angle];
    endPoint = [IonMath pointAtEdgeOfFrame: state.contextSize angleOfRay: angle + M_PI];
    
    gradColorRef = [IonRenderUtilities referenceGradientFromColorWeights: colorWeights];
    
    CGContextDrawLinearGradient( state.context, gradColorRef, startPoint, endPoint, kCGGradientDrawsAfterEndLocation + kCGGradientDrawsBeforeStartLocation);
    CFBridgingRelease( gradColorRef );
}

/**
 * This will render a linear gradient using the inputed config, and result size.
 * @param {IonLinearGradientConfiguration} this is the config we will use to generate the gradient.
 * @param {CGSize} this is the size we will render the gradient at.
 * @param {(void(^)(UIImage* image))} this is the block we will call with the resulting image once it is generated.
 * @returns {void}
 */
+ (void) renderLinearGradient:(IonLinearGradientConfiguration*)gradientConfig
                   resultSize:(CGSize)size
              withReturnBlock:(IonRenderReturnBlock) returnBlock {
    [IonRenderUtilities renderBlock: ^{
        IonContextState currentState;
        
        //Get the current context state
        currentState = currentContextStateWithSize( size );
        
        //Render the gradient
        [IonRenderUtilities linearGradientWithContextState: currentState
                                      gradientColorWeights: gradientConfig.colorWeights
                                                     angle: gradientConfig.angle];
    }
                  inContextWithSize: size
                     andReturnBlock: returnBlock];
}


#pragma mark Image Sizing Utilities

/**
 * This will render an image at the inputted size.
 * @param {UIImage*} the image to render
 * @param {CGSize} the size to render the image at
 * @param {void(^)( UIImage* image )} this is the block we will call with the resulting image once it is generated.
 * @returns {void}
 */
+ (void) renderImage:(UIImage*) image
      withSize:(CGSize) size
      andReturnBlock:(IonRenderReturnBlock) returnBlock {
    [IonRenderUtilities renderBlock: ^{
        if ( CGSizeEqualToSize( size, CGSizeZero) )
            return;
        
        // Draw the Image
        [image drawInRect: [IonMath rectWhichFillsSize: size maintainingAspectRatio: image.size] ];
        
    }
                  inContextWithSize: size
                     andReturnBlock: returnBlock];
}

/**
 * This will render an image within the inputted size while maintaining the aspect ratio.
 * @param {UIImage*} the image to render
 * @param {CGSize} the size to render the image within
 * @param {void(^)( UIImage* image )} this is the block we will call with the resulting image once it is generated.
 * @returns {void}
 */
+ (void) renderImage:(UIImage*) image
          withinSize:(CGSize) size
      andReturnBlock:(IonRenderReturnBlock) returnBlock {
    [IonRenderUtilities renderBlock: ^{
        if ( CGSizeEqualToSize( size, CGSizeZero) )
            return;
        
        // Draw the Image
        [image drawInRect: [IonMath rectWhichContainsSize: size maintainingAspectRatio: image.size]];
    }
                  inContextWithSize: size
                     andReturnBlock: returnBlock];

}

#pragma mark Verification

/**
 * Verifies that the inputted context state is valid.
 * @param {IonContextState} the context state to verify.
 * @returns {BOOL} true if valid, false if invalid.
 */
+ (BOOL) isValidContextState:(IonContextState) state {
    if ( CGSizeEqualToSize( state.contextSize, CGSizeZero) )
        return FALSE;
    return TRUE;
}

#pragma mark Singletons

/**
 * This is the render dispatch queue singleton.invalid
 * @returns {dispatch_queue_t}
 */
+ (dispatch_queue_t) renderDispatchQueue {
    static dispatch_queue_t renderDispatchQueue = nil;
    static dispatch_once_t renderDispatchQueue_OnceToken;
    
    dispatch_once(&renderDispatchQueue_OnceToken, ^{
            renderDispatchQueue = dispatch_queue_create( IonRenderQueueLabel, NULL );
    });
    
    return renderDispatchQueue;
}


@end

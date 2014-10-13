//
//  IonRenderUtilities.h
//  Ion
//
//  Created by Andrew Hurst on 7/13/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IonGradientConfiguration.h"

/**
 * Utility struct to bundle up Context state information
 */
struct IonContextState {
    CGContextRef context; // the context it self
    CGSize contextSize; // the context size
};
typedef struct IonContextState IonContextState;

/**
 * This is a Utility function to get the context state quickly.
 */
inline static IonContextState currentContextStateWithSize (CGSize contextSize) {
    IonContextState currentState;
    
    currentState.context = UIGraphicsGetCurrentContext();
    currentState.contextSize = contextSize;
    
    return currentState;
}

/**
 * The return block for images
 */

typedef void(^IonRenderReturnBlock)( UIImage* image );


@interface IonRenderUtilities : NSObject

#pragma mark Render Utilities

/**
 * This renders the inputed render block in the render thread, and returns the result in the result block.
 * Note: this uses CGContext based rendering.
 * @param {void^()} the work to be rendered
 * @param {CGSize} the size of the context
 * @param {CGFloat} this is the scale of the context
 * @param {bool} states if the context and the resulting image have an alpha channel
 * @param {void^(UIImage*)} the block to be called once the work is done
 
 */
+ (void) renderBlock: (void(^)( )) block
   inContextWithSize: (CGSize) contextSize
               scale: (CGFloat) scale
        thatHasAlpha: (bool) isAlpha
      andReturnBlock: (IonRenderReturnBlock) returnBlock;

/**
 * This renders the inputed render block in the render thread, and returns the result in the result block.
 * Note: this uses CGContext based rendering.
 * @param {void^()} the work to be rendered
 * @param {CGSize} the size of the context
 * @param {bool} states if the context and the resulting image have an alpha channel
 * @param {IonRenderReturnBlock} the block to be called once the work is done
 
 */
+ (void) renderBlock: (void(^)( )) block
   inContextWithSize: (CGSize) contextSize
        thatHasAlpha: (bool) isAlpha
      andReturnBlock: (IonRenderReturnBlock) returnBlock;

/**
 * This renders the inputed render block in the render thread, and returns the result in the result block.
 * Note: this uses CGContext based rendering.
 * @param {void^()} the work to be rendered
 * @param {CGSize} the size of the context
 * @param {IonRenderReturnBlock} the block to be called once the work is done
 
 */
+ (void) renderBlock: (void(^)( )) block
   inContextWithSize: (CGSize) contextSize
      andReturnBlock: (IonRenderReturnBlock) returnBlock;


#pragma mark Gradient Utilities

/**
 * This takes an inputed set of color weights, and converts them into a CGGradientRef.
 * @peram {NSArray} the array of color weights to be converted.
 * @returns {CGGradientRef}
 */
+ (CGGradientRef) referenceGradientFromColorWeights:(NSArray*) colorWeights;

/**
 * This will render a linear gradient using the inputed config, and result size.
 * @param {IonLinearGradientConfiguration} this is the config we will use to generate the gradient.
 * @param {CGSize} this is the size we will render the gradient at.
 * @param {IonRenderReturnBlock)} this is the block we will call with the resulting image once it is generated.
 
 */
+ (void) renderLinearGradient:(IonLinearGradientConfiguration*) gradientConfig
                   resultSize:(CGSize) size
              withReturnBlock:(IonRenderReturnBlock) returnBlock;

/**
 * This will create a linear gradient in a render block.
 * @param {IonContextState} the context state of the render block
 * @param {NSArray*} color weights to be used in the creation of the gradient
 * @param {CGFloat} the angle of the gradient
 
 */
+ (void) linearGradientWithContextState:(IonContextState) state
                   gradientColorWeights:(NSArray*) colorWeights
                                  angle:(CGFloat) angle;


#pragma mark Image Sizing Utilities

/**
 * This will render an image at the inputted size.
 * @param {UIImage*} the image to render
 * @param {CGSize} the size to render the image at
 * @param {void(^)( UIImage* image )} this is the block we will call with the resulting image once it is generated.
 
 */
+ (void) renderImage:(UIImage*)image
            withSize:(CGSize)size
      andReturnBlock:(IonRenderReturnBlock) returnBlock;

/**
 * This will render an image within the inputted size while maintaining the aspect ratio.
 * @param {UIImage*} the image to render
 * @param {CGSize} the size to render the image within
 * @param {void(^)( UIImage* image )} this is the block we will call with the resulting image once it is generated.
 
 */
+ (void) renderImage:(UIImage*) image
          withinSize:(CGSize) size
      andReturnBlock:(IonRenderReturnBlock) returnBlock;

#pragma mark Verification

/**
 * Verifies that the inputted context state is valid.
 * @param {IonContextState} the context state to verify.
 * @returns {BOOL} true if valid, false if invalid.
 */
+ (BOOL) isValidContextState:(IonContextState) state;


#pragma mark Singletons

/**
 * This is the render dispatch queue singleton.
 * @returns {dispatch_queue_t}
 */
+ (dispatch_queue_t) renderDispatchQueue;



#pragma mark Testing In Main

+ (void) renderTestingInMainBlock: (void(^)()) block
                inContextWithSize: (CGSize) contextSize
                            scale: (CGFloat) scale
                     thatHasAlpha: (bool) isAlpha
                   andReturnBlock: (IonRenderReturnBlock) returnBlock;

@end

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





@interface IonRenderUtilities : NSObject

#pragma mark Render Utilities

/**
 * This renders the inputed render block in the render thread, and returns the result in the result block.
 * Note: this uses CGContext based rendering.
 * @param {void^()} the work to be rendered
 * @param {CGSize} the size of the context
 * @param {CGFloat} this is the scale of the context
 * @param {bool} states if the context and the resulting imgae have an alpha channel
 * @param {void^(UIImage*)} the block to be called once the work is done
 * @returns {void}
 */
+ (void) renderBlock: (void(^)( )) block
   inContextWithSize: (CGSize) contextSize
               scale: (CGFloat) scale
        thatHasAlpha: (bool) isAlpha
      andReturnBlock: (void(^)( UIImage* image )) returnBlock;

/**
 * This renders the inputed render block in the render thread, and returns the result in the result block.
 * Note: this uses CGContext based rendering.
 * @param {void^()} the work to be rendered
 * @param {CGSize} the size of the context
 * @param {bool} states if the context and the resulting imgae have an alpha channel
 * @param {void^(UIImage*)} the block to be called once the work is done
 * @returns {void}
 */
+ (void) renderBlock: (void(^)( )) block
   inContextWithSize: (CGSize) contextSize
        thatHasAlpha: (bool) isAlpha
      andReturnBlock: (void(^)( UIImage* image )) returnBlock;

/**
 * This renders the inputed render block in the render thread, and returns the result in the result block.
 * Note: this uses CGContext based rendering.
 * @param {void^()} the work to be rendered
 * @param {CGSize} the size of the context
 * @param {void^(UIImage*)} the block to be called once the work is done
 * @returns {void}
 */
+ (void) renderBlock: (void(^)( )) block
   inContextWithSize: (CGSize) contextSize
      andReturnBlock: (void(^)( UIImage* image )) returnBlock;


#pragma mark Gradient Utilities

/**
 * This takes an inputed set of color weights, and converts them into a CGGradientRef.
 * @peram {NSArray} the array of color weights to be converted.
 * @returns {CGGradientRef}
 */
+ (CGGradientRef) refrenceGradientFromColorWeights:(NSArray*) colorWeights;

/**
 * This will render a linear gradient using the inputed config, and result size.
 * @param {IonLinearGradientConfiguration} this is the config we will use to generate the gradient.
 * @param {CGSize} this is the size we will render the gradient at.
 * @param {(void(^)(UIImage* image))} this is the block we will call with the resulting image once it is generated.
 * @returns {void}
 */
+ (void) renderLinearGradient:(IonLinearGradientConfiguration*) gradientConfig
                   resultSize:(CGSize) size
              withReturnBlock:(void(^)( UIImage* image )) returnBlock;

/**
 * This will create a linear gradient in a render block.
 * @param {IonContextState} the context state of the render block
 * @param {NSArray*} color weights to be used in the creation of the gradient
 * @param {CGFloat} the angle of the gradient
 * @returns {void}
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
 * @returns {void}
 */
+ (void) renderImage:(UIImage*)image
            withSize:(CGSize)size
      andReturnBlock:(void(^)( UIImage* image )) returnBlock;


#pragma mark Singletons

/**
 * This is the render dispatch queue singleton.
 * @returns {dispatch_queue_t}
 */
+ (dispatch_queue_t) renderDispatchQueue;



#pragma Mark Testing In Main

+ (void) renderTestingInMainBlock: (void(^)()) block
                inContextWithSize: (CGSize) contextSize
                            scale: (CGFloat) scale
                     thatHasAlpha: (bool) isAlpha
                   andReturnBlock: (void(^)( UIImage* image )) returnBlock;

@end
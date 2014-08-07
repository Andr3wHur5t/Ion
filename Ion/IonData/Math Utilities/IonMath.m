//
//  IonMath.m
//  Ion
//
//  Created by Andrew Hurst on 7/13/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonMath.h"

@implementation IonMath

#pragma mark Positioning Utilities
/**
 * This gets the point at the edge of the frame where the ray "emitting from the center of the view" will hit with the specified angle
 * @returns {CGPoint} the resulting point
 */
+ (CGPoint) pointAtEdgeOfFrame:(CGSize) frameSize angleOfRay:(CGFloat) angle {
    CGPoint result, center;
    CGFloat normalizedAngle;
    
    // Normalize input
    normalizedAngle = DegreesToRadians( angle );
    
    // Get the center
    center.x = frameSize.width/2;
    center.y = frameSize.height/2;
    // ray test
    result.x = ( cosf(normalizedAngle) * center.x ) + center.x;
    result.y = ( sinf(normalizedAngle) * center.y ) + center.y;
    
    return result;
}

/**
 * Computes the resulting position of the rect centered using the inputted size of the centered rect,
 *     and the size the rect to be centered in.
 * @param {CGSize} the size of the centered view
 * @param {CGSize} the size of the view to be centered in.
 * @returns {CGPoint} the origin of the centered rect, to be centered the in a view with the inputted size.
 */
+ (CGPoint) originForRectWithSize:(CGSize) centeredSize containedInRectWithSize:(CGSize) containingSize {
    CGPoint result;
    
    result.x = ( containingSize.width - centeredSize.width ) / 2;
    result.y = ( containingSize.height - centeredSize.height ) / 2;
    
    return result;
}

#pragma mark Sizing Utilities

/**
 * Computes the maximum size we can get inside of the containing size, while maintaining aspect ratio.
 * @param {CGSize} the contained size which holds the aspect ratio.
 * @param {CGSize} the limits of contained size.
 * @retuns {CGSize} the resulting size of the ratio within the limits
 */
+ (CGSize) sizeMaintaingSizeRatio:(CGSize) ratioSize withMaximumSize:(CGSize) maxSize {
    return [IonMath sizeMaintaingSizeRatio: ratioSize usingSize: maxSize thatContains: TRUE];
}

/**
 * Computes the size of a rect needed to fully occupy a size while maintaining aspect ratio
 * @param {CGSize} the contained size which holds the aspect ratio.
 * @param {CGSize} the minimum size of the view
 * @retuns {CGSize} the resulting size of the ratio within filling the size
 */
+ (CGSize) sizeMaintaingSizeRatio:(CGSize) ratioSize withMinimumSize:(CGSize) minSize {
    return [IonMath sizeMaintaingSizeRatio: ratioSize usingSize: minSize thatContains: FALSE];
}

/**
 * Computes the size of a rect needed to fully occupy, or to contain a size while maintaining aspect ratio.
 * @param {CGSize} the contained size which holds the aspect ratio.
 * @param {CGSize} the minimum size of the view
 * @param {BOOL} if we are to be contained in the view.
 * @retuns {CGSize} the resulting size of the ratio within filling the size
 */
+ (CGSize) sizeMaintaingSizeRatio:(CGSize) ratioSize usingSize:(CGSize) size thatContains:(BOOL) contains {
    CGSize result;
    CGFloat aspectRatio, containingSizeRatio;
    BOOL widthLTheight;
    
    // Calculate
    containingSizeRatio = size.height / size.width;
    aspectRatio = ratioSize.height / ratioSize.width;
    widthLTheight = aspectRatio >= containingSizeRatio ? containingSizeRatio >= 1.0 : aspectRatio <= 1.0;
    
    // Change type accordingly
    if ( !contains )
        widthLTheight = !widthLTheight;
    
    // Calculate
    result.width =  widthLTheight ?  size.height / aspectRatio   : size.width ;
    result.height = widthLTheight ?  size.height                 : size.width * aspectRatio ;
    
    return result;
}

#pragma mark Rect Utilities

/**
 * Creates a rect that will maintain the set aspect ratio, and fill the provided size completely.
 * @param {CGSize} the contained size which holds the aspect ratio.
 * @param {CGSize} the minimum size of the view
 * @retruns {CGRect} the resulting rect
 */
+ (CGRect) rectWhichFillsSize:(CGSize) fillSize maintainingAspectRatio:(CGSize) aspectRatio {
    CGRect result;
    
    result.size = [IonMath sizeMaintaingSizeRatio: aspectRatio withMinimumSize: fillSize];
    result.origin = [IonMath originForRectWithSize: result.size containedInRectWithSize: fillSize];
    
    return result;
}

/**
 * Creates a rect that will maintain the set aspect ratio, and be contained in provided size.
 * @param {CGSize} the contained size which holds the aspect ratio.
 * @param {CGSize} the maximum size of the rect
 * @retruns {CGRect} the resulting rect
 */
+ (CGRect) rectWhichContainsSize:(CGSize) fillSize maintainingAspectRatio:(CGSize) aspectRatio {
    CGRect result;
    
    result.size = [IonMath sizeMaintaingSizeRatio: aspectRatio withMaximumSize: fillSize];
    result.origin = [IonMath originForRectWithSize: result.size containedInRectWithSize: fillSize];
    
    return result;
}

#pragma Rounded Utilities


/**
 * Rounds a point to the specified accuracy.
 * @param {CGPoint} the poin to round.
 * @param {NSNumber} accuracy.
 * @retuns {CGPoint} the rounded point
 */
+ (CGPoint) roundPoint:(CGPoint) a usingAccuracy:(NSInteger) accuracy {
    CGPoint result;
    
    result.x = [IonMath roundNumber: a.x usingAccuracy: accuracy];
    result.y = [IonMath roundNumber: a.y usingAccuracy: accuracy];
    
    return result;
}

#pragma mark Point Comparison Utilities

/**
 * Compares point a with point be with the specified accuracy.
 * @param {CGPoint} point a
 * @param {CGPoint} point b
 * @param {NSNumber} accuracy
 * @returns {BOOL} if they are equal
 */
+ (BOOL) comparePoint:(CGPoint) a withPoint:(CGPoint) b {
    return [IonMath compareFloat: a.x andFloat: b.x] &&
    [IonMath compareFloat: a.y andFloat: b.y];
}

/**
 * Compares point a with point be with the specified accuracy.
 * @param {CGPoint} point a
 * @param {CGPoint} point b
 * @param {NSNumber} accuracy
 * @returns {BOOL} if they are equal
 */
+ (BOOL) comparePoint:(CGPoint) a withPoint:(CGPoint) b usingAccuracy:(NSInteger) accuracy {
    return [IonMath compareFloat: a.x andFloat: b.x usingAccuracy: accuracy] &&
    [IonMath compareFloat: a.y andFloat: b.y usingAccuracy: accuracy];
}

#pragma mark Floating Point Utilities

/**
 * Rounds a value with an accuracy.
 * @param {CGFloat} the number.
 * @param {NSNumber} accuracy.
 * @returns {CGFloat} the rounded number
 */
+ (CGFloat) roundNumber:(CGFloat) a usingAccuracy:(NSInteger) accuracy {
    NSInteger accuracyVal;
    accuracyVal = pow( 10, accuracy );
    return floorf( a * accuracyVal + 0.5) / accuracyVal;
}

/**
 * Compares two float values
 * @param {CGFloat} a
 * @param {CGFloat} b
 * @retult {BOOL}
 */
+ (BOOL) compareFloat:(CGFloat) a andFloat:(CGFloat) b {
    return [IonMath compareFloat: a andFloat: b usingAccuracy: 2];
}

/**
 * Compares two float values
 * @param {CGFloat} a
 * @param {CGFloat} b
 * @param {NSNumber} accuracy.
 * @retult {BOOL}
 */
+ (BOOL) compareFloat:(CGFloat) a andFloat:(CGFloat) b usingAccuracy:(NSInteger) accuracy {
    return fabs( a - b ) < accuracy * FLT_EPSILON * fabs( a + b );
}



@end

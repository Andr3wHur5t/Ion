//
//  IonMath.h
//  Ion
//
//  Created by Andrew Hurst on 7/13/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>

/** Radian & Degree Utilitys */
#define DegToRad (M_PI/180)
#define RadToDeg (180/M_PI)

#define DegreesToRadians(__Deg__) ( __Deg__ * DegToRad )
#define RadiansToDegrees(__Rad__) ( __Rad__ * RadToDeg )


/** Clamping */
 #define CLAMP(x, low, high) ({\
 __typeof__(x) __x = (x); \
 __typeof__(low) __low = (low);\
 __typeof__(high) __high = (high);\
 __x > __high ? __high : (__x < __low ? __low : __x);\
 })


/**
 * Constants
 */
static const CGPoint CGPointUndefined = (CGPoint){ INFINITY, INFINITY };
static const CGSize CGSizeUndefined = (CGSize){ INFINITY, INFINITY };
static const CGRect CGRectUndefined = (CGRect){ INFINITY, INFINITY, INFINITY, INFINITY };


@interface IonMath : NSObject

/**
 * This gets the point at the edge of the frame where the ray "emiting from the center of the view" will hit with the specified angle
 * @returns
 */
+ (CGPoint) pointAtEdgeOfFrame:(CGSize) frameSize angleOfRay:(CGFloat) angle;


/**
 * Computes the resulting position of the rect centered using the inputted size of the centered rect,
 *     and the size the rect to be centered in.
 * @param {CGSize} the size of the centered view
 * @param {CGSize} the size of the view to be centered in.
 * @returns {CGPoint} the origin of the centered rect, to be centered the in a view with the inputted size.
 */
+ (CGPoint) originForRectWithSize:(CGSize) centeredSize containedInRectWithSize:(CGSize) containingSize;

#pragma mark Sizing Utilities

/**
 * Computes the maximum size we can get inside of the containing size, while maintaining aspect ratio.
 * @param {CGSize} the contained size which holds the aspect ratio.
 * @param {CGSize} the limits of contained size.
 * @retuns {CGSize} the resulting size of the ratio within the limits
 */
+ (CGSize) sizeMaintaingSizeRatio:(CGSize) ratioSize withMaximumSize:(CGSize) maxSize;

/**
 * Computes the size of a rect needed to fully occupy a size while maintaining aspect ratio
 * @param {CGSize} the contained size which holds the aspect ratio.
 * @param {CGSize} the minimum size of the view
 * @retuns {CGSize} the resulting size of the ratio within filling the size
 */
+ (CGSize) sizeMaintaingSizeRatio:(CGSize) ratioSize withMinimumSize:(CGSize) minSize;

/**
 * Computes the size of a rect needed to fully occupy, or to contain a size while maintaining aspect ratio.
 * @param {CGSize} the contained size which holds the aspect ratio.
 * @param {CGSize} the minimum size of the view
 * @param {BOOL} if we are to be contained in the view.
 * @retuns {CGSize} the resulting size of the ratio within filling the size
 */
+ (CGSize) sizeMaintaingSizeRatio:(CGSize) ratioSize usingSize:(CGSize) size thatContains:(BOOL) contains;



#pragma mark Rect Utilities

/**
 * Creates a rect that will maintain the set aspect ratio, and fill the provided size completely.
 * @param {CGSize} the contained size which holds the aspect ratio.
 * @param {CGSize} the minimum size of the view
 * @retruns {CGRect} the resulting rect
 */
+ (CGRect) rectWhichFillsSize:(CGSize) fillSize maintainingAspectRatio:(CGSize) aspectRatio;

/**
 * Creates a rect that will maintain the set aspect ratio, and be contained in provided size.
 * @param {CGSize} the contained size which holds the aspect ratio.
 * @param {CGSize} the maximum size of the rect
 * @retruns {CGRect} the resulting rect
 */
+ (CGRect) rectWhichContainsSize:(CGSize) fillSize maintainingAspectRatio:(CGSize) aspectRatio;

@end

//
//  SMUtilities.h
//  SimpleMath
//
//  Created by Andrew Hurst on 10/10/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMUtilities : NSObject
#pragma mark Positioning Utilities
/**
 * This gets the point at the edge of the frame where the ray "emitting from the center of the view" will hit with the specified angle
 * @param frameSize - the size of the frame.
 * @param angle - the angle for us to use in degrees
 * @returns the point that was hit.
 */
+ (CGPoint) pointAtEdgeOfFrame:(CGSize) frameSize angleOfRay:(CGFloat) angle;


/**
 * Computes the resulting position of the rect centered using the inputted size of the centered rect,
 *     and the size the rect to be centered in.
 * @param centeredSize - the size of the centered view
 * @param containingSize - the size of the view to be centered in.
 * @returns the origin of the centered rect, to be centered the in a view with the inputted size.
 */
+ (CGPoint) originForRectWithSize:(CGSize) centeredSize containedInRectWithSize:(CGSize) containingSize;

#pragma mark Sizing Utilities

/**
 * Computes the maximum size we can get inside of the containing size, while maintaining aspect ratio.
 * @param ratioSize - the contained size which holds the aspect ratio.
 * @param maxSize - the limits of contained size.
 * @returns the resulting size of the ratio within the limits
 */
+ (CGSize) sizeMaintaingSizeRatio:(CGSize) ratioSize withMaximumSize:(CGSize) maxSize;

/**
 * Computes the size of a rect needed to fully occupy a size while maintaining aspect ratio
 * @param ratioSize - the contained size which holds the aspect ratio.
 * @param minSize - the minimum size of the view
 * @returns the resulting size of the ratio within filling the size
 */
+ (CGSize) sizeMaintaingSizeRatio:(CGSize) ratioSize withMinimumSize:(CGSize) minSize;

/**
 * Computes the size of a rect needed to fully occupy, or to contain a size while maintaining aspect ratio.
 * @param ratioSize - the contained size which holds the aspect ratio.
 * @param size - the minimum size of the view
 * @param contains - if we are to be contained in the view.
 */
+ (CGSize) sizeMaintaingSizeRatio:(CGSize) ratioSize usingSize:(CGSize) size thatContains:(BOOL) contains;



#pragma mark Rect Utilities
/**
 * Creates a rect that will maintain the set aspect ratio, and fill the provided size completely.
 * @param fillSize - the contained size which holds the aspect ratio.
 * @param aspectRatio - the minimum size of the view
 */
+ (CGRect) rectWhichFillsSize:(CGSize) fillSize maintainingAspectRatio:(CGSize) aspectRatio;

/**
 * Creates a rect that will maintain the set aspect ratio, and be contained in provided size.
 * @param fillSize - the contained size which holds the aspect ratio.
 * @param aspectRatio - the maximum size of the rect
 */
+ (CGRect) rectWhichContainsSize:(CGSize) fillSize maintainingAspectRatio:(CGSize) aspectRatio;

#pragma mark Rounding Utilities

/**
 * Rounds a point to the specified accuracy.
 * @param a - the point to round.
 * @param accuracy - accuracy.
 */
+ (CGPoint) roundPoint:(CGPoint) a usingAccuracy:(NSInteger) accuracy;


#pragma mark Point Comparison Utilities

/**
 * Compares point a with point be with the specified accuracy.
 * @param a - point a
 * @param b - point b
 */
+ (BOOL) comparePoint:(CGPoint) a withPoint:(CGPoint) b;

/**
 * Compares point a with point be with the specified accuracy.
 * @param a - point a
 * @param b - point b
 * @param accuracy - accuracy
 */
+ (BOOL) comparePoint:(CGPoint) a withPoint:(CGPoint) b usingAccuracy:(NSInteger) accuracy;

#pragma mark Size Comparison Utilities

/**
 * Compares size a with size be with the specified accuracy.
 * @param a - size a
 * @param b - size b
 */
+ (BOOL) compareSize:(CGSize) a withSize:(CGSize) b;

/**
 * Compares size a with size be with the specified accuracy.
 * @param a -size a
 * @param b - size b
 * @param accuracy - accuracy
 */
+ (BOOL) compareSize:(CGSize) a withSize:(CGSize) b usingAccuracy:(NSInteger) accuracy;

/**
 * Normalizes to the scale of the screen.
 * @param size - the size to be normalized.
 */
+ (CGSize) normilizeSizeToScreen:(CGSize) size;

#pragma mark Floating Point Utilities

/**
 * Rounds a value with an accuracy.
 * @param a - the number.
 * @param accuracy - accuracy.
 */
+ (CGFloat) roundNumber:(CGFloat) a usingAccuracy:(NSInteger) accuracy;

/**
 * Compares two float values
 * @param a - first value to compare
 * @param b - second value to compare
 */
+ (BOOL) compareFloat:(CGFloat) a andFloat:(CGFloat) b;

+ (CGFloat)floorf:(CGFloat)val;

#pragma mark Normalization Utilities

/**
 * Normalizes a radian, for use in a rotational mathematics.
 * @param value the radian value to normalize.
 * @returns the normalized value between 0 and 2pi
 */
+ (CGFloat) normalizeRadialFloat:(CGFloat) value;

#pragma mark Transform Utilities

/**
 * Adds Perspective to the transform.
 * @param transform - the transform to add perspective to.
 * @returns the inputted transform with perspective.
 */
+ (CATransform3D) setTransformPerspective:(CATransform3D) transform;

@end

/** Radian & Degree Utilities */
#define DegToRad (M_PI/180)
#define RadToDeg (180/M_PI)

#define DegreesToRadians(__Deg__) ( __Deg__ * (typeof( __Deg__ ))DegToRad )
#define RadiansToDegrees(__Rad__) ( __Rad__ * (typeof( __Rad__ ))RadToDeg )


/** Clamping */
#define CLAMP(x, low, high) ({\
__typeof__(x) __x = (x); \
__typeof__(low) __low = (low);\
__typeof__(high) __high = (high);\
__x > __high ? __high : (__x < __low ? __low : __x);\
})

/** Timing */
#define SecToMil 1000
#define SecondsToMilliseconds(__Time__) ( __Time__ * (typeof( __Time__ ))SecToMil )
#define MillisecondsToSeconds(__Time__) ( __Time__ / (typeof( __Time__ ))SecToMil )

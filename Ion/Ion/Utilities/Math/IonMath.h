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

@interface IonMath : NSObject

/**
 * This gets the point at the edge of the frame where the ray "emiting from the center of the view" will hit with the specified angle
 * @returns
 */
+ (CGPoint) pointAtEdgeOfFrame:(CGSize) frameSize angleOfRay:(CGFloat) angle;

@end

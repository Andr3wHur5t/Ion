//
//  SMUtilities.m
//  SimpleMath
//
//  Created by Andrew Hurst on 10/10/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "SMUtilities.h"

@implementation SMUtilities

#pragma mark Positioning Utilities

+ (CGPoint) pointAtEdgeOfFrame:(CGSize) frameSize angleOfRay:(CGFloat) angle {
    CGPoint result, center;
    CGFloat normalizedAngle;
    
    // Normalize input
    normalizedAngle = DegreesToRadians( angle );
    
    // Get the center
    center.x = frameSize.width/2;
    center.y = frameSize.height/2;
    // ray test
    result.x = ( (CGFloat)cos(normalizedAngle) * center.x ) + center.x;
    result.y = ( (CGFloat)sin(normalizedAngle) * center.y ) + center.y;
    
    return result;
}

+ (CGPoint) originForRectWithSize:(CGSize) centeredSize containedInRectWithSize:(CGSize) containingSize {
    CGPoint result;
    
    result.x = ( containingSize.width - centeredSize.width ) / 2;
    result.y = ( containingSize.height - centeredSize.height ) / 2;
    
    return result;
}

#pragma mark Sizing Utilities

+ (CGSize) sizeMaintaingSizeRatio:(CGSize) ratioSize withMaximumSize:(CGSize) maxSize {
    return [SMUtilities sizeMaintaingSizeRatio: ratioSize usingSize: maxSize thatContains: TRUE];
}

+ (CGSize) sizeMaintaingSizeRatio:(CGSize) ratioSize withMinimumSize:(CGSize) minSize {
    return [SMUtilities sizeMaintaingSizeRatio: ratioSize usingSize: minSize thatContains: FALSE];
}

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

+ (CGRect) rectWhichFillsSize:(CGSize) fillSize maintainingAspectRatio:(CGSize) aspectRatio {
    CGRect result;
    
    result.size = [SMUtilities sizeMaintaingSizeRatio: aspectRatio withMinimumSize: fillSize];
    result.origin = [SMUtilities originForRectWithSize: result.size containedInRectWithSize: fillSize];
    
    return result;
}

+ (CGRect) rectWhichContainsSize:(CGSize) fillSize maintainingAspectRatio:(CGSize) aspectRatio {
    CGRect result;
    
    result.size = [SMUtilities sizeMaintaingSizeRatio: aspectRatio withMaximumSize: fillSize];
    result.origin = [SMUtilities originForRectWithSize: result.size containedInRectWithSize: fillSize];
    
    return result;
}

#pragma mark Rounded Utilities

+ (CGPoint) roundPoint:(CGPoint) a usingAccuracy:(NSInteger) accuracy {
    CGPoint result;
    
    result.x = [SMUtilities roundNumber: a.x usingAccuracy: accuracy];
    result.y = [SMUtilities roundNumber: a.y usingAccuracy: accuracy];
    
    return result;
}

#pragma mark Point Comparison Utilities

+ (BOOL) comparePoint:(CGPoint) a withPoint:(CGPoint) b {
    return [SMUtilities compareFloat: a.x andFloat: b.x] && [SMUtilities compareFloat: a.y andFloat: b.y];
}

+ (BOOL) comparePoint:(CGPoint) a withPoint:(CGPoint) b usingAccuracy:(NSInteger) accuracy {
    return [SMUtilities compareFloat: a.x andFloat: b.x usingAccuracy: accuracy] &&
            [SMUtilities compareFloat: a.y andFloat: b.y usingAccuracy: accuracy];
}

#pragma mark Size Comparison Utilities

+ (BOOL) compareSize:(CGSize) a withSize:(CGSize) b {
    return [SMUtilities compareFloat: a.width andFloat: b.width] && [SMUtilities compareFloat: a.height andFloat: b.height];
    
}

+ (BOOL) compareSize:(CGSize) a withSize:(CGSize) b usingAccuracy:(NSInteger) accuracy {
    return [SMUtilities compareFloat: a.width andFloat: b.width usingAccuracy: accuracy] &&
            [SMUtilities compareFloat: a.height andFloat: b.height usingAccuracy: accuracy];
}

+ (CGSize) normilizeSizeToScreen:(CGSize) size {
    return (CGSize){ size.width * [[UIScreen mainScreen] scale], size.height * [[UIScreen mainScreen] scale]};
}

#pragma mark Floating Point Utilities

+ (CGFloat) roundNumber:(CGFloat) a usingAccuracy:(NSInteger) accuracy {
    CGFloat accuracyVal;
    accuracyVal = (CGFloat) pow( 10, accuracy );
    return (CGFloat)floor( a * accuracyVal + 0.5) / accuracyVal;
}

+ (BOOL) compareFloat:(CGFloat) a andFloat:(CGFloat) b {
    return [SMUtilities compareFloat: a andFloat: b usingAccuracy: 2];
}

+ (BOOL) compareFloat:(CGFloat) a andFloat:(CGFloat) b usingAccuracy:(NSInteger) accuracy {
    return fabs( a - b ) < accuracy * FLT_EPSILON * fabs( a + b );
}

#pragma mark Normilization Utilties

+ (CGFloat) normalizeRadialFloat:(CGFloat) value {
    return value;
}

#pragma mark Tranform Utilties

+ (CATransform3D) setTransformPerspective:(CATransform3D) transform {
    transform.m34 = (CGFloat)(1.0 / -500);
    return transform;
}

@end

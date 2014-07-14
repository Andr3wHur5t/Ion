//
//  IonMath.m
//  Ion
//
//  Created by Andrew Hurst on 7/13/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonMath.h"

@implementation IonMath

/**
 * This gets the point at the edge of the frame where the ray "emiting from the center of the view" will hit with the specified angle
 * @returns
 */
+ (CGPoint) pointAtEdgeOfFrame:(CGSize) frameSize angleOfRay:(CGFloat)angle {
    CGPoint result, center;
    
    // Get the center
    center.x = frameSize.width/2;
    center.y = frameSize.height/2;
    // ray test
    result.x = ( cosf(angle) * center.x ) + center.x;
    result.y = ( sinf(angle) * center.y ) + center.y;
    
    return result;
}


@end

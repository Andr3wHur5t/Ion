//
//  UIView+IonPositionAndOrientation.h
//  Ion
//
//  Created by Andrew Hurst on 8/11/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SimpleMath/SimpleMath.h>

@interface UIView (IonPositionAndOrientation)


#pragma mark Vector Implmentation

/**
 * Sets the views orientation to match the rotational representation of the vector.
 * @param vector - the rotational vector to align out orientation to.
 */
- (void) setOrientationToMatchVector:(SMVec3 *)vector;



#pragma mark Transforms

/**
 * Applys a CATransform3D to the view.
 * @param transform - the transform to apply.
 */
- (void) applyTransform:(CATransform3D) transform;
@end

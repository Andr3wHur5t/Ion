//
//  UIView+IonPositionAndOrientation.m
//  Ion
//
//  Created by Andrew Hurst on 8/11/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "UIView+IonPositionAndOrientation.h"
#import <IonData/IonData.h>

@implementation UIView (IonPositionAndOrientation)


#pragma mark Vector Implmentation

/**
 * Sets the views orientation to match the rotational representation of the vector.
 * @params {IonVec3*} the rotational vector to align out orientation to.
 * @returns {void}
 */
- (void) setOrientationToMatchVector:(IonVec3*) vector {
    if ( !vector || ![vector isKindOfClass: [IonVec3 class]] )
        return;
    
    [self applyTransform: [vector toRotationTransform]];
}

#pragma mark Transforms

/**
 * Applys a CATransform3D to the view.
 * @param {CATransform3D} the transform to apply.
 * @returns {void}
 */
- (void) applyTransform:(CATransform3D) transform {
    self.layer.transform = transform;
}


@end

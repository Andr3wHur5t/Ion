//
//  IonScrollThresholdAction.m
//  Ion
//
//  Created by Andrew Hurst on 10/2/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonScrollThresholdAction.h"
#import "IonScrollView.h"
#import <IonData/IonData.h>


@interface IonScrollThresholdAction ()

#pragma mark Utilities
/**
 * Checks if the inputted value passes the threshold.
 * @param value - the value to check agents the threshold.
 */
- (BOOL) passesThreshold:(CGFloat) value;

/**
 * Gets the correct value from the point as described in our axis property.
 * @param point - the point to get the axis from.
 * @return the axis or INFINITY if no valid axis is provided.
 */
- (CGFloat) axisFromPoint:(CGPoint) point;

@end

@implementation IonScrollThresholdAction
#pragma mark Construction

- (instancetype) init {
    self = [super init];
    if ( self ) {
        self.trackingRequired = FALSE;
        self.draggingRequired = FALSE;
        self.decelerationRequired = FALSE;
        self.zoomingRequired = FALSE;
        self.position = 0.0f;
        self.type = IonScrollActionType_GreaterThan;
        self.axis = IonScrollActionAxis_Vertical;
    }
    return self;
}

- (instancetype) initWithPosition:(CGFloat) position
                           onAxis:(IonScrollActionAxis) axis
                       usingCheck:(IonScrollActionType) type {
    self = [super init];
    if ( self ) {
        self.position = position;
        self.axis = axis;
        self.type = type;
    }
    return self;
}

+ (instancetype) thresholdWithPosition:(CGFloat) position
                                onAxis:(IonScrollActionAxis) axis
                            usingCheck:(IonScrollActionType) type {
    return [[[self class] alloc] initWithPosition: position
                                           onAxis: axis
                                       usingCheck: type];
}

#pragma mark Scroll View Interface

- (void) scrollViewDidUpdateContext:(IonScrollView *)scrollView {
    BOOL canInvoke;
    NSParameterAssert( scrollView && [scrollView isKindOfClass: [IonScrollView class]] );
    if ( !scrollView || ![scrollView isKindOfClass: [IonScrollView class]] )
        return;
    
    // Check if we pass the threshold
    canInvoke = [self passesThreshold: [self axisFromPoint: scrollView.contentOffset]];
    if ( !canInvoke )
        return; // Don't bother.
    
    // Zooming
    canInvoke = canInvoke && (self.zoomingRequired ? scrollView.zooming : TRUE);
    
    // Tracking
    canInvoke = canInvoke && (self.trackingRequired ? scrollView.tracking : TRUE);
    
    // Dragging
    canInvoke = canInvoke && (self.draggingRequired ? scrollView.dragging : TRUE);
    
    // Deceleration
    canInvoke = canInvoke && (self.decelerationRequired ? scrollView.decelerating : TRUE);
    
    if ( canInvoke )
        [self invokeTargetAction];
}

#pragma mark Utilities

- (BOOL) passesThreshold:(CGFloat) value {
    switch ( self.type ) {
        case IonScrollActionType_GreaterThan:
            return value > self.position;
            break;
        case IonScrollActionType_GreaterThanOrEqualTo:
            return value >= self.position;
            break;
        case IonScrollActionType_LessThan:
            return value < self.position;
            break;
        case IonScrollActionType_LessThanOrEqualTo:
            return value <= self.position;
            break;
        default:
            return FALSE;
            break;
    }
}

- (CGFloat) axisFromPoint:(CGPoint) point {
    switch ( self.axis ) {
        case IonScrollActionAxis_Horizontal:
            return point.x;
            break;
        case IonScrollActionAxis_Vertical:
            return point.y;
            break;
        default:
            return INFINITY;
            break;
    }
}

@end

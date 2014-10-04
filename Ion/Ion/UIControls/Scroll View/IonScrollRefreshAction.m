//
//  IonScrollRefreshAction.m
//  Ion
//
//  Created by Andrew Hurst on 10/2/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonScrollRefreshAction.h"
#import <IonData/IonData.h>

@interface IonScrollRefreshAction () {
    BOOL _canInternalyRefresh, _wasTracking;
    CGFloat lastDelegateUpdateValue;
}

@end

@implementation IonScrollRefreshAction

@synthesize statusDelegate = _statusDelegate;

#pragma mark Construction

- (instancetype) init {
    self = [super init];
    if ( self ) {
        _canInternalyRefresh = TRUE;
        _wasTracking = FALSE;
        
        // Configurable
        self.canInvokeActionSets = sIonScrollRefreshActionDefault_CanInvokeActionSets;
        self.distance = sIonScrollRefreshActionDefault_Distance;
    }
    return self;
}

- (instancetype) initWithRequiredDistance:(CGFloat) distance {
    self = [super init];
    if ( self )
        self.distance = distance;
    return self;
}

#pragma mark Status Delegate

- (void) setStatusDelegate:(id<IonScrollRefreshActionStatusDelegate>)statusDelegate {
    if ( !statusDelegate )
        _statusDelegate = statusDelegate;
    else if ( [(NSObject *)statusDelegate conformsToProtocol: @protocol(IonScrollRefreshActionStatusDelegate)] ) {
        _statusDelegate = statusDelegate;
        lastDelegateUpdateValue = 0.0f;
    }
}

- (void) updateDelegateWithPercentage:(CGFloat) percentage {
    self.statusDelegate.gestureCompletionPercentage = lastDelegateUpdateValue = percentage;
}

#pragma mark Scroll View Interface

- (void) scrollViewDidUpdateContext:(IonScrollView *)scrollView {
    NSParameterAssert( scrollView && [scrollView isKindOfClass: [IonScrollView class]] );
    if ( !scrollView || ![scrollView isKindOfClass: [IonScrollView class]] )
        return;
    
    /** Update Checks */
    // A refresh can be initialize by pulling the scroll view down past the threshold, when a
    // refresh is not in progress, and we are actively tracking a finger.
    if ( scrollView.contentOffset.y <= ( ABS( self.distance ) * -1 ) && // did we pass our distance
        _wasTracking && !scrollView.tracking && // Did the user Just let go
        _canInternalyRefresh && _canInvokeActionSets ) { // can we invoke?
        
        _canInternalyRefresh = false; // We are now in a internal refresh.
        [self invokeTargetAction];
    }
    else if ( scrollView.contentOffset.y >= 0 ) // Did we reset?
        _canInternalyRefresh = true; // We have reset enough, now we are no longer in a internal refresh.
    
    _wasTracking = scrollView.tracking; // Update previous state with current one.
    
    
    
    
    /** Delegate Updates */
    // Update our status delegate with our current percentage to completion
    if ( self.statusDelegate ) {
        if ( scrollView.contentOffset.y <= 0 )
            [self updateDelegateWithPercentage: MIN( ABS( scrollView.contentOffset.y ) / ABS( self.distance ), 1.0)];
        else if ( lastDelegateUpdateValue != 0.0f ) // Only report zero once.
            [self updateDelegateWithPercentage: 0.0f];
    }
}
@end

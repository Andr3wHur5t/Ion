//
//  IonScrollActionView.m
//  Ion
//
//  Created by Andrew Hurst on 10/3/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonScrollActionView.h"
#import "IonScrollView.h"

@interface IonScrollActionView ()
#pragma mark Interface Management
/**
 * Invokes our standard interface configurations clean up methods.
 */
- (void) removeFromSuperview;

/**
 * Invokes our standard interface configuration if our super view is a IonScrollView.
 */
- (void) willMoveToSuperview:(UIView *)newSuperview;

@end

@implementation IonScrollActionView
#pragma mark Standard Interface

- (void) configureScrollView:(IonScrollView *)scrollView {
    // Should be subclassed.
}

- (void) removeConfigurationsFromScrollView:(IonScrollView *)scrollView {
    // Should be subclassed.
}

#pragma mark Interface Management

- (void) removeFromSuperview {
    if ( self.superview && [self.superview isKindOfClass: [IonScrollView class]] )
        [self removeConfigurationsFromScrollView: (IonScrollView *)self.superview];
    [super removeFromSuperview];
}

- (void) willMoveToSuperview:(UIView *)newSuperview {
    if ( newSuperview && [newSuperview isKindOfClass: [IonScrollView class]] )
        [self configureScrollView: (IonScrollView *)newSuperview];
    [super willMoveToSuperview: newSuperview];
}

@end

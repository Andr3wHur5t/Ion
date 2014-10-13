//
//  IonStatusBarBehavior.m
//  Ion
//
//  Created by Andrew Hurst on 8/25/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonStatusBarBehaviorMotionGestureDisplay.h"
#import "IonApplication.h"
#import "IonApplication+StatusBar.h"
#import <IonData/IonData.h>

@interface IonStatusBarBehaviorMotionGestureDisplay ()

/**
 * The timing mechnisim for display
 */
@property (strong, nonatomic, readonly) FOTimedAction* timedAction;

@end

@implementation IonStatusBarBehaviorMotionGestureDisplay

@synthesize timedAction = _timedAction;

#pragma mark Constructors
/**
 * Default Constructor.
 */
- (instancetype) init {
    self = [super init];
    if ( self ) {
        self.animation = UIStatusBarAnimationSlide;
        self.targetMotionType = UIEventSubtypeMotionShake;
        self.behaviorMode = IonStatusBarBehavior_ToggelTimed;
        self.duration = 5.0;
    }
    return self;
}

#pragma mark Status Bar Interface

/**
 * Updates our internal state, and the status bar.
 
 */
- (void) updateState {
    switch ( self.behaviorMode ) {
        case IonStatusBarBehavior_ToggleStatus:
            [self updateToggleMode];
            break;
        default:
            [self updateExtendMode];
            break;
    }
}

#pragma mark Timed Action

/**
 * Gets or constructs the timed action.
 */
- (FOTimedAction *)timedAction {
    if ( !_timedAction ) {
        _timedAction = [[FOTimedAction alloc] init];
        
        // Set the action to toggle the animation
        [_timedAction setTarget: self andAction: @selector(updateToggleMode)];
    }
    return _timedAction;
}

#pragma mark Status Bar Mode Handlers

/**
 * Update function for the extend time mode.
 
 */
- (void) updateExtendMode {
    NSTimeInterval netTime;
    netTime = [NSDate date].timeIntervalSinceReferenceDate + self.duration;
    
    if ( !self.timedAction.inProgress ) {
        // Display
        [self updateToggleMode];
        
        // Set Dismissal
        self.timedAction.targetTime = netTime;
        [self.timedAction start];
    }
    else {
        if ( self.behaviorMode == IonStatusBarBehavior_ExtendExposureTime )
            self.timedAction.targetTime = netTime;
        else {
            [self.timedAction invalidate];
            [self updateToggleMode];
        }
    }
}

/**
 * Animates the status bar to the correct state using the set animation. Same As Toggle mode.
 
 */
- (void) updateToggleMode {
    [[IonApplication sharedApplication] setStatusBarHidden: ![IonApplication sharedApplication].statusBarHidden
                                             withAnimation: self.animation];
}

#pragma mark IonViewMotionGestureDelegate interface

/**
 * Checks if the target gesture completed.
 */
- (void) motionEnded:(UIEventSubtype) motion withEvent:(UIEvent*) event {
    if ( motion == self.targetMotionType )
        [self updateState];
}
@end

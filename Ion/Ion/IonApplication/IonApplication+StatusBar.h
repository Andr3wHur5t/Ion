//
//  IonApplication+StatusBar.h
//  Ion
//
//  Created by Andrew Hurst on 8/24/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <Ion/Ion.h>

static const CGFloat sIonNormalStatusBarHeight = 20.0f;

@interface IonApplication (StatusBar)
/**
 * Status Bar Frame. KVO compliant.
 */
@property (assign, nonatomic, readonly) CGRect statusBarFrame;

/**
 * Status Bar Hidden. KVO compliant.
 */
@property (assign, nonatomic) BOOL statusBarHidden;

/**
 * States if the in call bar is visible.
 * @warning Dose a literal Check. May Not work in future versions.
 */
@property (assign, nonatomic, readonly) BOOL inCallBarActive;

/**
 * Status Bar animation duration.
 * @warning Static
 */
@property (assign, nonatomic, readonly) CGFloat statusBarAnimationDuration;

/**
 * The current status bar animation type.
 */
@property (assign, nonatomic, readonly) UIStatusBarAnimation currentStatusBarAnimation;

#pragma mark Animation Utilities

/**
 * Runs a animation on the status bar that works with KVO.
 * @param {BOOL} states if the animation bar is to be hidden or not.
 * @param {UIStatusBarAnimation} the animation type to run on the status bar.
 * @returns {void}
 */
- (void) setStatusBarHidden:(BOOL) statusBarHidden withAnimation:(UIStatusBarAnimation) animation;


@end

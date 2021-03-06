//
//  IonApplication+StatusBar.h
//  Ion
//
//  Created by Andrew Hurst on 8/24/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonApplication.h"

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
 * @warning Dose a literal Check. May Not work in future versions. This dose not work when the status bar is hidden.
 */
@property (assign, nonatomic, readonly) BOOL inCallBarActive;

/**
 * Status Bar animation duration.
 * @warning Static
 */
@property (assign, nonatomic, readonly) CGFloat statusBarAnimationDuration;

/**
 * The current status bar animation type. KVO compliant.
 */
@property (assign, nonatomic, readonly) UIStatusBarAnimation currentStatusBarAnimation;

/*!
 @brief Guide representing the height of the status bar.
 */
@property (nonatomic, readonly) IonGuideLine *statusBarHeightGuide;

#pragma mark Animation Utilities

/**
 * Runs a animation on the status bar that works with KVO.
 * @param statusBarHidden - states if the animation bar is to be hidden or not.
 * @param animation - the animation type to run on the status bar.
 */
- (void) setStatusBarHidden:(BOOL) statusBarHidden withAnimation:(UIStatusBarAnimation) animation;


@end

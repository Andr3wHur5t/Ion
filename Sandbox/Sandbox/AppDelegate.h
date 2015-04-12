//
//  AppDelegate.h
//  Sandbox
//
//  Created by Andrew Hurst on 10/19/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <IonCore/IonCore.h>
#import "MainViewController.h"

@interface AppDelegate : IonApplication

/**
 * Our Status bar behavior.
 */
@property (strong, nonatomic, readonly) IonStatusBarBehaviorMotionGestureDisplay* statusBarBehavior;

#pragma mark Controllers

/**
 * Our applications main controller.
 */
@property (strong, nonatomic, readonly) MainViewController *mainViewController;

@end


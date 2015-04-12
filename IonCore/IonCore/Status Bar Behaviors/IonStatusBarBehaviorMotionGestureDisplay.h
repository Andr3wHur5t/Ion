//
//  IonStatusBarBehavior.h
//  Ion
//
//  Created by Andrew Hurst on 8/25/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IonData/IonData.h>
#import "IonViewMotionGestureManager.h"

/**
 * The Modes available for motion gesture status bar display.
 */
typedef enum : NSUInteger {
  IonStatusBarBehavior_ToggleStatus = 0,
  IonStatusBarBehavior_ExtendExposureTime,
  IonStatusBarBehavior_ToggelTimed,
} IonStatusBarBehavior;

@interface IonStatusBarBehaviorMotionGestureDisplay
    : NSObject<IonViewMotionGestureDelegate>

/**
 * The Duration that the status bar will be displayed.
 * If Zero it will stay out indefinitely.
 */
@property(assign, nonatomic) NSTimeInterval duration;

/**
 * The mode which describe how an additional gesture will be handled.
 */
@property(assign, nonatomic) IonStatusBarBehavior behaviorMode;

/**
 * The animation to use when changing the state of the status bar.
 */
@property(assign, nonatomic) UIStatusBarAnimation animation;

/**
 * The gesture type which will cause the status bar to be exposed.
 */
@property(assign, nonatomic) UIEventSubtype targetMotionType;

@end

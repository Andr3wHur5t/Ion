//
//  IonScrollRefreshActionView.h
//  Ion
//
//  Created by Andrew Hurst on 10/3/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonScrollActionView.h"


#pragma mark Defaults
static const CGFloat sIonRefreshActionViewDefault_ActiveHeight = 80.0f;
static const CGFloat sIonRefreshActionViewDefault_ActivationDistance = 85.0f;
static const BOOL sIonRefreshActionViewDefault_CanAutomaticallyDisplay = TRUE;

#pragma mark Style Keys
static NSString *sIonRefreshActionViewStyle_Name = @"scrollRefreshBackground";

static NSString *sIonRefreshActionViewStyle_ActiveHeight = @"activeHeight";
static NSString *sIonRefreshActionViewStyle_ActivationDistance = @"activationDistance";

#pragma mark Enums
typedef enum : NSUInteger {
    IonScrollRefreshActionViewState_Open = 0,
    IonScrollRefreshActionViewState_Closed = 1
} IonScrollRefreshActionViewState;

/**
 * A automatically managed refresh action for IonScroll views.
 * @warning You are responsible for receding the refresh view once finished refreshing.
 */
@interface IonScrollRefreshActionView : IonScrollActionView
/**
 * Constructs with the inputted content view, active height, and activation distance.
 * @param contentView - the content view that will be displayed inside the refresh view.
 * @param activeHeight - the active height of the content displayed area after activation.
 * @param distance - the distance required to activate the view.
 */
- (instancetype) initWithContentView:(UIView *)contentView
                        activeHeight:(CGFloat) activeHeight
               andActivationDistance:(CGFloat) distance;

/**
 * Constructs with the inputted content view, and active height.
 * @param contentView - the content view that will be displayed inside the refresh view.
 * @param activeHeight - the active height of the content displayed area after activation.
 */
- (instancetype) initWithContentView:(UIView *)contentView andActiveHeight:(CGFloat)activeHeight;

/**
 * Constructs with the inputted content view.
 * @param contentView - the content view that will be displayed inside the refresh view.
 */
- (instancetype) initWithContentView:(UIView *)contentView;

#pragma mark Configuration
/**
 * The content view displayed inside of this action view.
 * @warning This will automatically set the views guides, and superview.
 */
@property (strong, nonatomic, readwrite) UIView *contentView;

/**
 * The height of visible area when we are in open mode.
 */
@property (assign ,nonatomic, readwrite) CGFloat activeHeight;

/**
 * The pull distance required to constitute a refresh.
 * @warning Should be a positive value.
 */
@property (nonatomic, readwrite) CGFloat activationDistance;

/**
 * Our current animation state.
 */
@property (assign, nonatomic, readonly) IonScrollRefreshActionViewState state;

/**
 * States if the view can automatically show when a refresh gesture occurs.
 */
@property (assign, nonatomic, readwrite) BOOL canAutomaticallyDisplay;

#pragma mark Positioning
/**
 * Adjusts our scroll views' content insets to display the refresh views' active area.
 */
- (void) show;

/**
 * Adjusts our scroll views' content inset to match what they were before we showed the refresh views'
 * active area.
 */
- (void) hide;

#pragma mark Animations
/**
 * Performs a show using an animation with the current animation duration of the view.
 */
- (void) showAnimated;

/**
 * Performa a hide using an animation with the current animation duration of the view.
 */
- (void) hideAnimated;

#pragma mark Target Action

/**
 * Adds the inputted target action set to our target action list, so we can invoke it when we refresh.
 * @param targetAction - the target action set to add.
 */
- (void) addTargetActionSet:(FOTargetActionSet *)targetAction;

/**
 * Adds the target, and action as a target action set to our target action list to be invoked when we refresh.
 * @param target - the target to be invoked with the action when we refresh.
 * @param action - the action to be invoked on the target when we refresh.
 */
- (void) addTarget:(id) target andAction:(SEL)action;

/**
 * Removes the inputted target action set from out target action list.
 * @param targetAction - the target action set to remove.
 */
- (void) removeTargetActionSet:(FOTargetActionSet *)targetAction;

/**
 * Removes all instances matching the inputted target, and action from our target action list.
 * @param target - the target that was associated with the action.
 * @param action - the action that was associated with the target.
 */
- (void) removeTarget:(id) target andAction:(SEL)action;

@end

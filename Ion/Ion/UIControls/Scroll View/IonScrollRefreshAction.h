//
//  IonScrollRefreshAction.h
//  Ion
//
//  Created by Andrew Hurst on 10/2/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <Ion/Ion.h>

#pragma mark Defaults
static const CGFloat sIonScrollRefreshActionDefault_Distance = 80.0f;
static const BOOL sIonScrollRefreshActionDefault_CanInvokeActionSets = TRUE;


#pragma mark Update Delegate
@protocol IonScrollRefreshActionStatusDelegate
/**
 * The current percentage to gesture completion.
 */
@property (nonatomic, readwrite) CGFloat gestureCompletionPercentage;

@end


/**
 * A scroll action that reports a pull refresh.
 */
@interface IonScrollRefreshAction : IonScrollAction
#pragma mark Construction
/**
 * Constructs a scroll refresh action using the inputted distance as the threshold.
 * @param distance - The pull distance required to constitute a refresh.
 */
- (instancetype) initWithRequiredDistance:(CGFloat) distance;

#pragma mark Configuration
/**
 * States if refresh can invoke the action sets if we have passed all conditions.
 */
@property (assign, nonatomic, readwrite) BOOL canInvokeActionSets;

/**
 * The pull distance required to constitute a refresh.
 */
@property (assign, nonatomic, readwrite) CGFloat distance;

#pragma mark Status Delegate
/**
 * The object which will receive status updates about the gesture.
 */
@property (weak, nonatomic, readwrite) id<IonScrollRefreshActionStatusDelegate> statusDelegate;

@end

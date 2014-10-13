//
//  IonScrollAction.h
//  Ion
//
//  Created by Andrew Hurst on 10/2/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IonData/IonData.h>

@class IonScrollView;

/**
 * An abstract class for observing changes to a scroll view, and invokeing a traget action set.
 */
@interface IonScrollAction : NSObject

#pragma mark Target Action
/**
 * Adds a target action set to our target action list.
 * @param targetAction - the target action to add to the target action list.
 */
- (void) addTargetActionSet:(FOTargetActionSet *)targetAction;

/**
 * Adds a target action set to our target action list.
 * @param target - the target to invoke the action on.
 * @param action - the action to invoke on the target.
 */
- (void) addTarget:(id) target andAction:(SEL) action;

/**
 * Removes a target action set to our target action list.
 * @param targetAction - the target action to add to the target action list.
 */
- (void) removeTargetActionSet:(FOTargetActionSet *)targetAction;

/**
 * Removes a target action set to our target action list.
 * @param target - the target that you want removed with the action.
 * @param action - the action you want removes with the target.
 */
- (void) removeTarget:(id) target andAction:(SEL) action;

/**
 * Invokes our target actions.
 */
- (void) invokeTargetAction;

#pragma mark Scroll View Interface
/**
 * Informs the treshold that the scroll view did upate with the inputted context.
 * @param scrollView - the scroll view that updated it's context.
 */
- (void) scrollViewDidUpdateContext:(IonScrollView *)scrollView;

@end

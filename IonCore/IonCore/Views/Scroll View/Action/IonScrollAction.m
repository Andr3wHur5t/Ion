//
//  IonScrollAction.m
//  Ion
//
//  Created by Andrew Hurst on 10/2/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonScrollAction.h"
#import "IonScrollView.h"


@interface IonScrollAction ()

/**
 * Our target actions.
 */
@property (strong, nonatomic, readonly) FOTargetActionList *targetActions;

@end

@implementation IonScrollAction

@synthesize targetActions = _targetActions;

#pragma mark Target Action

- (FOTargetActionList *)targetActions {
    if ( !_targetActions )
        _targetActions = [[FOTargetActionList alloc] init];
    return _targetActions;
}

- (void) addTargetActionSet:(FOTargetActionSet *)targetAction {
    [self.targetActions addActionSet: targetAction toGroup: @"observers"];
}

- (void) addTarget:(id) target andAction:(SEL) action {
    [self.targetActions addTarget: target andAction: action toGroup: @"observers"];
}

- (void) removeTargetActionSet:(FOTargetActionSet *)targetAction {
    [self.targetActions removeActionSet: targetAction fromGroup: @"observers"];
}

- (void) removeTarget:(id) target andAction:(SEL) action {
    [self.targetActions removeTarget: target andAction: action fromGroup: @"observers"];
}

- (void) invokeTargetAction {
    [self.targetActions invokeActionSetsInGroup: @"observers"];
}

#pragma mark Scroll View Interface

- (void) scrollViewDidUpdateContext:(IonScrollView *)scrollView {
    // This should be overloaded by a subclass.
}
@end

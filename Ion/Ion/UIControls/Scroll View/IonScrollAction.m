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
@property (strong, nonatomic, readonly) IonTargetActionList *targetActions;

@end

@implementation IonScrollAction

@synthesize targetActions = _targetActions;

#pragma mark Target Action

- (IonTargetActionList *)targetActions {
    if ( !_targetActions )
        _targetActions = [[IonTargetActionList alloc] init];
    return _targetActions;
}

- (void) addTargetActionSet:(IonTargetActionSet *)targetAction {
    [self.targetActions addActionSet: targetAction toGroup: 0];
}

- (void) addTarget:(id) target andAction:(SEL) action {
    [self.targetActions addTarget: target andAction: action toGroup: 0];
}

- (void) removeTargetActionSet:(IonTargetActionSet *)targetAction {
    [self.targetActions removeActionSet: targetAction fromGroup: 0];
}

- (void) removeTarget:(id) target andAction:(SEL) action {
    [self.targetActions removeTarget: target andAction: action fromGroup: 0];
}

- (void) invokeTargetAction {
    [self.targetActions invokeActionSetsInGroup: 0];
}

#pragma mark Scroll View Interface

- (void) scrollViewDidUpdateContext:(IonScrollView *)scrollView {
    // This should be overloaded by a subclass.
}
@end

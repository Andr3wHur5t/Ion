//
//  FOTimedAction.m
//  FOUtilities
//
//  Created by Andrew Hurst on 10/9/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "FOTimedAction.h"
#import <FOUtilities/NSObject+FOObject.h>
#import <FOUtilities/FOTargetActionSet.h>

@interface FOTimedAction ()  {
    BOOL _inProgress;
    FOTargetActionSet *targetAction;
}

/**
 * Invokes the target action set.
 */
- (void) invoke;

/**
 * Stages a new instance for the current target time.
 */
- (void) stageNewInstanceWithCurrent;

/**
 * A map containig state variables for each active instance.
 */
@property (strong, nonatomic, readonly) NSMutableDictionary* instances;

@end

@implementation FOTimedAction

@synthesize  instances = _instances;
@synthesize targetTime = _targetTime;

#pragma mark Instances Map

- (NSMutableDictionary *)instances {
    if ( !_instances )
        _instances = [[NSMutableDictionary alloc] init];
    return _instances;
}

#pragma mark Target Time

+ (BOOL) automaticallyNotifiesObserversOfTargetTime { return FALSE; }

- (void) setTargetTime:(NSTimeInterval) targetTime {
    NSTimeInterval oldTargetTime = _targetTime;
    [self willChangeValueForKey: @"targetTime"];
    _targetTime = targetTime;
    [self didChangeValueForKey: @"targetTime"];
    
    // Check it the time is before now
    if ( targetTime < [NSDate date].timeIntervalSinceReferenceDate ) {
        [self invoke]; // it is time to invoke
        return;
    }
    
    // Check if we need to spin up a new instance.
    if ( oldTargetTime > _targetTime ) {
        // Invalidate all
        [self.instances removeAllObjects];
        
        // Spin up a new instance to meet the smaller time.
        [self stageNewInstanceWithCurrent];
    }
}

#pragma mark Management

- (void) start {
    if ( self.targetTime > [NSDate date].timeIntervalSinceReferenceDate )
        [self stageNewInstanceWithCurrent];
    else
        [self invoke];
}

- (void) invalidate {
    // Invalidate all instances
    [_instances removeAllObjects];
    _inProgress = FALSE;
}

- (void) stageNewInstanceWithCurrent {
    NSTimeInterval targetTime;
    __block NSString* instanceID;
    
    // Setup Instance
    _inProgress = TRUE;
    targetTime = self.targetTime - [NSDate date].timeIntervalSinceReferenceDate;
    instanceID = [[[NSUUID alloc] init] UUIDString];
    
    // Set instance as valid
    [self.instances setObject: @1 forKey: instanceID];
    
    // Dispatch Instance
    [self performBlock:^{
        // Check If out instance is still valid.
        if ( ![self.instances objectForKey: instanceID] )
            return;
        
        // Check if the target time is now
        if ( self.targetTime < [NSDate date].timeIntervalSinceReferenceDate )
            [self invoke]; // invoke the action
        else
            [self stageNewInstanceWithCurrent]; // stage a new instance to meet our goal.
        
        // invalidate our self
        [self.instances removeObjectForKey: instanceID];
        
    } afterDelay: targetTime];
}

- (void) invoke {
    if ( !targetAction )
        return;
    [targetAction invoke];
    // Invalidate all other instances
    [self invalidate];
}

#pragma mark Setter

- (void) setTarget:(id) target andAction:(SEL) action {
    targetAction = [FOTargetActionSet setWithTarget: target andAction: action];
}

@end

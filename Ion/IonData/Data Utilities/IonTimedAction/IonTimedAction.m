//
//  IonTimedAction.m
//  Ion
//
//  Created by Andrew Hurst on 8/25/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonTimedAction.h"
#import "NSObject+IonUtilties.h"

@interface IonTimedAction () {
    NSMutableDictionary* _instances;
    NSTimeInterval _targetTime;
    BOOL _inProgress;
    
    id _target;
    SEL _action;
}

/**
 * A map containig state variables for each active instance.
 */
@property (strong, nonatomic, readonly) NSMutableDictionary* instances;

@end

@implementation IonTimedAction
#pragma mark Constructor.

/**
 * Default Constructor.
 */
- (instancetype) init {
    self = [super init];
    if ( self ) {
        
    }
    return self;
}

#pragma mark Instances Map

/**
 * Retrives or creates the instances map.
 */
- (NSMutableDictionary*) instances {
    if ( !_instances )
        _instances = [[NSMutableDictionary alloc] init];
    return _instances;
}

#pragma mark Target Time

/**
 * Switch KVO to manual
 */
+ (BOOL) automaticallyNotifiesObserversOfTargetTime { return FALSE; }

/**
 * Setter for Target time.
 * @param {NSTimeInterval} the new time interval.
 * @returns {void}
 */
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

/**
 * Stages the invocation at specified time.
 */
- (void) start {
    if ( self.targetTime > [NSDate date].timeIntervalSinceReferenceDate )
        [self stageNewInstanceWithCurrent];
    else
        [self invoke];
}

/**
 * Invalidates the staged invocation.
 */
- (void) invalidate {
    // Invalidate all instances
    [_instances removeAllObjects];
    _inProgress = FALSE;
}

/**
 * Stages a new instance for the current target time.
 */
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

/**
 * Invokes the action on the target.
 */
- (void) invoke {
    if ( !_target || !_action )
        return;
    
    id strongTarget = _target;
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [strongTarget performSelector: _action withObject: NULL];
    #pragma clang diagnostic pop
    
    // Invalidate all other instances
    [self invalidate];
}

#pragma mark Setter

/**
 * Sets the target action pair to be invoked once the target time has been reached.
 * @param {id} the target object.
 * @param {SEL} the selector to call on the target object.
 * @returns {void}
 */
- (void) setTarget:(id) target andAction:(SEL) action {
    NSParameterAssert( target && [target respondsToSelector: action] );
    if ( !target || ![target respondsToSelector: action] )
        return;
    
    _target = target;
    _action = action;
}


@end

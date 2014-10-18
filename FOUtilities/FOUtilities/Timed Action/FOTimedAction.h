//
//  FOTimedAction.h
//  FOUtilities
//
//  Created by Andrew Hurst on 10/9/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FOTimedAction : NSObject
/**
 * The time to invoke the selector at, this can be updated during a staged targetInvocation.
 */
@property (assign, nonatomic) NSTimeInterval targetTime;

/**
 * States if the targetInvocation is currently staged.
 */
@property (assign, nonatomic, readonly) BOOL inProgress;

/**
 * Stages the invocation at specified time.
 */
- (void) start;

/**
 * Invalidates the staged invocation.
 */
- (void) invalidate;

/**
 * Sets the target action pair to be invoked once the target time has been reached.
 * @param target - the target object.
 * @param action - the selector to call on the target object.
 */
- (void) setTarget:(id) target andAction:(SEL) action;

@end

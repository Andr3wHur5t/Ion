//
//  IonTimedAction.h
//  Ion
//
//  Created by Andrew Hurst on 8/25/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IonTimedAction : NSObject

/**
 * The time to invoke the selector at, this can be updated during a staged invokation.
 */
@property (assign, nonatomic) NSTimeInterval targetTime;

/**
 * States if the invokation is currently staged.
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
 * @param {id} the target object.
 * @param {SEL} the selector to call on the target object.
 * @returns {void}
 */
- (void) setTarget:(id) target andAction:(SEL) action;

@end

//
//  IonTargetActionSet.h
//  Ion
//
//  Created by Andrew Hurst on 10/1/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IonTargetActionSet : NSObject
#pragma mark Construction
/**
 * Constructs a target action set using the inputted target, and selector.
 * @param target - the target object that should be invoked with the selector.
 * @param action - the selector that we will invoke on the target.
 * @raturns {instancetype}
 */
- (instancetype) initWithTarget:(id) target andAction:(SEL) action;

/**
 * Constructs a target action set using the inputted target, and selector.
 * @param target - the target object that should be invoked with the selector.
 * @param action - the selector that we will invoke on the target.
 * @raturns {instancetype}
 */
+ (instancetype) setWithTarget:(id) target andAction:(SEL) action;

#pragma mark Meta
/**
 * The target object that we will invoke the action on.
 */
@property (weak, nonatomic, readonly) id target;

/**
 * The action to invoke on the object.
 */
@property (assign, nonatomic, readonly) SEL action;

/**
 * Reports if the selector pair is currently valid, and invokable.
 */
@property (assign, nonatomic, readonly) BOOL isValid;

#pragma mark invocation
/**
 * Invoke the target action set with no arguments.
 */
- (id) invoke;

/**
 * Invoke the target action set with the inputted object and returns the result.
 * @param object - the object to invoke on the set.
 * @returns the result of the action.
 */
- (id) invokeWithObject:(id) object;

/**
 * Invoke the target action set with the inputted object and returns the result.
 * @param object - the object to invoke on the set.
 * @param otherObject - the other object to invoke on the set.
 * @returns the result of the action.
 */
- (id) invokeWithObject:(id) object andObject:(id) otherObject;

#pragma mark comparison
/**
 * Checks if the target, and action match the inputted values.
 * @param target - the target to compare.
 * @param action - the action to compare.
 * @returns {BOOL}
 */
- (BOOL) isEqualToTarget:(id) target andAction:(SEL) action;
@end

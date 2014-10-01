//
//  IonTargetActionSet.m
//  Ion
//
//  Created by Andrew Hurst on 10/1/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonTargetActionSet.h"


/**
 * Checks if the cstrings match.
 * @param str1 - the first string
 * @param str2 - the second string to compare
 * @returns BOOL
 */
inline static BOOL cStringsAreEqual( char *str1, char *str2 ) {
    NSUInteger position;
    position = 0;
    while ( str1[ position ] && str2[ position ] ) {
        if ( str1[ position ] != str2[ position ] )
            return FALSE;
        ++position;
    }
    return TRUE;
}

@implementation IonTargetActionSet
#pragma mark Construction
/**
 * Constructs a target action set using the inputted target, and selector.
 * @param target - the target object that should be invoked with the selector.
 * @param action - the selector that we will invoke on the target.
 * @raturns {instancetype}
 */
- (instancetype) initWithTarget:(id) target andAction:(SEL) action {
    NSParameterAssert( target );
    NSParameterAssert( action );
    if ( !target || !action )
        return NULL;
    
    self = [super init];
    if ( self ) {
        _target = target;
        _action = action;
    }
    return self;
}

/**
 * Constructs a target action set using the inputted target, and selector.
 * @param target - the target object that should be invoked with the selector.
 * @param action - the selector that we will invoke on the target.
 * @raturns {instancetype}
 */
+ (instancetype) setWithTarget:(id) target andAction:(SEL) action {
    return [[[self class] alloc] initWithTarget: target andAction: action];
}

#pragma mark Is Valid
/**
 * Gets if the current target action values are valid.
 * @returns {BOOL}
 */
- (BOOL) isValid {
    if ( !_target || !_action )
        return FALSE;
    return  [_target respondsToSelector: _action];
}

#pragma mark invocation
/**
 * Invoke the target action set with no arguments.
 */
- (id) invoke {
    return [self invokeWithObject: NULL];
}

/**
 * Invoke the target action set with the inputted object and returns the result.
 * @param object - the object to invoke on the set.
 * @returns the result of the action.
 */
- (id) invokeWithObject:(id) object {
    return [self invokeWithObject: object andObject: NULL];
}

/**
 * Invoke the target action set with the inputted object and returns the result.
 * @param object - the object to invoke on the set.
 * @param otherObject - the other object to invoke on the set.
 * @returns the result of the action.
 */
- (id) invokeWithObject:(id) object andObject:(id) otherObject {
    NSMethodSignature *methodSig;
    NSInvocation *targetInvocation;
    char *returnType;
    void *rawResult;
    id result;
    if ( !self.isValid )
        return NULL;
    
    // Create the invocation
    methodSig = [_target methodSignatureForSelector: _action];
    targetInvocation = [NSInvocation invocationWithMethodSignature: methodSig];
    [targetInvocation setTarget: _target];
    [targetInvocation setSelector: _action];
    
    // Add Arguments, Be wary of this!
    if ( object && methodSig.numberOfArguments >= 2)
        [targetInvocation setArgument: &object atIndex: 2];
    if ( otherObject && methodSig.numberOfArguments >= 3)
        [targetInvocation setArgument: &otherObject atIndex: 3];
    
    // Invoke
    [targetInvocation retainArguments];
    [targetInvocation invoke];
    
    // Get the return data if aplicable
    returnType = (char *)[methodSig methodReturnType];
    if ( cStringsAreEqual( returnType, @encode(id) ) )
        [targetInvocation getReturnValue: &result];
    else if ( !cStringsAreEqual( returnType, @encode(void) )) {
        // Note to maintainers, Be wary of this im unsure if it acomidates all senarios.
        // Not void then encode to NSValue
        [targetInvocation getReturnValue: &rawResult];
        result = [NSValue valueWithBytes: rawResult objCType: returnType];
    }
    return result;
}


#pragma mark comparison
/**
 * Checks if the values are equal.
 * @param object - the object to compare agents self.
 * @returns {BOOL}
 */
- (BOOL) isEqual:(id) object {
    if ( !object || ![object isKindOfClass: [self class]] )
        return FALSE;
    return [self isEqualToTarget: ((IonTargetActionSet *)object).target
                       andAction: ((IonTargetActionSet *)object).action];
}

/**
 * Checks if the target, and action match the inputted values.
 * @param target - the target to compare.
 * @param action - the action to compare.
 * @returns {BOOL}
 */
- (BOOL) isEqualToTarget:(id) target andAction:(SEL) action {
    if ( !target || !action )
        return FALSE;
    return [_target isEqual: target] && _action == action;
}

@end

//
//  IonMethodMap.m
//  Ion
//
//  Created by Andrew Hurst on 7/21/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonMethodMap.h"

@interface IonMethodMap ()

/**
 * This is our map of method key pairs.
 * Note: use atomic to support async operations.
 */
@property (strong) NSMutableDictionary* keyMethodMap;

@end

@implementation IonMethodMap


#pragma mark Constructors

/**
 * This is the default constructor.
 * @returns {instancetype}
 */
- (instancetype) init {
    self = [super init];
    if ( self )
        _keyMethodMap = [[NSMutableDictionary alloc] init];
    return self;
}

/**
 * This constructs the method map with the specified target.
 * @param {id} the target to invoke the map methods on.
 * @returns {instancetype}
 */
- (instancetype) initWithTarget:(id) target {
    self = [self init];
    if ( self && target )
        [self setTarget: target];
    return self;
}


#pragma mark Management

/**
 * This sets the inputed key to map to the inputted method.
 * @param {SEL} the selector method to call for the key.
 * @param {id} the key to map tho the method.
 * @returns {void}
 */
- (void) setMethod:(SEL) method forKey:(id) key {
    if ( !method || !key )
        return;
    
    [_keyMethodMap setObject: [IonMethodSelector methodSelectorWithSelector: method] forKey: key];
}

/**
 * This retrieves a method for the inputted key.
 * @param {id} the key to get the method from.
 * @returns {SEL} the method for the inputted key, or NULL if invalid.
 */
- (SEL) methodForKey:(id) key {
    if ( !key )
        return NULL;
    
    return ((IonMethodSelector*)[_keyMethodMap objectForKey: key]).selector;
}

/**
 * This will remove the method, and key mapping from the map.
 * @param {id} the key to find and remove the pair with.
 * @returns {void}
 */
- (void) removeMethodForKey:(id) key {
    if ( !key )
        return;
    [_keyMethodMap removeObjectForKey: key];
}

/**
 * This will remove all mappings from the map.
 * @returns {void}
 */
- (void) removeAll {
    [_keyMethodMap removeAllObjects];
}


#pragma mark Invocation

/**
 * This will check if the inputed method selector is valid for our target.
 * @param {SEL} the method selector to check.
 * @returns {BOOL} true if it is valid, otherwise false
 */
- (BOOL) methodIsValidForTarget:(SEL) method {
    if ( !method || !_target )
        return FALSE;
    
    if ( ![_target respondsToSelector:method] )
        return FALSE;
    
    return TRUE;
}

/**
 * This will invoke the inputed method on our target.
 * @param {SEL} the method to invoke.
 * @param {id} the object to pass to the method.
 * @returns {id} returns true on success, otherwise false.
 */
- (id) invokeMethodOnTarget:(SEL) method withObject:(id) object {
    if ( ![self methodIsValidForTarget: method] )
        return NULL;
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    return [_target performSelector: method withObject: object];
    #pragma clang diagnostic pop
}


/**
 * This will invoke the inputed method on our target.
 * @param {SEL} the method to invoke.
 * @param {id} the object to pass to the method.
 * @param {id} the object to pass to the method.
 * @returns {bool} returns true on success, otherwise false.
 */
- (id) invokeMethodOnTarget:(SEL) method withObject:(id) object andObject:(id) otherObject {
    if ( ![self methodIsValidForTarget: method] )
        return NULL;
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    return [_target performSelector: method withObject: object withObject: otherObject];
    #pragma clang diagnostic pop
}


/**
 * This will invoke the method set to the inputted key on the target object.
 * @param {id} the key to get the method to invoke on the target.
 * @retuns {BOOL} returns true on success, otherwise false.
 */
- (id) invokeMethodOnTargetWithKey:(id) key {
    return [self invokeMethodOnTargetWithKey: key withObject: NULL];
}

/**
 * This will invoke the method set to the inputted key on the target object.
 * @param {id} the key to get the method to invoke on the target.
 * @param {id} the object to pass to the method.
 * @retuns {BOOL} returns true on success, otherwise false.
 */
- (id) invokeMethodOnTargetWithKey:(id) key withObject:(id) object {
    SEL method;
    if ( !key )
        return NULL;
    
    method = [self methodForKey: key];
    if ( !method )
        return NULL;
    
    return [self invokeMethodOnTarget: method withObject: object];
}

/**
 * This will invoke the method set to the inputted key on the target object.
 * @param {id} the key to get the method to invoke on the target.
 * @param {id} the object to pass to the method.
 * @param {id} the object to pass to the method.
 * @retuns {BOOL} returns true on success, otherwise false.
 */
- (id) invokeMethodOnTargetWithKey:(id) key withObject:(id) object andObject:(id) otherObject {
    SEL method;
    if ( !key )
        return NULL;
    
    method = [self methodForKey: key];
    if ( !method )
        return NULL;
    
    return [self invokeMethodOnTarget: method withObject: object andObject: otherObject];
}


@end

/**
 * This is a simple carrier object for id so we can store them in a map.
 */
@implementation IonMethodSelector

/**
 * This is a utility constructor.
 * @param {SEL} the selector to set.
 * @returns {IonMethodSelector*} the resulting object.
 */
+ (IonMethodSelector*) methodSelectorWithSelector: (SEL) selector {
    IonMethodSelector* methodSelector = [[IonMethodSelector alloc] init];
    
    methodSelector.selector = selector;
    
    return methodSelector;
}

@end

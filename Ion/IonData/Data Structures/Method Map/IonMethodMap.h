//
//  IonMethodMap.h
//  Ion
//
//  Created by Andrew Hurst on 7/21/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IonMethodMap : NSObject

#pragma mark Constructors

/**
 * This constructs the method map with the specified target.
 * @param {id} the target to invoke the map methods on.
 * @returns {instancetype}
 */
- (instancetype) initWithTarget:(id) target;

#pragma mark Properties

/**
 * The Target to call the methods on.
 */
@property ( strong, nonatomic ) id target;


#pragma mark Management

/**
 * This sets the inputed key to map to the inputted method.
 * @param {SEL} the selector method to call for the key.
 * @param {id} the key to map tho the method.
 
 */
- (void) setMethod:(SEL) method forKey:(id) key;

/**
 * This retrieves a method for the inputted key.
 * @param {id} the key to get the method from.
 * @returns {SEL} the method for the inputted key, or NULL if invalid.
 */
- (SEL) methodForKey:(id) key;

/**
 * This will remove the method, and key mapping from the map.
 * @param {id} the key to find and remove the pair with.
 
 */
- (void) removeMethodForKey:(id) key;

/**
 * This will remove all mappings from the map.
 
 */
- (void) removeAll;


#pragma mark Invocation

/**
 * This will check if the inputed method selector is valid for our target.
 * @param {SEL} the method selector to check.
 * @returns {BOOL} true if it is valid, otherwise false
 */
- (BOOL) methodIsValidForTarget:(SEL) method;

/**
 * This will invoke the inputed method on our target.
 * @param {SEL} the method to invoke.
 * @param {id} the object to pass to the method.
 * @returns {bool} returns true on success, otherwise false.
 */
- (id) invokeMethodOnTarget:(SEL) method withObject:(id) object;

/**
 * This will invoke the inputed method on our target.
 * @param {SEL} the method to invoke.
 * @param {id} the object to pass to the method.
 * @param {id} the object to pass to the method.
 * @returns {bool} returns true on success, otherwise false.
 */
- (id) invokeMethodOnTarget:(SEL) method withObject:(id) object andObject:(id) object;

/**
 * This will invoke the method set to the inputted key on the target object.
 * @param {id} the key to get the method to invoke on the target.
 * @retuns {BOOL} returns true on success, otherwise false.
 */
- (id) invokeMethodOnTargetWithKey:(id) key;

/**
 * This will invoke the method set to the inputted key on the target object.
 * @param {id} the key to get the method to invoke on the target.
 * @param {id} the object to pass to the method.
 * @retuns {BOOL} returns true on success, otherwise false.
 */
- (id) invokeMethodOnTargetWithKey:(id) key withObject:(id) object;

/**
 * This will invoke the method set to the inputted key on the target object.
 * @param {id} the key to get the method to invoke on the target.
 * @param {id} the object to pass to the method.
 * @param {id} the object to pass to the method.
 * @retuns {BOOL} returns true on success, otherwise false.
 */
- (id) invokeMethodOnTargetWithKey:(id) key withObject:(id) object andObject:(id) object;

@end


/**
 * This is a simple carrier object for id so we can store them in a map.
 */
@interface IonMethodSelector : NSObject

/**
 * This is a utilitiy constructor.
 * @param {SEL} the selector to set.
 * @returns {IonMethodSelector*} the resulting object.
 */
+ (IonMethodSelector*) methodSelectorWithSelector: (SEL) selector;

@property (assign, nonatomic) SEL selector;


@end

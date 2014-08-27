//
//  IonKeyValueObserver.h
//  Ion
//
//  Created by Andrew Hurst on 8/21/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * A Key value observation helper class.
 */
@interface IonKeyValueObserver : NSObject
#pragma mark Construction

/**
 * Constructs the observer object.
 * @param {id} the object to observe.
 * @param {NSString*} the keyPath to observe the object at.
 * @param {id} the target object to call when the observed value changes.
 * @param {SEL} the selector to preform on the target.
 * @param {NSKeyValueObservingOptions} the observation options to use.
 * @returns {instancetype}
 */
- (instancetype)initWithObject:(id) object
                       keyPath:(NSString*) keyPath
                        target:(id) target
                      selector:(SEL) selector
                       options:(NSKeyValueObservingOptions) options;

/**
 * Constructs the observer object.
 * @param {id} the object to observe.
 * @param {NSString*} the keyPath to observe the object at.
 * @param {id} the target object to call when the observed value changes.
 * @param {SEL} the selector to preform on the target.
 * @returns {instancetype}
 */
+ (instancetype) observeObject:(id) object
                       keyPath:(NSString*) keyPath
                        target:(id) target
                      selector:(SEL) selector __attribute__((warn_unused_result));

/**
 * Constructs the observer object.
 * @param {id} the object to observe.
 * @param {NSString*} the keyPath to observe the object at.
 * @param {id} the target object to call when the observed value changes.
 * @param {SEL} the selector to preform on the target.
 * @param {NSKeyValueObservingOptions} the observation options to use.
 * @returns {instancetype}
 */
+ (instancetype) observeObject:(id) object
                       keyPath:(NSString*) keyPath
                        target:(id) target
                      selector:(SEL) selector
                       options:(NSKeyValueObservingOptions) options __attribute__((warn_unused_result));
#pragma mark Target 

/**
 * The target object that the selector will be called on.
 */
@property (weak) id target;

/**
 * The selector that will be perform on the target.
 */
@property (assign) SEL selector;

#pragma mark Comparason

/**
 * Checks if the target and key path match
 * @param {id} the target object to check
 * @param {NSString*} the key path to check
 * @returns {BOOL}
 */
- (BOOL) matchesTarget:(id) target andKeyPath:(NSString*) keyPath;

@end

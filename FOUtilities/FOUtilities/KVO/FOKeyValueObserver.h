//
//  FOKeyValueObserver.h
//  FOUtilities
//
//  Created by Andrew Hurst on 10/9/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * A Key value observation helper class.
 */
@interface FOKeyValueObserver : NSObject
#pragma mark Construction
/**
 * Constructs the observer object.
 * @param object - the object to observe.
 * @param keyPath - the keyPath to observe the object at.
 * @param target - the target object to call when the observed value changes.
 * @param selector - the selector to preform on the target.
 * @param options - the observation options to use.
 */
- (instancetype)initWithObject:(id) object
                       keyPath:(NSString*) keyPath
                        target:(id) target
                      selector:(SEL) selector
                       options:(NSKeyValueObservingOptions) options;

/**
 * Constructs the observer object.
 * @param object - the object to observe.
 * @param keyPath - the keyPath to observe the object at.
 * @param target - the target object to call when the observed value changes.
 * @param selector - the selector to preform on the target.
 */
+ (instancetype) observeObject:(id) object
                       keyPath:(NSString*) keyPath
                        target:(id) target
                      selector:(SEL) selector __attribute__((warn_unused_result));

/**
 * Constructs the observer object.
 * @param object - the object to observe.
 * @param keyPath - the keyPath to observe the object at.
 * @param target - the target object to call when the observed value changes.
 * @param selector - the selector to preform on the target.
 * @param options - the observation options to use.
 */
+ (instancetype) observeObject:(id) object
                       keyPath:(NSString*) keyPath
                        target:(id) target
                      selector:(SEL) selector
                       options:(NSKeyValueObservingOptions) options __attribute__((warn_unused_result));

#pragma mark Observation Retrevial

@property (weak, nonatomic, readonly) id observedValue;

#pragma mark Target Action
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
 * @param target - the target object to check
 * @param keyPath - the key path to check
 */
- (BOOL) matchesTarget:(id) target andKeyPath:(NSString*) keyPath;

@end

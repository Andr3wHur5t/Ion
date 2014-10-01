//
//  IonKeyValueObserver.m
//  Ion
//
//  Created by Andrew Hurst on 8/21/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonKeyValueObserver.h"

@interface IonKeyValueObserver ()
// The path of the observed value
@property (nonatomic, copy) NSString* keyPath;
@property (nonatomic, strong) id observedObject;

/**
 * Calls the change change selector on the target object.
 * @param change - the change dictionary
 * @returns {void}
 */
- (void)didChange:(NSDictionary*) change;

@end

@implementation IonKeyValueObserver
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
- (instancetype) initWithObject:(id) object
                       keyPath:(NSString*) keyPath
                        target:(id) target
                      selector:(SEL) selector
                       options:(NSKeyValueObservingOptions) options {
    NSParameterAssert( target && [target respondsToSelector: selector] );
    NSParameterAssert( keyPath && [keyPath isKindOfClass:[NSString class]] );
    if ( !object  ||
         !keyPath || ![keyPath isKindOfClass:[NSString class]] ||
         !target  || ![target respondsToSelector: selector])
        return NULL;
    
    self = [super init];
    if (self) {
        self.target = target;
        self.selector = selector;
        self.observedObject = object;
        self.keyPath = keyPath;
        [object addObserver: self forKeyPath: keyPath options: options context: (__bridge void *)(self)];
    }
    return self;
}

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
                   selector:(SEL) selector __attribute__((warn_unused_result)) {
    return [[self alloc] initWithObject:object keyPath:keyPath target:target selector:selector options: 0];
}

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
                    options:(NSKeyValueObservingOptions) options __attribute__((warn_unused_result)) {
    return [[self alloc] initWithObject:object keyPath:keyPath target:target selector:selector options:options];
}

#pragma mark Response

/**
 * Responds to changes in the observed key path.
 * @param {NSString*} the key path of the changed value.
 * @param {id} the object that the change occurred on.
 * @param {NSDictionary*} information about the change.
 * @patam {void*} the context object.
 * @returns {void}
 */
- (void) observeValueForKeyPath:(NSString*) keyPath
                      ofObject:(id) object
                        change:(NSDictionary*) change
                       context:(void*) context {
    // Ensure we are the context
    if ( context == (__bridge void *)(self) )
        [self didChange: change];
}

/**
 * Calls the change change selector on the target object.
 * @param {NSDictionary*} the change dictionary
 * @returns {void}
 */
- (void) didChange:(NSDictionary*) change {
    id strongTarget = self.target;
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [strongTarget performSelector: self.selector withObject: change];
    #pragma clang diagnostic pop
}


#pragma mark Cleaning

/**
 * Unregisters the self from observation.
 * @returns {void}
 */
- (void) dealloc {
    if ( self.observedObject && self.keyPath && [self.keyPath isKindOfClass: [NSString class]] )
        [self.observedObject removeObserver: self forKeyPath: self.keyPath];
}


#pragma mark Comparason

/**
 * Checks if the target and key path match
 * @param {id} the target object to check
 * @param {NSString*} the key path to check
 * @returns {BOOL}
 */
- (BOOL) matchesTarget:(id) target andKeyPath:(NSString*) keyPath {
    NSParameterAssert( target );
    NSParameterAssert( keyPath && [keyPath isKindOfClass: [NSString class]] );
    if ( !target || !keyPath || ![keyPath isKindOfClass: [NSString class]] )
        return FALSE;
    
    return [_observedObject isEqual: target] && [_keyPath isEqualToString: keyPath];
}
@end

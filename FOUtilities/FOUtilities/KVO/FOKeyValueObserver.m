//
//  FOKeyValueObserver.m
//  FOUtilities
//
//  Created by Andrew Hurst on 10/9/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "FOKeyValueObserver.h"

@interface FOKeyValueObserver ()
/**
 * The path of the observed object
 */
@property (nonatomic, copy) NSString* keyPath;

/**
 * Refrence to the observed object.
 */
@property (nonatomic, strong) id observedObject;

#pragma mark KVO Response
/**
 * Responds to changes in the observed key path.
 * @param keyPath - the key path of the changed value.
 * @param object - the object that the change occurred on.
 * @param change - information about the change.
 * @param context - the context object.
 */
- (void) observeValueForKeyPath:(NSString*) keyPath
                       ofObject:(id) object
                         change:(NSDictionary*) change
                        context:(void*) context;

/**
 * Calls the change selector on the target object.
 * @param change - the change dictionary.
 */
- (void)didChange:(NSDictionary*) change;

@end

@implementation FOKeyValueObserver
#pragma mark Construction

- (instancetype) initWithObject:(id) object
                        keyPath:(NSString*) keyPath
                         target:(id) target
                       selector:(SEL) selector
                        options:(NSKeyValueObservingOptions) options {
    NSParameterAssert( target && [target respondsToSelector: selector] );
    NSParameterAssert( [keyPath isKindOfClass:[NSString class]] );
    if ( !object  || ![keyPath isKindOfClass:[NSString class]] || ![target respondsToSelector: selector])
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

+ (instancetype) observeObject:(id) object
                       keyPath:(NSString*) keyPath
                        target:(id) target
                      selector:(SEL) selector __attribute__((warn_unused_result)) {
    return [[self alloc] initWithObject:object keyPath:keyPath target:target selector:selector options: 0];
}

+ (instancetype) observeObject:(id) object
                       keyPath:(NSString*) keyPath
                        target:(id) target
                      selector:(SEL) selector
                       options:(NSKeyValueObservingOptions) options __attribute__((warn_unused_result)) {
    return [[self alloc] initWithObject:object keyPath:keyPath target:target selector:selector options:options];
}

#pragma mark Response

- (void) observeValueForKeyPath:(NSString*) keyPath
                       ofObject:(id) object
                         change:(NSDictionary*) change
                        context:(void*) context {
    // Ensure we are the context
    if ( context == (__bridge void *)(self) )
        [self didChange: change];
}

- (void) didChange:(NSDictionary*) change {
    // Invokes our taget action with the inputted change dictionary.
    id strongTarget = self.target;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [strongTarget performSelector: self.selector withObject: change];
#pragma clang diagnostic pop
}

- (id) observedValue {
    return [_observedObject valueForKeyPath: _keyPath];
}


#pragma mark Comparason

- (BOOL) matchesTarget:(id) target andKeyPath:(NSString*) keyPath {
    NSParameterAssert( target );
    NSParameterAssert( [keyPath isKindOfClass: [NSString class]] );
    if ( !target || ![keyPath isKindOfClass: [NSString class]] )
        return FALSE;
    
    return [_observedObject isEqual: target] && [_keyPath isEqualToString: keyPath];
}


#pragma mark Observation Management

- (void) dealloc {
    // Unregisters the self from observation if needed
    if ( self.observedObject && self.keyPath && [self.keyPath isKindOfClass: [NSString class]] )
        [self.observedObject removeObserver: self forKeyPath: self.keyPath];
}

@end

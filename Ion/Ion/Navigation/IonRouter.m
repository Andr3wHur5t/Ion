//
//  IonRouter.m
//  Ion
//
//  Created by Andrew Hurst on 10/5/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonRouter.h"

@interface IonRouter ()

/**
 * Map of all of our active components.
 */
@property (strong, nonatomic, readonly) NSMutableDictionary *componentMap;

@end

@implementation IonRouter

@synthesize componentMap = _componentMap;

#pragma mark Module Interface

- (BOOL) invokeLink:(IonLink *)link {
    IonModule *controllingModule;
    NSString *key;
    NSParameterAssert( link && [link isKindOfClass: [IonLink class]] );
    if ( !link || ![link isKindOfClass: [IonLink class]] )
        return FALSE;
    
    // Valid Key?
    key = [link.pathComponents firstObject];
    if ( !key || ![key isKindOfClass: [NSString class]] )
        return FALSE;
    
    // Do we have a assigned module?
    controllingModule = [self.componentMap objectForKey: key.uppercaseString];
    if ( !controllingModule || ![controllingModule isKindOfClass: [IonModule class]] )
        return FALSE;
    
    return [self metricsProxyInvocation: [controllingModule invokeLink: [link linkWithoutFirstComponent]]
                               withLink: link];
}

#pragma mark Component Management

- (NSMutableDictionary *)componentMap {
    if ( !_componentMap )
        _componentMap = [[NSMutableDictionary alloc] init];
    return _componentMap;
}


- (void) addComponent:(IonModule *)module forKey:(NSString *)key {
    NSParameterAssert( key && [key isKindOfClass: [NSString class]] );
    NSParameterAssert( module && [module isKindOfClass: [IonModule class]] );
    if ( !key || ![key isKindOfClass: [NSString class]] ||
        !module || ![module isKindOfClass: [IonModule class]])
        return;
    
    [self.componentMap setObject: module forKey: key.uppercaseString];
}

- (void) removeComponentForKey:(NSString *)key {
    NSParameterAssert( key && [key isKindOfClass: [NSString class]] );
    if ( !key || ![key isKindOfClass: [NSString class]] )
        return;
    
    [self.componentMap removeObjectForKey: key];
}

- (void) removeAllComponents {
    [self.componentMap removeAllObjects];
}

#pragma mark Metrics

- (BOOL) metricsProxyInvocation:(BOOL)invokedReturnValue withLink:(IonLink *)link {
    // Record Metrics if needed
//    NSLog(@"\nRequest %@ for link [%@]", invokedReturnValue ? @"completed" : @"FAILED", link );
    return invokedReturnValue;
}

@end

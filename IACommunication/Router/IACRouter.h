//
//  IACRouter.h
//  IACommunication
//
//  Created by Andrew Hurst on 10/7/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "IACModule.h"

/**
 * A concrete module class which allows you to route link invocations to other modules.
 */
@interface IACRouter : IACModule
#pragma mark Component Management
/**
 * Adds the inputted component using the specified name.
 * @param module - the component you want to add.
 * @param key - the name you want it under.
 * @warning If you name a module the same as one which is already set we will overwrite it.
 */
- (void) addComponent:(IACModule *)module forKey:(NSString *)key;

/**
 * Removes the component for the specified key.
 * @param key - the key for the object you want removed.
 */
- (void) removeComponentForKey:(NSString *)key;

/**
 * Removes all components.
 */
- (void) removeAllComponents;

/**
 * Gets, or constructs a sub router with the specified component name.
 * @param componentName - the name of the router component to get or contruct.
 */
- (IACRouter *)subRouterWithName:(NSString *)componentName;

#pragma mark Metrics Configuration

/**
 * States if metrics are recorded to SimpleAnalytics
 */
@property (assign, nonatomic, readwrite) BOOL recordToAnalytics;

#pragma mark Endpoint actions
/**
 * Adds the target action set to be invoked when the module is invoked with no endpoint.
 * @param target - the target to add the action for.
 * @param action - the action to be executed when the key is invoked.
 */
- (void) addTarget:(id)target addAction:(SEL) action;

/**
 * Removes the target action set from this endpoint
 * @param target - the target to remove the action for.
 * @param action - the action to remove the target for.
 */
- (void) removeTarget:(id)target addAction:(SEL) action;

/**
 * Removes all target action sets for this endpoint.
 */
- (void) removeAllEndpoints;

@end

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

#pragma mark Metrics Configuration

/**
 * States if metrics are recorded to SimpleAnalytics
 */
@property (assign, nonatomic, readwrite) BOOL recordToAnalytics;

@end

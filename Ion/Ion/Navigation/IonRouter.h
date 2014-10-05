//
//  IonRouter.h
//  Ion
//
//  Created by Andrew Hurst on 10/5/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonModule.h"

/**
 * A concrete module class which allows you to route link invocations to other modules.
 */
@interface IonRouter : IonModule
#pragma mark Component Management
/**
 * Adds the inputted component using the specified name.
 * @param module - the component you want to add.
 * @param key - the name you want it under.
 * @warning If you name a module the same as one which is already set we will overwrite it.
 */
- (void) addComponent:(IonModule *)module forKey:(NSString *)key;

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

@end

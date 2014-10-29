//
//  IonApplication+ControllerManager.h
//  IonCore
//
//  Created by Andrew Hurst on 10/25/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <IonCore/IonApplication.h>

@interface IonApplication (ControllerManager)
/**
 * Registers the view controler class with the specified path so it will be constructed when it is invoked.
 * @param viewClass - the class used to construct the view controller when needed.
 * @param path - the path to register the controller on.
 */
- (void) addViewController:(Class)viewClass toRouterPath:(NSArray *)path;

#pragma mark Controller Cacheing
/**
 * Gets, or constructs the controller for the specified name if it has a registered class to construc from.
 * @param name - the name of the controller to get, or construct.
 */
- (UIViewController *)controllerForName:(NSString *)name;

/**
 * Gets the controller name from the inputted components.
 * @param components - the array of components to get the controller name from.
 */
+ (NSString *)controllerNameFromComponents:(NSArray *)components;


@end

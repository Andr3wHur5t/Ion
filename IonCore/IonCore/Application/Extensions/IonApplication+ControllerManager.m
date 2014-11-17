//
//  IonApplication+ControllerManager.m
//  IonCore
//
//  Created by Andrew Hurst on 10/25/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "IonApplication+ControllerManager.h"
#import <IonCore/IonCore.h>
#import <objc/runtime.h>

@interface IonApplication (ControllerManagerPrivate)

#pragma mark Automatic Routing
/*!
 @brief  Gets the Selector string to open the controller with the inputted
 Identifier.

 @param name The Identifier of the controller that should be opened with the
 selector.

 @return The string representing the selector that should be open the
 controller.
 */
+ (NSString *)selectorStringToOpenControllerWithLinkUsingName:(NSString *)name;

/*!
 @brief Gets the imp used to open the controller with the specified name via a
 link.

 @param name The identifier of the controller that should be opened by the
 method.

 @return An IMP block that can be added to the IonApplication class.
 */
+ (IMP)impToOpenControllerWithLinkUsingName:(NSString *)name;

#pragma mark Controller Caching
/*!
 @brief  Dictionary of constructed controllers.

 @discussion Controllers in this dictionary should be considered to be active.

 @return Dictionary of controllers.
 */
- (NSMutableDictionary *)activeControllers;

/*!
 @brief  Dictionary of classes registered to controllers by an identifier.

 @discussion This is intended to be used for controller construction.

 @return Dictionary of classes.
 */
- (NSMutableDictionary *)registeredControllerClasses;

/*!
 @brief Dictionary of routers registered to a controller by identifier.

 @return Dictionary of routers.
 */
- (NSMutableDictionary *)registeredControllerRouters;

@end

@implementation IonApplication (ControllerManager)

#pragma mark Automatic Registration

- (void)addViewController:(Class)viewClass toRouterPath:(NSArray *)path {
  SEL openControllerSelector;
  NSString *compositeName;
  IACRouter *lastRouter;
  NSParameterAssert([viewClass isSubclassOfClass:[UIViewController class]]);
  NSParameterAssert([path isKindOfClass:[NSArray class]]);
  if (![viewClass isSubclassOfClass:[UIViewController class]] ||
      ![path isKindOfClass:[NSArray class]])
    return;

  // Get a name we can register the controller under
  compositeName = [[self class] controllerNameFromComponents:path];

  // Set the base router so we can perform our search
  lastRouter = self.router;
  for (NSString *component in path)
    // Get our router
    lastRouter = [lastRouter subRouterWithName:component];

  // Register class to be constructed for name
  [self registerControllerClass:viewClass withIdentifier:compositeName];

  // Register the router it should use
  [self registerRouter:lastRouter withIdentifier:compositeName];

  // Get the selector that will be used to open the controller
  openControllerSelector = NSSelectorFromString([[self class]
      selectorStringToOpenControllerWithLinkUsingName:compositeName]);

  // Add A method to the application which will open the controller using our
  // selector
  class_addMethod(
      [self class], openControllerSelector,
      [[self class] impToOpenControllerWithLinkUsingName:compositeName],
      "v@:@");

  // Add The controller to be opened on access of the router
  [lastRouter addTarget:self addAction:openControllerSelector];
}

#pragma mark Manual Registration

- (void)registerControllerClass:(Class)viewClass
                 withIdentifier:(NSString *)identity {
  NSParameterAssert([viewClass isSubclassOfClass:[UIViewController class]]);
  NSParameterAssert([identity isKindOfClass:[NSString class]]);
  if (![viewClass isSubclassOfClass:[UIViewController class]] ||
      ![identity isKindOfClass:[NSString class]])
    return;

  // Register class to be constructed for name
  [[self registeredControllerClasses] setObject:viewClass
                              forKeyedSubscript:identity];
}

- (void)registerRouter:(IACRouter *)router withIdentifier:(NSString *)identity {
  NSParameterAssert([router isKindOfClass:[IACRouter class]]);
  NSParameterAssert([identity isKindOfClass:[NSString class]]);
  if (![router isKindOfClass:[IACRouter class]] ||
      ![identity isKindOfClass:[NSString class]])
    return;

  // Register the router for the constructed class
  [[self registeredControllerRouters] setObject:router
                              forKeyedSubscript:identity];
}

#pragma mark Automatic Routing

+ (IMP)impToOpenControllerWithLinkUsingName:(NSString *)name {
  __block NSString *controllerName = name;
  return imp_implementationWithBlock(^(IonApplication *_self, IACLink *link) {
      // Gets the controller for the specified name, and opens it with the
      // specified link.
      [_self openViewController:[_self controllerForName:controllerName]
                       withLink:link];
  });
}

#pragma mark Controller Caching

- (UIViewController *)controllerForName:(NSString *)name {
  UIViewController *controller;
  Class controllerClass;
  NSParameterAssert([name isKindOfClass:[NSString class]]);
  if (![name isKindOfClass:[NSString class]])
    return NULL;

  controller = [[self activeControllers] objectForKey:name];
  if (!controller) {
    // Get the class to construct the controller from
    controllerClass = [[self registeredControllerClasses] objectForKey:name];
    if (!controllerClass)
      return NULL;

    // Construct the controller from its registered class
    controller = [[controllerClass alloc] init];

    // Configure it
    controller.router = [[self registeredControllerRouters] objectForKey:name];

    // Cache it
    [[self activeControllers] setObject:controller forKeyedSubscript:name];
  }
  return controller;
}

#pragma mark String Utilities

+ (NSString *)controllerNameFromComponents:(NSArray *)components {
  NSString *compositeName;
  NSParameterAssert([components isKindOfClass:[NSArray class]]);
  if (![components isKindOfClass:[NSArray class]])
    return NULL;

  for (NSString *component in components)
    compositeName = [NSString
        stringWithFormat:@"%@%@", compositeName ? compositeName : @"",
                         component.capitalizedString];

  return compositeName;
}

+ (NSString *)selectorStringToOpenControllerWithLinkUsingName:(NSString *)name {
  // Returns the name we will use to open the link
  return [NSString stringWithFormat:@"open%@WithLink:", name];
}

#pragma mark Cache Dictionarys

- (NSMutableDictionary *)activeControllers {
  NSMutableDictionary *activeControllers =
      [self.categoryVariables objectForKey:@"activeControllers"];
  if (!activeControllers) {
    activeControllers = [[NSMutableDictionary alloc] init];
    [self.categoryVariables setObject:activeControllers
                               forKey:@"activeControllers"];
  }
  return activeControllers;
}

- (NSMutableDictionary *)registeredControllerClasses {
  NSMutableDictionary *controllerClasses =
      [self.categoryVariables objectForKey:@"controllerClasses"];
  if (!controllerClasses) {
    controllerClasses = [[NSMutableDictionary alloc] init];
    [self.categoryVariables setObject:controllerClasses
                               forKey:@"controllerClasses"];
  }
  return controllerClasses;
}

- (NSMutableDictionary *)registeredControllerRouters {
  NSMutableDictionary *controllerRouters =
      [self.categoryVariables objectForKey:@"controllerRouters"];
  if (!controllerRouters) {
    controllerRouters = [[NSMutableDictionary alloc] init];
    [self.categoryVariables setObject:controllerRouters
                               forKey:@"controllerRouters"];
  }
  return controllerRouters;
}

@end

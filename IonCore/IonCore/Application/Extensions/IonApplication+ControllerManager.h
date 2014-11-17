//
//  IonApplication+ControllerManager.h
//  IonCore
//
//  Created by Andrew Hurst on 10/25/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <IonCore/IonApplication.h>

@class IACRouter;

@interface IonApplication (ControllerManager)

/*!
 @brief Registers a controller class to be invokable with a link with the
 specified path.

 @discussion This automaticly registers the controller class at the specified
 path. this will generate, or get routers for the specified path, and register
 for it to be used by the controller when it is constructed. It also adds a
 method to the application alowing the controller to be invoked and transisioned
 to via a URL.

 @param viewClass The class of the controller to construct.
 @param path      The path to register the controller for.
 */
- (void)addViewController:(Class)viewClass toRouterPath:(NSArray *)path;

#pragma mark Controller Cacheing
/*!
 @brief Gets, or contructs the controller with the sepcified identity.

 @discussion This is a lazyly constructing method for controllers if the
 controller is not constructed this will construct it using the identifiers
 registered class, and router. Once constructed it will set the views router
 enabiling it to be hooked into the route tree afterwards caching the
 constructed controller to the controller cache.

 @param name The identity of the controller to get, or construct.

 @return the controller with the specified identity, or NULL if invald.
 */
- (UIViewController *)controllerForName:(NSString *)name;

/*!
 @brief Gets a composite name from the inputted components

 @discussion This is used to composite an array of values into camal case to be
 used as a controller identifier. It is case insensitive.

 @param components The set of components to generate the composite name from.

 @return a string composited from the inputted components.
 */
+ (NSString *)controllerNameFromComponents:(NSArray *)components;

#pragma mark Manual Controller Additions
/*!
 @brief Registers a router to be used for the controller with the specified
 identity.

 @discussion This will be set to the controller when it is constructed by its
 identifier. If it is set post construction it will not be set.

 @param router   The router for the controller to use.
 @param identity The identity of the controller to add the router to.
 */
- (void)registerRouter:(IACRouter *)router withIdentifier:(NSString *)identity;

/*!
 @brief Registers the inputted class to be constructed for when the identifier
 is accessed.

 @param viewClass The class to construct when the controller is requested.
 @param identity  The identifier to register the class with.
 */
- (void)registerControllerClass:(Class)viewClass
                 withIdentifier:(NSString *)identity;

@end

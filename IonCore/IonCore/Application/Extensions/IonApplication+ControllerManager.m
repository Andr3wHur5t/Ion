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
/**
 * Gets the selector string which will be used to open the controller with the specified name.
 * @param name - the name of the controller to open.
 */
+ (NSString *) selectorStringToOpenControllerWithLinkUsingName:(NSString *)name;

/**
 * Gets the imp used to open the controller with the specified name via a link.
 * @param name - the name of the controller to open.
 */
+ (IMP) impToOpenControllerWithLinkUsingName:(NSString *)name;

#pragma mark Controller Caching
/**
 * A dictionary of already constructed controllers.
 */
- (NSMutableDictionary *)activeControllers;

/**
 * A dictionary of classes to construct from.
 */
- (NSMutableDictionary *)registeredControllerClasses;

/**
 * A dictionary of routers registered to a controller by name.
 */
- (NSMutableDictionary *)registeredControllerRouters;

@end

@implementation IonApplication (ControllerManager)

- (void) addViewController:(Class)viewClass toRouterPath:(NSArray *)path {
    SEL openControllerSelector;
    NSString *compositeName;
    IACRouter *lastRouter;
    NSParameterAssert( [viewClass isSubclassOfClass: [UIViewController class]] );
    NSParameterAssert( [path isKindOfClass: [NSArray class]] );
    if ( ![viewClass isSubclassOfClass: [UIViewController class]] || ![path isKindOfClass:[NSArray class]] )
        return;
    
    // Get a name we can register the controller under
    compositeName = [[self class] controllerNameFromComponents: path];
    
    // Set the base router so we can perform our search
    lastRouter = self.router;
    for ( NSString *component in path )
        // Get our router
        lastRouter = [lastRouter subRouterWithName: component];
    
    // Register class to be constructed for name
    [[self registeredControllerClasses] setObject: viewClass forKeyedSubscript: compositeName];

    // Register the router it should use
    [[self registeredControllerRouters] setObject: lastRouter forKeyedSubscript: compositeName];
    
    
    // Get the selector that will be used to open the controller
    openControllerSelector = NSSelectorFromString( [[self class] selectorStringToOpenControllerWithLinkUsingName: compositeName] );
    
    // Add A method to the application which will open the controller using our selector
    class_addMethod( [self class],
                    openControllerSelector,
                    [[self class] impToOpenControllerWithLinkUsingName: compositeName],
                    "v@:@" );
    
    // Add The controller to be opened on access of the router
    [lastRouter addTarget: self
                addAction: openControllerSelector];
}

#pragma mark Automatic Routing

+ (NSString *) selectorStringToOpenControllerWithLinkUsingName:(NSString *)name {
    // Returns the name we will use to open the link
    return [NSString stringWithFormat: @"open%@WithLink:", name];
}

+ (IMP) impToOpenControllerWithLinkUsingName:(NSString *)name {
    __block NSString *controllerName = name;
    return imp_implementationWithBlock( ^(IonApplication *_self, IACLink *link){
        // Gets the controller for the specified name, and opens it with the specified link.
        [_self openViewController: [_self controllerForName: controllerName]
                         withLink: link];
    });
}

#pragma mark Controller Caching

- (UIViewController *)controllerForName:(NSString *)name {
    UIViewController *controller;
    Class controllerClass;
    NSParameterAssert( [name isKindOfClass: [NSString class]] );
    if ( ![name isKindOfClass: [NSString class]] )
        return NULL;
    
    controller = [[self activeControllers] objectForKey: name];
    if ( !controller ) {
        // Get the class to construct the controller from
        controllerClass = [[self registeredControllerClasses] objectForKey: name];
        if ( !controllerClass )
            return NULL;
        
        // Construct the controller from its registered class
        controller = [[controllerClass alloc] init];
        
        // Configure it
        controller.router = [[self registeredControllerRouters] objectForKey: name];
        
        // Cache it
        [[self activeControllers] setObject: controller forKeyedSubscript: name];
    }
    return controller;
}

+ (NSString *)controllerNameFromComponents:(NSArray *)components {
    NSString *compositeName;
    NSParameterAssert( [component isKindOfClass: [NSArray components]] );
    if ( ![components isKindOfClass: [NSArray class]] )
        return NULL;
    
    for ( NSString *component in components )
        compositeName = [NSString stringWithFormat: @"%@%@", compositeName ? compositeName : @"", component.capitalizedString];
    
    return compositeName;
}

#pragma mark Cache Dictionarys

- (NSMutableDictionary *)activeControllers {
    NSMutableDictionary *activeControllers = [self.categoryVariables objectForKey: @"activeControllers"];
    if ( !activeControllers ) {
        activeControllers = [[NSMutableDictionary alloc] init];
        [self.categoryVariables setObject: activeControllers forKey: @"activeControllers"];
    }
    return activeControllers;
}

- (NSMutableDictionary *)registeredControllerClasses {
    NSMutableDictionary *controllerClasses = [self.categoryVariables objectForKey: @"controllerClasses"];
    if ( !controllerClasses ) {
        controllerClasses = [[NSMutableDictionary alloc] init];
        [self.categoryVariables setObject: controllerClasses forKey: @"controllerClasses"];
    }
    return controllerClasses;
}

- (NSMutableDictionary *)registeredControllerRouters {
    NSMutableDictionary *controllerRouters = [self.categoryVariables objectForKey: @"controllerRouters"];
    if ( !controllerRouters ) {
        controllerRouters = [[NSMutableDictionary alloc] init];
        [self.categoryVariables setObject: controllerRouters forKey: @"controllerRouters"];
    }
    return controllerRouters;
}


@end

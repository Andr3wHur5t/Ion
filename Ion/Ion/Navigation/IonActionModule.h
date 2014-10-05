//
//  IonActionModule.h
//  Ion
//
//  Created by Andrew Hurst on 10/5/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonModule.h"

/**
 * A concrete module class which allows you to attach endpoints to actions.
 */
@interface IonActionModule : IonModule
#pragma mark Constructors
/**
 * Constructs with the inputted target object.
 * @param target - the object which we will invoke all registered module actions.
 */
- (instancetype) initWithTarget:(id) target;

/**
 * Constructs with the inputted target object.
 * @param target - the object which we will invoke all registered module actions.
 */
+ (instancetype) moduleWithTarget:(id) target;

#pragma mark Configuration

/**
 * The object which we will invoke all registered module actions on.
 */
@property (weak, nonatomic, readonly) id target;

/**
 * States if the module will log invocations.
 */
@property (assign, nonatomic, readwrite) BOOL debugLinkInvocations;

#pragma mark Action Management
/**
 * Adds the action for the specified endpoint.
 * @param action - the action to be executed when the key is invoked.
 * @param endpoint - the endpoint to add the action for.
 */
- (void) addAction:(SEL) action toEndpoint:(NSString *)endpoint;

/**
 * Removes all actions associated with the specified endpoint.
 * @param endpoint - the endpoint to remove the actions for.
 */
- (void) removeActionsForEndpoint:(NSString *)endpoint;

/**
 * Removes all endpoints.
 */
- (void) removeAllEndpoints;

@end

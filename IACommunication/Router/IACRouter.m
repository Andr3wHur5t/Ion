//
//  IACRouter.m
//  IACommunication
//
//  Created by Andrew Hurst on 10/7/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "IACRouter.h"
#import "IACLink.h"
#import "IACLinkEvent.h"
#import <FOUtilities/FOUtilities.h>

@interface IACRouter ()

/**
 * Map of all of our active components.
 */
@property(strong, nonatomic, readonly) NSMutableDictionary *componentMap;

/**
 * List of this endpoints target actions
 */
@property(strong, nonatomic, readonly)
    FOTargetActionList *endpointTargetActions;

@end

@implementation IACRouter

@synthesize componentMap = _componentMap;
@synthesize endpointTargetActions = _endpointTargetActions;

#pragma mark Module Interface

- (BOOL)invokeLink:(IACLink *)link {
  IACModule *endpoint;
  NSString *key;
  NSParameterAssert(link && [link isKindOfClass:[IACLink class]]);
  if (!link || ![link isKindOfClass:[IACLink class]]) return FALSE;

  // Valid Key?
  key = [link.pathComponents firstObject];
  if (!key || ![key isKindOfClass:[NSString class]]) {
    // We are the endpoint
    __block IACLink *sLink = link;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.endpointTargetActions invokeActionSetsInGroup:@"all"
                                                 withObject:sLink];
    });
    return TRUE;
  }

  // Do we have a assigned module?
  endpoint = [self.componentMap objectForKey:key.uppercaseString];
  if (![endpoint isKindOfClass:[IACModule class]]) {
    NSLog(@"Failed To invoke: \"%@\" no endpoint found.", link);
    return FALSE;
  }
  // Proxy our results through our metrics system so we can record if needed.
  return [self
      metricsProxyInvocation:[endpoint
                                 invokeLink:[link linkWithoutFirstComponent]]
                    withLink:link];
}

#pragma mark Component Management

- (NSMutableDictionary *)componentMap {
  if (!_componentMap) _componentMap = [[NSMutableDictionary alloc] init];
  return _componentMap;
}

- (void)addComponent:(IACModule *)module forKey:(NSString *)key {
  NSParameterAssert(key && [key isKindOfClass:[NSString class]]);
  NSParameterAssert(module && [module isKindOfClass:[IACModule class]]);
  if (!key || ![key isKindOfClass:[NSString class]] || !module ||
      ![module isKindOfClass:[IACModule class]])
    return;

  [self.componentMap setObject:module forKey:key.uppercaseString];
}

- (void)removeComponentForKey:(NSString *)key {
  NSParameterAssert(key && [key isKindOfClass:[NSString class]]);
  if (!key || ![key isKindOfClass:[NSString class]]) return;

  [self.componentMap removeObjectForKey:key];
}

- (void)removeAllComponents {
  [self.componentMap removeAllObjects];
}

- (IACRouter *)subRouterWithName:(NSString *)componentName {
  IACRouter *subRouter;
  NSParameterAssert([componentName isKindOfClass:[NSString class]]);
  if (![componentName isKindOfClass:[NSString class]]) return NULL;

  subRouter = [self.componentMap objectForKey:componentName.uppercaseString];
  if (!subRouter) {
    subRouter = [[IACRouter alloc] init];
    [self addComponent:subRouter forKey:componentName];
  }
  return subRouter;
}

#pragma mark Metrics

- (BOOL)metricsProxyInvocation:(BOOL)invokedReturnValue
                      withLink:(IACLink *)link {
  if (self.recordToAnalytics)  // Record Metrics
    [[[IACLinkEvent alloc] initWithLink:link] record];
  return invokedReturnValue;
}

#pragma mark Endpoint actions

- (FOTargetActionList *)endpointTargetActions {
  if (!_endpointTargetActions)
    _endpointTargetActions = [[FOTargetActionList alloc] init];
  return _endpointTargetActions;
}
- (void)addTarget:(id)target addAction:(SEL)action {
  __block id sTarget = target;
  __block SEL sAction = action;
  dispatch_async(dispatch_get_main_queue(), ^{
      [self.endpointTargetActions addTarget:sTarget
                                  andAction:sAction
                                    toGroup:@"all"];
  });
}

- (void)removeTarget:(id)target addAction:(SEL)action {
  __block id sTarget = target;
  __block SEL sAction = action;
  dispatch_async(dispatch_get_main_queue(), ^{
      [self.endpointTargetActions removeTarget:sTarget
                                     andAction:sAction
                                     fromGroup:@"all"];
  });
}

- (void)removeAllEndpoints {
  dispatch_async(dispatch_get_main_queue(),
                 ^{ [self.endpointTargetActions removeAllGroups]; });
}

@end

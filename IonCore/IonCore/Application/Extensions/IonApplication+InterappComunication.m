//
//  IonApplication+InterappComunication.m
//  IonCore
//
//  Created by Andrew Hurst on 10/14/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "IonApplication+InterappComunication.h"
#import <IonCore/IACRouter.h>
#import <IonCore/IACLink.h>

@implementation IonApplication (InterappComunication)

#pragma mark Router

- (IACRouter *)router {
  IACRouter *_router =
      [self.categoryVariables objectForKey:@"applicationIACRouter"];
  if (!_router) {
    _router = [[IACRouter alloc] init];
    _router.recordToAnalytics = TRUE;
    [self.categoryVariables setObject:_router forKey:@"applicationIACRouter"];
  }
  return _router;
}

#pragma mark Controller Utilties

- (void)openViewController:(UIViewController *)controller
                  withLink:(IACLink *)link {
  __block UIViewController *newController, *oldController;

  // Get Controllers
  newController = controller;
  oldController = self.window.rootViewController;

  if (![controller isKindOfClass:[UIViewController class]]) return;

  NSNumber *duration;
  UIViewAnimationOptions transision;

  // Check if the controller is our current controller
  if ([controller isEqual:self.window.rootViewController]) {
    // Report the link
    [newController willOpenWithLink:link];
    [newController didOpenWithLink:link];

    // Don't continue, we're already on the view controller.
    return;
  }

  // Get Parameters
  duration = [link.parameters numberForKey:@"duration" defaultValue:@0.5];
  transision =
      [[link.parameters stringForKey:@"transisionType"] toTransisionType];

  // Inform the controllers that we will change with link
  if (!([newController willOpenWithLink:link] &&
        [oldController willCloseWithLink:link]))
    return;

  // Animate to the new controller
  [UIView transitionWithView:self.window
      duration:[duration doubleValue]
      options:transision
      animations:^{
          if ([newController isKindOfClass:[UIViewController class]])
            self.window.rootViewController = newController;
          else
            NSLog(@"Failed to transision controler is a '%@'",
                  NSStringFromClass([newController class]));
      }
      completion:^(BOOL finished) {
          // Inform the controllers that we did change with link
          [newController didOpenWithLink:link];
          [oldController didCloseWithLink:link];
      }];
}

@end

@implementation UIViewController (IACLinkInvokation)
#pragma mark Router

+ (BOOL)automaticallyNotifiesObserversOfRouter {
  return FALSE;
}

- (void)setRouter:(IACRouter *)router {
  [self willChangeValueForKey:@"router"];
  if (router)
    [self.categoryVariables setObject:router forKeyedSubscript:@"router"];
  else
    [self.categoryVariables removeObjectForKey:@"router"];
  [self didChangeValueForKey:@"router"];
}

- (IACRouter *)router {
  return [self.categoryVariables objectForKey:@"router"];
}

#pragma mark Link Methods

- (BOOL)willOpenWithLink:(IACLink *)link {
  return true;
}

- (BOOL)willCloseWithLink:(IACLink *)link {
  return true;
}

- (void)didOpenWithLink:(IACLink *)link {
}

- (void)didCloseWithLink:(IACLink *)link {
}

@end

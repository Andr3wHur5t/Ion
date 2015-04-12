//
//  IonApplication+RapidSplash.m
//  Ion
//
//  Created by Andrew Hurst on 9/8/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonApplication+RapidSplash.h"
#import "IonApplication+plistGetters.h"
#import "IonApplication+Metrics.h"

@implementation IonApplication (RapidSplash)
#pragma mark rapidStartManager
/**
 * Sets the rapid start manager.
 */
- (void)setRapidStartManager:(IonRapidStartManager *)rapidStartManager {
  [self willChangeValueForKey:@"rapidStartManager"];
  if (rapidStartManager)
    [self.categoryVariables setObject:rapidStartManager
                               forKey:@"rapidStartManager"];
  else
    [self.categoryVariables removeObjectForKey:@"rapidStartManager"];
  [self didChangeValueForKey:@"rapidStartManager"];
}

/**
 * Gets, or constructs the rapid start manager.
 * @return {IonRapidStartManager*}
 */
- (IonRapidStartManager *)rapidStartManager {
  IonRapidStartManager *_manager =
      [self.categoryVariables objectForKey:@"rapidStartManager"];
  if (!_manager) {
    _manager = [[IonRapidStartManager alloc] initWithDelegate:self];
    self.rapidStartManager = _manager;
  }
  return _manager;
}

#pragma mark Delegate Implementation
/**
 * The rapid splash view that will be used when the application has already been
 * opened in the system once before.
 * @return {IonRapidStartViewController}
 */
- (IonRapidStartViewController *)rapidSplash {
  return [[IonRapidStartViewController alloc] init];
}

/**
 * The rapid splash view that will be used when the application has not been
 * opened in the system once before.
 * You should return a on boarding controller here.
 * @return {IonRapidStartViewController}
 */
- (IonRapidStartViewController *)onBoardingRapidSplash {
  // We only use on of these so we don't need a copy
  return [self rapidSplash];
}

/**
 * Gets the on boarding screen version string from the info.plist file.
 * @return {NSString*}
 */
- (NSString *)currentOnBoardingScreenVersion {
  return [[self class] currentOnBoardingVersion];
}

/**
 * Gets called after the rapid splash session has completed an can safely be
 * freed from memory.
 */
- (void)freeRapidSplashManager {
  self.rapidStartManager = NULL;
}

#pragma mark Application Implementation
/**
 * Calls all the resource intensive processes after the rapid splash view has
 * been rendered.
 */
- (void)postDisplay {
  // Record Metrics
  [self markSplashDisplay];

  // Log Metrics
  [self logStartupMetrics];

  // Call the custom view dependent setup here
  [self configureFirstRealViewController:^(UIViewController *frvc) {
    // Hand off control from the rapid start view to the next FRVC
    [self.rapidStartManager.viewController
        prepareToDispatchWithNewController:frvc];

    // Call the custom setup function
    [self setupApplication];
  }];
}

@end

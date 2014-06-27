//
//  AppDelegate.m
//  Ion Visual Test
//
//  Created by Andrew Hurst on 6/26/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
            

@end

@implementation AppDelegate

/**
 * We set our propriatary manifest here
 * @returns {managerManifest}
 */
- (bool) loadManagerManifest {
    NSLog(@"Load Manifest called");
    return true;
}

/**
 * This is where we set our rapid splash configuration
 * @returns {rapidSplashConfiguration}
 */
- (IonRapidStartupViewConfiguration) loadRapidStartSplashConfiguration {
    NSLog(@"Load Rapid Splash called");
    return (IonRapidStartupViewConfiguration){true};
}

/**
 * This is where we initiliza all non visual elements of our application.
 * @returns {void}
 */
- (void) setupApplication {
    NSLog(@"externial application startup called");
}

/**
 * This is where we configure our first real view controller.
 * @returns {void}
 */
- (void) configureFirstRealViewController:(void (^)())finished {
    NSLog(@"externial configuring first real view controller");
    
    if( finished )
        finished();
}



@end

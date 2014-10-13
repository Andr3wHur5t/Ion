//
//  AppDelegate.m
//  Ion Visual Test
//
//  Created by Andrew Hurst on 6/26/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "AppDelegate.h"

#import "IonVisualTestViewController.h"

@interface AppDelegate ()
            

@end

@implementation AppDelegate

#pragma mark Init Hooks

- (void) setupApplication {
    NSLog(@"externial application startup called");
}

#pragma mark Controller Init

/**
 * This configures the first real view controller.
 * @peram { ^(UIViewController* frvc) } frvc is the "First Real View Conroller" to be presented.
 
 */
- (void) configureFirstRealViewController:(void(^)( IonViewController* frvc )) finished {
    // configure the default first root view controller here.
    IonVisualTestViewController* vc = [[IonVisualTestViewController alloc] init];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleLightContent];
    [vc addDelegateToManager: [[IonStatusBarBehaviorMotionGestureDisplay alloc] init]];
    //sc.manifestWillPersist = FALSE;
    //[sc deleteWithCompletion:^(NSError *error) {
    //    NSLog(@"Deleted Cache!");
    //}];
    
    //[self asyncABGMapTest];
    
    /**
     * This is to debug the theme system.
     */
    //[self runThemeTests];
   
    // Test transisions between themes
    //[self testTransision: NULL];
    
//    IACLink *link = [IACLink linkWithURLString: @"Hello" andReason: @"Test"];
    
    // Call Based off of finishing Image loading
    [self performBlock:^{
        if (finished)
            finished(vc);
    } afterDelay: 0.5];
}

/**
 * This is the rapid splash view that will be used when the application has already been opened in the system once before.
 * *subclassed for customization*
 * @returns {IonRapidStartViewController}
 */
- (IonRapidStartViewController*) rapidSplash {
    IonRapidStartViewController* vc = [[IonRapidStartViewController alloc] init];
    
    vc.view.backgroundColor = [UIColor magentaColor];
    
    return vc;
}

/**
 * This is the rapid splash view that will be used when the application has not been opened in the system once before.
 * You should return a on boarding controller here.
 * *subclassed for customization*
 * @returns {IonRapidStartViewController}
 */
- (IonRapidStartViewController*) onBoardingRapidSplash {
    IonRapidStartViewController* vc = [[IonRapidStartViewController alloc] init];
    
    vc.view.backgroundColor = [UIColor yellowColor];
    
    return vc;
}


#pragma mark Configuration

/**
 * We set our propriatary manifest here
 * @returns {managerManifest}
 */
- (bool) loadManagerManifest {
    NSLog(@"Load Manifest called");
    return true;
}


/**
 * This gets the on boarding screen version string.
 * @returns {NSString*}
 */
- (NSString*) currentOnBoardingScreenVersion {
    return NULL;
}

/**
 * This states if we use the demo window which displays touch points or not.
 * @returns {bool}
 */
- (bool) isInDemoMode {
    return false;
}


@end

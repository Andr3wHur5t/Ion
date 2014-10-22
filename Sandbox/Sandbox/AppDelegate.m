//
//  AppDelegate.m
//  Sandbox
//
//  Created by Andrew Hurst on 10/19/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "AppDelegate.h"
#import "SPAppTheme.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize statusBarBehavior = _statusBarBehavior;
@synthesize mainViewController = _mainViewController;

#pragma mark Application Setup

- (void) setupApplication {
    // This gets called after the first real view controller is presented.
    // You should initialize your networked APIs here.
    NSLog( @"Setup");
}

- (void) configureFirstRealViewController:(void (^)(IonViewController *))finished {
    // This is where we construct our first real application view controller or FRVC for short.
    // It gets called asynchronously to so we don't block the main thread while the splash, or on boarding screen is presented.
    // The application won't present the FRVC until we invoke this block.
    
    // Ensure the view is loading
    [self.mainViewController view];
    
    // This should be based of when the view finished its' presentation setup, need to figure out a
    // way to do this from a background queue
    [self performBlock:^{
        finished( self.mainViewController );
    } afterDelay: 0.25];
    
}

- (UIWindow *)constructWindow {
    // This gets called when we need to construct the applications window.
    // If you want to use a custom window construct, and return it here.
    // To take advantage of Ions' demo window you need to return [super constructWindow].
    return [super constructWindow];
}

- (void) configureStatusBar {
    // This is where you can configure the staus bar if needed.
    [[UIApplication sharedApplication] setStatusBarHidden: YES];
    [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleLightContent];
}

- (NSDictionary *)defaultTheme {
    // This is the theme the application will use by default.
    // It invoked on application startup before rapid splash is presented you should use hard coded values when possible.
    // For security reasons when in production you should use a hard coded theme, not one loaded from the file system.
    return [SPAppTheme theme]; // Themes normally get reasonably big its a good idea to keep it in its own file.
}

- (BOOL) application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    NSLog( @"Open With URL: \"%@\"", url );
    
    return TRUE;
}

#pragma mark Status Bar

- (IonStatusBarBehaviorMotionGestureDisplay *)statusBarBehavior {
    if ( !_statusBarBehavior )
        _statusBarBehavior = [[IonStatusBarBehaviorMotionGestureDisplay alloc] init];
    return _statusBarBehavior;
}

#pragma mark Controllers

- (MainViewController *)mainViewController {
    if ( !_mainViewController ) {
        _mainViewController = [[MainViewController alloc] init];

        // Setup Status Bar Behavior with view.
        [_mainViewController addDelegateToManager: self.statusBarBehavior];
    }
    return _mainViewController;
}

@end

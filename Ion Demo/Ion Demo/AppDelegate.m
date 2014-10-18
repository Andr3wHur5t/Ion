//
//  AppDelegate.m
//  Ion Demo
//
//  Created by Andrew Hurst on 10/8/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "AppTheme.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

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
    finished( [[MainViewController alloc] init] );
}

- (UIWindow *)constructWindow {
    // This gets called when we need to construct the applications window.
    // If you want to use a custom window construct, and return it here.
    // To take advantage of Ions' demo window you need to return [super constructWindow].
    NSLog( @"Frame %@",  NSStringFromCGRect([[UIScreen mainScreen] bounds]) );
    return [[UIWindow alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
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
    return [AppTheme theme]; // Themes normally get reasonably big its a good idea to keep it in its own file.
}

@end

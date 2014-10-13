//
//  IonApplication.m
//  Ion
//
//  Created by Andrew Hurst on 6/26/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//


// Core
#import "IonApplication.h"
#import <IonData/IonData.h>

// Rapid Start
#import "IonRapidStartManager.h"

// Window Implmentation
#import "UIWindow+IonWindow.h"
#import "IonDemoUIWindow.h"

// Application Extensions
#import "IonApplication+StatusBar.h"
#import "IonApplication+plistGetters.h"
#import "IonApplication+Metrics.h"
#import "IonApplication+RapidSplash.h"
#import "IonApplication+Keyboard.h"

#import "IACLink.h"

@implementation IonApplication

@synthesize window = _window;

#pragma mark Constructors

- (instancetype)init {
    self = [super init];
    if (self) {
        // Record Metrics
        [self markStartUpInit];
        
        // Start receiving keyboard frame updates
        [self startKeyboardObservation];
        
    }
    return self;
}

- (void) dealloc {
    // Stop reciveing keyboard frame updates.
    [self stopKeyboardObservation];
}

#pragma mark Window

- (UIWindow *)window {
    if ( !_window ) {
        // Use the correct type of window for our specified mode.
        _window = [self constructWindow];
        
        // TODO: currentlly this is proxied through a UIWindow catagory, insted we should do this via our UIView catagory
        _window.systemTheme = [[IonTheme alloc] initWithConfiguration: [self defaultTheme]];
    }
    return _window;
}

#pragma mark customization points

- (UIWindow *)constructWindow {
    UIWindow* window;
    // Use the correct type of window for our specified mode.
    if ( ![[self class] isInDemoMode] )
        window = [[UIWindow alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
    else
        window = [[IonDemoUIWindow alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
    return window;
}

- (void) configureFirstRealViewController:( void(^)( IonViewController *frvc ) ) finished {
    NSAssert( TRUE, @"IonApplication - (void)configureFirstRealViewController: was not overloaded!" );
}

- (void) setupApplication {
    NSAssert( TRUE, @"IonApplication - (void)setupApplication; was not overloaded!" );
}

- (void) configureStatusBar {
    NSAssert( TRUE, @"IonApplication - (void)configureStatusBar; was not overloaded!" );
}

- (NSDictionary *)defaultTheme {
    NSDictionary *configuration;
    configuration = [NSDictionary dictionaryWithFileName: @"appDefault.theme"];
    return configuration ? configuration : @{};
}

#pragma mark Application Delegate

- (BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Record Metrics
    [self markAppLaunchStart];
    
    //set the root view controller to the the rapid start view controller
    self.window.rootViewController = self.rapidStartManager.viewController;
    
    // Configure our status bar
    [self configureStatusBar];
    
    //Display the rapid start controller
    [self.window makeKeyAndVisible];
    
    // Record Metrics
    [self markAppLaunchEnd];
    return YES;
}

- (void) applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [self saveCacheData];
}

- (void) applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [self saveCacheData];
}

- (void) applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void) applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void) applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [self saveCacheData];
}

#pragma mark Memory Management Utilities

- (void) saveCacheData {
    // Save Interface Data
    [[IonImageManager interfaceManager] saveManifest: NULL];
}

#pragma mark Application Router

#pragma mark Singletons

+ (instancetype) sharedApplication {
    id currentDelegate = [UIApplication sharedApplication].delegate;
    if ( ![currentDelegate isKindOfClass: [self class]] )
        return NULL;
    return currentDelegate;
}

@end

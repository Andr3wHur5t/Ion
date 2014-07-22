//
//  IonApplication.m
//  Ion
//
//  Created by Andrew Hurst on 6/26/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonApplication.h"
#import "IonRapidStartManager.h"
#import "IonWindow.h"

// Demo Mode Only
#import "IonDemoUIWindow.h"


@interface IonApplication () {
    
#pragma mark Metrics
    double  startupInitTime;
    // application Launch
    double  applicationLaunchBeginTime;
    double  applicationLaunchEndTime;
    // rapid splash Launch
    double  splashDisplayCallbackTime;
    
    
    #pragma mark managers
    
    /* This manages the rapid start of the application.
     */
    IonRapidStartManager* rapidStartManager;
}





#pragma mark constructors

/**
 * This constructs the rapid start manager.
 * @returns {void}
 */
-(void) constructRapidStartManager;

/**
 * This constructs the application window to be used
 * @returns {UIWindow} the application window to be used
 */
- (IonWindow*) applicationWindow;

#pragma mark configuration utilities

/**
 * This configures the rapid start manager
 * @returns {void}
 */
- (void) configureRapidStart;

#pragma mark start up utilities

/**
 * This calls all the intensive processes after the rapid splash view has been rendered
 * @returns {void}
 */
- (void) postDisplaySetup;

/**
 * This constructs all optionial managers based off of the application manifest
 * @returns {void}
 */
- (void) constructOptionialManagersFromManagerManifest;


@end

/**
 * ============================================================
 * ============================================================
 *                    Implmentation Start
 * ============================================================
 * ============================================================
 */


@implementation IonApplication

/**
 * This is the default constructor.
 * Note: DON'T RUN ANY INTENSIVE PROCESS HERE
 * @returns {instancetype}
 */
- (instancetype)init {
    self = [super init];
    if (self) {
        // Record Metrics
        startupInitTime = [[NSDate date] timeIntervalSince1970];
        
        // Construct
        [self constructRapidStartManager];
        [self configureRapidStart];
        
    }
    return self;
}

#pragma mark constructors

/**
 * This constructs the rapid start manager.
 * @returns {void}
 */
- (void) constructRapidStartManager {
    rapidStartManager = [[IonRapidStartManager alloc] init];
}

/**
 * This constructs the application window to be used
 * @returns {UIWindow} the application window to be used
 */
- (IonWindow*) applicationWindow {
    IonWindow* returnedWindow;
    
    // Select the correct window acording to the mode.
    if ( ![self isInDemoMode] )
        returnedWindow = [[IonWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    else
        returnedWindow = [[IonDemoUIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    return returnedWindow;
}

#pragma mark configuration utilities

/**
 * This configures the rapid start manager
 * @returns {void}
 */
- (void) configureRapidStart {
    if ( !rapidStartManager )
        return;
    
    rapidStartManager.deligate = self;
    
    __weak typeof(self) weakSelf = self;
    [rapidStartManager setPostDisplayCallback:^{
        [weakSelf postDisplaySetup];
    }];
}



#pragma mark customization points

/**
 * This states if we use the demo window which displays touch points or not.
 * @returns {bool}
 */
- (bool) isInDemoMode {
    return false;
}

/**
 * This gets the default manifest of optionial managers.
 * *subclassed for customization*
 * @returns {applicationManifest} with the default configuration.
 */
- (bool) loadManagerManifest {
    // return a static default manager manifest
    return true;
}

/**
 * This is the rapid splash view that will be used when the application has already been opened in the system once before.
 * *subclassed for customization*
 * @returns {IonRapidStartViewController}
 */
- (IonRapidStartViewController*) rapidSplash {
    return [[IonRapidStartViewController alloc] init];
}

/**
 * This is the rapid splash view that will be used when the application has not been opened in the system once before.
 * You should return a on boarding controller here.
 * *subclassed for customization*
 * @returns {IonRapidStartViewController}
 */
- (IonRapidStartViewController*) onBoardingRapidSplash {
    return [self rapidSplash];
}

/**
 * This gets the on boarding screen version string.
 * *subclassed for customization*
 * @returns {NSString*}
 */
- (NSString*) currentOnBoardingScreenVersion {
    return NULL;
}

/**
 * This configures the first real view controller.
 * @peram { ^(UIViewController* frvc) } frvc is the "First Real View Conroller" to be presented.
 * @returns {void}
 */
- (void) configureFirstRealViewController:( void(^)( IonViewController* frvc ) ) finished {
    // configure the default first root view controller here.
    IonViewController* vc = [[IonViewController alloc] initWithNibName:NULL bundle:NULL];
    
    vc.view.backgroundColor = [UIColor grayColor];
    
    // Call compleation if it exsists.
    if ( finished )
        finished(vc);
}

/**
 * This is a customiziation point for executing arbitrary code after the construction of the first real view controller.
 * @returns {void}
 */
- (void) setupApplication {
    // Should be subclassed
}

/**
 * This is a customization point where we add our theme proproties to the Ion style manifest.
 * *Should be subclassed, needs to call super*
 * @returns {void}
 */
- (void) addMethodClassPairsToStyleManifest {
    // Add to manifest there
}

/**
 * 
 */
#pragma mark start up utilities

/**
 * This calls all the resource intensive processes after the rapid splash view has been rendered.
 * @returns {void}
 */
- (void) postDisplaySetup {
    // Record Metrics
    splashDisplayCallbackTime = [[NSDate date] timeIntervalSince1970];
    [self logMetrics];
    
    // Load & Set the application manifest
    [self loadManagerManifest];
    
    // Construct all managers here
    [self constructOptionialManagersFromManagerManifest];
    
    // Call the custom view dependent setup here
    [self configureFirstRealViewController: ^(UIViewController* frvc){
        // Hand off control from the rapid start view to the next FRVC
        [rapidStartManager.viewController prepareToDispatchWithNewController: frvc];
        
        // Call the custom setup function
        [self setupApplication];
    }];
}

/**
 * This constructs all optionial managers based off of the application manifest
 * @returns {void}
 */
- (void) constructOptionialManagersFromManagerManifest {
    // Check manifest and construct managers
}

#pragma mark Application Deligate
/**
 * This is called when we should present our first view controller.
 */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Record Metrics
    applicationLaunchBeginTime = [[NSDate date] timeIntervalSince1970];
    
    self.window = [self applicationWindow];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //set the root view controller to the the rapid start view controller
    self.window.rootViewController = rapidStartManager.viewController;
    
    //Display the rapid start controller
    [self.window makeKeyAndVisible];
    
    // Record Metrics
    applicationLaunchEndTime = [[NSDate date] timeIntervalSince1970];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark memory management utils

/**
 * This is where we kill the rapid splash manager, it served us well but now it is useless.
 * @returns {void}
 */
- (void) freeRapidSplashManager {
    rapidStartManager = NULL;
}

/**
 * This will display startup metrics affter launch.
 * @returns {void}
 */
- (void) logMetrics {
    double initToLaunch, launching, toFirstSplash, toRapidSplashDisplay;
    NSString* logString = @"\nStartup Metrics:\n";
    
    // Create string with format
    logString = [logString stringByAppendingString:@"Time from init to launch: %.2f ms (Note: Shared with OS) \n"];
    logString = [logString stringByAppendingString:@"Time Spent Launching: %.2f ms \n"];
    logString = [logString stringByAppendingString:@"Time Generating Rapid Splash: %.2f ms\n"];
    logString = [logString stringByAppendingString:@"Time To First Rapid Splash Render: %.2f ms \n\n"];
    
    // get relitive times
    initToLaunch = applicationLaunchBeginTime - startupInitTime;
    launching = applicationLaunchEndTime - applicationLaunchBeginTime;
    toFirstSplash = applicationLaunchEndTime -  startupInitTime;
    toRapidSplashDisplay = splashDisplayCallbackTime - startupInitTime;
    
    // format the string
    logString = [NSString stringWithFormat:logString,
                 initToLaunch * 1000,
                 launching * 1000,
                 toFirstSplash,toRapidSplashDisplay * 1000 ];
    
    // Send to the console
    NSLog(@"%@",logString);
}

@end

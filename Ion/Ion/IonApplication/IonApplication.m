//
//  IonApplication.m
//  Ion
//
//  Created by Andrew Hurst on 6/26/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonApplication.h"
#import "IonRapidStartManager.h"

@interface IonApplication () {
    
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
- (UIWindow*) applicationWindow;


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
        [self constructRapidStartManager];
        [self configureRapidStart];
    }
    return self;
}

- (void) dealloc {
    
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
- (UIWindow*) applicationWindow {
    return [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
}

#pragma mark configuration utilities

/**
 * This configures the rapid start manager
 * @returns {void}
 */
- (void) configureRapidStart {
    [rapidStartManager setViewConfiguration: [self loadRapidStartSplashConfiguration]];
    
    __weak typeof(self) weakSelf = self;
    [rapidStartManager setPostDisplayCallback:^{
        [weakSelf postDisplaySetup];
    }];
}


#pragma mark customization points

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
 * This gets the default configuration for the rapid splash.
 * Called once per start up.
 * *subclassed for customization*
 * @returns {IonRapidStartupViewConfiguration} with the default configuration.
 */
- (IonRapidStartupViewConfiguration) loadRapidStartSplashConfiguration {
    // retun a static default splash configuration manifest
    return (IonRapidStartupViewConfiguration){true};
}

/**
 * This configures the first real view controller.
 * @peram {block} this is the block we will call when we are finished with prepareing the view.
 * @returns {void}
 */
- (void) configureFirstRealViewController:(void(^)()) finished {
    // configure the default first root view controller here.
    
    if ( finished )
        finished();
}

/**
 * This is a customiziation point for executing arbitrary code after the construction of the first real view controller.
 * @returns {void}
 */
- (void) setupApplication {
    // Should be subclassed
}


#pragma mark start up utilities

/**
 * This calls all the resource intensive processes after the rapid splash view has been rendered.
 * @returns {void}
 */
- (void) postDisplaySetup {
    // Load & Set the application manifest
    [self loadManagerManifest];
    
    // Construct all managers here
    [self constructOptionialManagersFromManagerManifest];
    
    // Call the custom view dependent setup here
    [self configureFirstRealViewController: ^{
        // hand off controll from the rapid start manager to the view controller manager.
        
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
    self.window = [self applicationWindow];
    self.window.backgroundColor = [UIColor blackColor];
    
    //set the root view controller to the the rapid start view controller
    [rapidStartManager prepareToDisplay];
    self.window.rootViewController = rapidStartManager.viewController;
    
    //Display the rapid start controller
    [self.window makeKeyAndVisible];
    
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

@end

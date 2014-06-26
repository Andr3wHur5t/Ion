//
//  IonApplication.h
//  Ion
//
//  Created by Andrew Hurst on 6/26/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IonApplication : UIResponder <UIApplicationDelegate>
/**
 * This is the application window.
 */
@property (strong, nonatomic) UIWindow *window;

/**
 * This is the
 */

#pragma mark customization points

/**
 * This gets the default manifest of optionial managers.
 * *subclassed for customization*
 * @returns {applicationManifest} with the default configuration.
 */
-(bool) loadManagerManifest;

/**
 * This gets the configuration for the rapid splash.
 * Called once per start up.
 * *subclassed for customization*
 * @returns {rapidStartSplashConfiguration} with the default configuration.
 */
- (bool) loadRapidStartSplashConfiguration;

/**
 * This configures the first real view controller.
 * @peram {block} this is the block we will call when we are finished with prepareing the view.
 * @returns {void}
 */
- (void) configureFirstRealViewController:(void(^)()) finished;

/**
 * This is a customiziation point for executing arbitrary code after the construction of the first real view controller.
 * @returns {void}
 */
- (void) setupApplication;

#pragma mark singletons

@end

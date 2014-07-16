//
//  IonApplication.h
//  Ion
//
//  Created by Andrew Hurst on 6/26/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IonRapidStartManager.h"
#import "IonViewController.h"

@interface IonApplication : UIResponder <UIApplicationDelegate, IonRapidStartManagerDeligate>
/**
 * This is the application window.
 */
@property (strong, nonatomic) UIWindow *window;

#pragma mark controlls


#pragma mark customization points

/**
 * This states if we use the demo window which displays touch points or not.
 * @returns {bool}
 */
- (bool) isInDemoMode;

/**
 * This gets the default manifest of optionial managers.
 * *subclassed for customization*
 * @returns {applicationManifest} with the default configuration.
 */
-(bool) loadManagerManifest;

/**
 * This is the rapid splash view that will be used when the application has already been opened in the system once before.
 * *subclassed for customization*
 * @returns {IonRapidStartViewController}
 */
- (IonRapidStartViewController*) rapidSplash;

/**
 * This is the rapid splash view that will be used when the application has not been opened in the system once before.
 * You should return a on boarding controller here.
 * *subclassed for customization*
 * @returns {IonRapidStartViewController}
 */
- (IonRapidStartViewController*) onBoardingRapidSplash;

/**
 * This gets the on boarding screen version string.
 * *subclassed for customization*
 * @returns {NSString*}
 */
- (NSString*) currentOnBoardingScreenVersion;


/**
 * This configures the first real view controller.
 * @peram {block} this is the block we will call when we are finished with prepareing the view.
 * @returns {void}
 */
- (void) configureFirstRealViewController:( void(^)( IonViewController* frvc ) ) finished;

/**
 * This is a customiziation point for executing arbitrary code after the construction of the first real view controller.
 * @returns {void}
 */
- (void) setupApplication;

#pragma mark singletons

@end

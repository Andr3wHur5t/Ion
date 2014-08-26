//
//  IonApplication.h
//  Ion
//
//  Created by Andrew Hurst on 6/26/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IonWindow.h"
#import "IonRapidStartManager.h"
#import "IonViewController.h"
#import <IonData/IonData.h>


@interface IonApplication : UIResponder <UIApplicationDelegate, IonRapidStartManagerDeligate>
/**
 * This is the application window.
 */
@property (strong, nonatomic) IonWindow *window;

#pragma mark controls


#pragma mark customization points

/**
 * This states if we use the demo window which displays touch points or not.
 * @returns {bool}
 */
- (bool) isInDemoMode;

/**
 * This gets the default manifest of optional managers.
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
 * @peram {block} this is the block we will call when we are finished with preparing the view.
 * @returns {void}
 */
- (void) configureFirstRealViewController:( void(^)( IonViewController* frvc ) ) finished;

/**
 * This is a customization point for executing arbitrary code after the construction of the first real view controller.
 * @returns {void}
 */
- (void) setupApplication;

#pragma mark Utilties

/**
 * Performs a block after the set delay.
 * @param {void(^)( )} the block to call.
 * @returns {void}
 */
- (void) performBlock:(void(^)( )) block afterDelay:(double) delay;


#pragma mark Catagories Variables Map

/**
 * A map to put catagory variables.
 */
@property (strong, nonatomic, readonly) NSMutableDictionary* catagoriesMap;

#pragma mark Singletons

/**
 * A singleton reference to the application.
 * @returns {IonApplication*} reference to the application, or NULL if
 *    your not using a IonApplication as your delegate.
 */
+ (IonApplication*) sharedApplication;

@end

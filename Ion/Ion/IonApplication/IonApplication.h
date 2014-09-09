//
//  IonApplication.h
//  Ion
//
//  Created by Andrew Hurst on 6/26/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IonData/IonData.h>
#import "IonWindow.h"
#import "IonRapidStartManager.h"
#import "IonViewController.h"

/**
 * A Ion managed application delegate.
 */
@interface IonApplication : UIResponder <UIApplicationDelegate, IonRapidStartManagerDeligate>

/**
 * The application window.
 */
@property (strong, nonatomic) IonWindow *window;

#pragma mark customization points

/**
 * The rapid splash view that will be used when the application has already been opened in the system once before.
 * *subclassed for customization*
 * @returns {IonRapidStartViewController}
 */
- (IonRapidStartViewController*) rapidSplash;

/**
 * The rapid splash view that will be used when the application has not been opened in the system once before.
 * You should return a on boarding controller here.
 * *subclassed for customization*
 * @returns {IonRapidStartViewController}
 */
- (IonRapidStartViewController*) onBoardingRapidSplash;

/**
 * Configures the first real view controller.
 * @peram {block} this is the block we will call when we are finished with preparing the view.
 * @returns {void}
 */
- (void) configureFirstRealViewController:( void(^)( IonViewController* frvc ) ) finished;

/**
 * Customization point for executing arbitrary code after the construction of the first real view controller.
 * @returns {void}
 */
- (void) setupApplication;


#pragma mark Singletons

/**
 * Gets the current application delegate object.
 * @returns {instancetype} the current app delegate, or NULL.
 */
+ (instancetype) sharedApplication;

@end

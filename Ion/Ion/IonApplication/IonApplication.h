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
#import "IonViewController.h"

/**
 * A managed application delegate with out of the box demo window, rapid splash, and cacheing support.
 */
@interface IonApplication : UIResponder <UIApplicationDelegate>
#pragma mark Application Delegate
/**
 * Application window.
 */
@property (strong, nonatomic) IonWindow *window;

#pragma mark customization points
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

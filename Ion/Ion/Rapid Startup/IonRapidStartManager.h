//
//  IonRapidStartManager.h
//  Ion
//
//  Created by Andrew Hurst on 6/26/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IonRapidStartViewController.h"


/**
 * This is the rapid start manager delegate protocol
 */
@protocol IonRapidStartManagerDelegate <NSObject>

@required
/**
 * Rapid splash view that will be used when the application has already been opened in the system once before.
 * @returns {IonRapidStartViewController}
 */
- (IonRapidStartViewController *)rapidSplash;

/**
 * Rapid splash view that will be used when the application has not been opened in the system once before.
 * You should return a on boarding controller here.
 * @returns {IonRapidStartViewController}
 */
- (IonRapidStartViewController *)onBoardingRapidSplash;

/**
 * Gets the current on boarding screen version used to decide what rapid splash controller is presented.
 * @returns {NSString*}
 */
- (NSString *)currentOnBoardingScreenVersion;

/**
 * Called after the rapid splash view has been rendered.
 */
- (void) postDisplay;

/**
 * Gets called after the rapid splash session has completed an can safely be freed from memory.
 */
- (void) freeRapidSplashManager;

@end

/* = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
 *                                                  Interface
 * = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =*/

@interface IonRapidStartManager : NSObject
#pragma mark Constructors
/**
 * Constructs a manager using the inputted delegate.
 * @param {id<IonRapidStartManagerDelegate>} the delegate to construct with.
 * @returns {instancetype}
 */
- (instancetype) initWithDelegate:(id<IonRapidStartManagerDelegate>) delegate;

/**
 * The delegate object.
 */
@property (weak, nonatomic) id<IonRapidStartManagerDelegate> delegate;

/**
 * The active view controller to be presented as the rapid controller
 */
@property (nonatomic, strong) IonRapidStartViewController *viewController;

@end

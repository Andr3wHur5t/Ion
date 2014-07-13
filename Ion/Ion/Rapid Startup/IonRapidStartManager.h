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
 * This is the rapid start manager deligate protocal
 */
@protocol IonRapidStartManagerDeligate <NSObject>

@required
/**
 * This is the rapid splash view that will be used when the application has already been opened in the system once before.
 * @returns {IonRapidStartViewController}
 */
- (IonRapidStartViewController*) rapidSplash;

/**
 * This is the rapid splash view that will be used when the application has not been opened in the system once before.
 * You should return a on boarding controller here.
 * @returns {IonRapidStartViewController}
 */
- (IonRapidStartViewController*) onBoardingRapidSplash;

/**
 * This gets the on boarding screen version string.
 * @returns {NSString*}
 */
- (NSString*) currentOnBoardingScreenVersion;


/**
 * This is where we kill the rapid splash manager, it served us well but now it is useless.
 * @returns {void}
 */
- (void) freeRapidSplashManager;

@end


@interface IonRapidStartManager : NSObject

/**
 * This is the deligate object.
 */
@property (weak, nonatomic) id<IonRapidStartManagerDeligate> deligate;

/**
 * This is the active view controller to be presented as the rapid controller
 */
@property (nonatomic, strong) IonRapidStartViewController* viewController;


/**
 * this sets the did display callback.
 * @returns {void}
 */
- (void) setPostDisplayCallback:(void(^)()) callback;

@end

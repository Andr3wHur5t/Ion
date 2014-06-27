//
//  IonRapidStartManager.h
//  Ion
//
//  Created by Andrew Hurst on 6/26/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IonRapidStartViewController.h"

@interface IonRapidStartManager : NSObject


@property (nonatomic, strong) IonRapidStartViewController* viewController;

/**
 * This prepares us to display.
 * @returns {void}
 */
-(void) prepareToDisplay;

/**
 * This sets the rapid view controller configuration
 * @returns {void}
 */
-(void) setViewConfiguration:(IonRapidStartupViewConfiguration) configuration;

/**
 * this sets the did display callback.
 * @returns {void}
 */
- (void) setPostDisplayCallback:(void(^)()) callback;

@end

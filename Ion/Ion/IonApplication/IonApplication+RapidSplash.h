//
//  IonApplication+RapidSplash.h
//  Ion
//
//  Created by Andrew Hurst on 9/8/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonApplication.h"
#import "IonRapidStartManager.h"

/**
 * Delegates all actions related to the management of our rapid splash screens.
 */
@interface IonApplication (RapidSplash) <IonRapidStartManagerDelegate>

/**
 * The Rapid start manager.
 */
@property (strong, nonatomic) IonRapidStartManager *rapidStartManager;
@end

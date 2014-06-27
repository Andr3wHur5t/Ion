//
//  IonRapidStartViewController.h
//  Ion
//
//  Created by Andrew Hurst on 6/26/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IonRapidStartupViewConfiguration.h"

@interface IonRapidStartViewController : UIViewController

/**
 * This sets the configuration object of the view.
 @ @returns {void}
 */
@property (nonatomic, assign) IonRapidStartupViewConfiguration viewConfiguration;

/**
 * this sets the post appear callback which will be called after the view appears.
 # @returns {void}
 */
- (void) setPostAppearCallback:(void(^)()) callback;

@end




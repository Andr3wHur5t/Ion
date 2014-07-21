//
//  IonWindow.h
//  Ion
//
//  Created by Andrew Hurst on 7/20/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IonTheme.h"
#import "UIView+IonTheme.h"

static NSString* sDefaultSystemThemeFileName = @"appDefault";

@interface IonWindow : UIWindow

/**
 * This is the current system theme.
 */
@property (strong ,nonatomic) IonTheme* systemTheme;

@end

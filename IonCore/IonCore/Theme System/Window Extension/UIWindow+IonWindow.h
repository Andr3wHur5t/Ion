//
//  UIWindow+IonWindow.h
//  Ion
//
//  Created by Andrew Hurst on 10/11/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IonTheme;

@interface UIWindow (IonWindow)
/**
 * The system theme of the window.
 */
@property (strong, nonatomic, readwrite) IonTheme *systemTheme;

@end

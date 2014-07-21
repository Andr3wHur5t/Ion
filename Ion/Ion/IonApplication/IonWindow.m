//
//  IonWindow.m
//  Ion
//
//  Created by Andrew Hurst on 7/20/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonWindow.h"

@interface IonWindow  () {
    IonTheme* currentSystemTheme;
}

@end

@implementation IonWindow

/**
 * This sets the root views theme to match the current theme.
 * @returns void;
 */
- (void) setRootViewController:(UIViewController *)rootViewController {
    [super setRootViewController:rootViewController];
    [self updateRootViewControllersThemeToCurrent];
}

/**
 * This updates the current root view controllers theme to the currently set theme.
 * @returns {void}
 */
- (void)  updateRootViewControllersThemeToCurrent {
    [self.rootViewController.view setIonInternialSystemTheme: self.systemTheme];
}

/**
 * This will set the system theme, and update the current root controller to it if not set by user.
 * @returns {void}
 */
- (void)setSystemTheme:(IonTheme *)systemTheme {
    if ( !systemTheme )
        return;
    
    currentSystemTheme = systemTheme;
    [self updateRootViewControllersThemeToCurrent];
}

/**
 * This will get the current system theme object, if not loaded it will load the default one.
 * @returns {IonTheme} the current system theme;
 */
- (IonTheme*) systemTheme {
    if ( !currentSystemTheme )
        currentSystemTheme = [[IonTheme alloc] initWithFileName: sDefaultSystemThemeFileName];
    
    return currentSystemTheme;
}


@end

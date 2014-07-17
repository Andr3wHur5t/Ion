//
//  UIView+IonTheme.h
//  Ion
//
//  Created by Andrew Hurst on 7/13/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IonTheme.h"

@interface UIView (IonTheme)



#pragma mark Externial Interface

/**
 * This is the theme object class name, this is used to select the attributes to be used.
 */
@property (strong, nonatomic) NSString* themeClass;


/**
 * This is the theme object id name, this is used to select the attributes to be used.
 */
@property (strong, nonatomic) NSString* themeID;

/**
 * This is the current Ion theme
 */
@property (assign, nonatomic) BOOL themeWasSetByUser;


/**
 * This sets the theme of the view, this should be called externialy.
 * @praram {NSObject} the theme object to set.
 * @returns {void}
 */
- (void) setIonTheme:(IonTheme*) themeObject;

#pragma mark Debug

/**
 * This will retrun the object theme settings formated as a combined string.
 */
- (NSString*) themeToString;

/**
 * This will log the theme Debug.
 */
- (void) themeToLog;

#pragma mark Internial

/**
 * This sets the theme of the view if the theme hasn't been set by the user
 * @praram {NSObject} the theme object to set
 * @returns {void}
 */
- (void) setIonInternialSystemTheme:(IonTheme*) themeObject;

/**
 * This sets theme to the childeren views.
 * @praram {NSObject} the theme object to set
 * @returns {void}
 */
- (void) setThemeToChildren:(IonTheme*) themeObject;

@end

//
//  UIView+IonTheme.h
//  Ion
//
//  Created by Andrew Hurst on 7/13/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IonTheme.h"

/**
 * These are Standerd element names.
 */
static const NSString* sIonThemeElementBody =                                   @"body";
static const NSString* sIonThemeElementTitleBar =                               @"titleBar";

static const NSString* sIonThemeElementInteractiveUpState =                     @"interactive_up";
static const NSString* sIonThemeElementInteractiveDownState =                   @"interactive_down";
static const NSString* sIonThemeElementInteractiveActiveState =                 @"interactive_active";
static const NSString* sIonThemeElementInteractiveInActiveState =               @"interactive_inactive";

static const NSString* sIonThemeElementStateGood =                              @"state_good";
static const NSString* sIonThemeElementStateBad =                               @"state_bad";
static const NSString* sIonThemeElementStateWorking =                           @"state_working";
static const NSString* sIonThemeElementStateUnknown =                           @"state_unknown";




@interface UIView (IonTheme)

#pragma mark Externial Interface

/**
 * This is the theme object element name, this is used to select the attributes to be used.
 */
@property (strong, nonatomic) NSString* themeElementName;

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

//
//  UIView+IonTheme.h
//  Ion
//
//  Created by Andrew Hurst on 7/13/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IonThemeConfiguration.h"
#import "IonTheme.h"

/**
 * These are Standard element names.
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

#pragma mark External Interface

/**
 * Theme configuration Object.
 */
@property (strong, nonatomic) IonThemeConfiguration* themeConfiguration;

/**
 * This is the current Ion theme
 */
@property (assign, nonatomic) BOOL themeWasSetByUser;


/**
 * This sets the theme of the view, this should be called externally.
 * @praram {NSObject} the theme object to set.
 * @returns {void}
 */
- (void) setIonTheme:(IonTheme*) themeObject;


#pragma mark Internal

/**
 * This sets the theme of the view if the theme hasn't been set by the user
 * @praram {NSObject} the theme object to set
 * @returns {void}
 */
- (void) setIonInternalSystemTheme:(IonTheme*) themeObject;

/**
 * This sets theme to the children views.
 * @praram {NSObject} the theme object to set
 * @returns {void}
 */
- (void) setThemeToChildren:(IonTheme*) themeObject;

@end

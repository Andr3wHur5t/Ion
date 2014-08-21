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


#pragma mark Application

/**
 * This sets the theme of the view, this should be called externally.
 * @praram {NSObject} the theme object to set.
 * @returns {void}
 */
- (void) setIonTheme:(IonTheme*) themeObject;

/**
 * Sets the parrent style for the view, and subviews.
 * @param {IonStyle*} the style to be applied
 * @returns {void}
 */
- (void) setParentStyle:(IonStyle*) style;

/**
 * Sets the current style for the view, and the parrent style for subviews.
 * @param {IonStyle*} the current style to apply.
 * @returns {void}
 */
- (void) setStyle:(IonStyle*) style;


@end

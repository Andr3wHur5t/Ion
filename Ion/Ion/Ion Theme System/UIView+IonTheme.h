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
static NSString* sIonThemeElementBody =                                     @"body";

/** Button */
static NSString* sIonThemeElementButton =                                   @"button";
static NSString* sIonThemeElementButton_SizeKey =                           @"size";

/** Label */
static NSString* sIonThemeElementLabel =                                    @"label";
static NSString* sIonThemeLabel_TextColor =                                 @"textColor";
static NSString* sIonThemeLabel_Font =                                      @"font";
static NSString* sIonThemeLabel_TextAlignment =                             @"textAlignment";

/** Title Bar */
static NSString* sIonThemeElementTitleBar =                                 @"titleBar";
static NSString* sIonThemeElementTitleBar_LeftView =                        @"leftView";
static NSString* sIonThemeElementTitleBar_CenterView =                      @"centerView";
static NSString* sIonThemeElementTitleBar_RightView =                       @"rightView";
static NSString* sIonThemeElementTitleBar_StatusBarOffset =                 @"contentStatusBarOffset";
static NSString* sIonThemeElementTitleBar_ContentHeight =                   @"contentHeight";

/**
 * State Colors
 */
static NSString* sIonThemeElementStateGood =                                @"state_good";
static NSString* sIonThemeElementStateBad =                                 @"state_bad";
static NSString* sIonThemeElementStateWorking =                             @"state_working";
static NSString* sIonThemeElementStateUnknown =                             @"state_unknown";

/**
 * View Positioning
 */
static NSString* sIonThemeView_StylePadding =                               @"stylePadding";
static NSString* sIonThemeView_StyleMargin =                                @"styleMargin";

@interface UIView (IonTheme) <IonThemeSpecialUIView>

#pragma mark External Interface

/**
 * Theme configuration Object.
 */
@property (strong, nonatomic) IonThemeConfiguration* themeConfiguration;

/**
 * The theme element Name.
 */
@property (weak, nonatomic) NSString* themeElement;

/**
 * The theme class Name.
 */
@property (weak, nonatomic) NSString* themeClass;

/**
 * The theme id Name.
 */
@property (weak, nonatomic) NSString* themeID;

#pragma mark Application

/**
 * This sets the theme of the view, this should be called externally.
 * @praram {NSObject} the theme object to set.
 * @returns {void}
 */
- (void) setIonTheme:(IonTheme*) themeObject;

/**
 * Sets the parent style for the view, and subviews.
 * @param {IonStyle*} the style to be applied
 * @returns {void}
 */
- (void) setParentStyle:(IonStyle*) style;

/**
 * Sets the current style for the view, and the parent style for subviews.
 * @param {IonStyle*} the current style to apply.
 * @returns {void}
 */
- (void) setStyle:(IonStyle*) style;

#pragma mark View Positioning Properties

/**
 * The style margin of the view.
 */
@property (assign, nonatomic) CGSize styleMargin;

/**
 * The style padding of the view.
 */
@property (assign, nonatomic) CGSize stylePadding;

/**
 * The auto margin which is decided via the the corner radius, and the style margin.
 */
@property (assign, nonatomic, readonly) CGSize autoMargin;

@end

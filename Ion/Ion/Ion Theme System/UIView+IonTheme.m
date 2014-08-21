//
//  UIView+IonTheme.m
//  Ion
//
//  Created by Andrew Hurst on 7/13/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "UIView+IonTheme.h"
#import <objc/runtime.h>
#import "IonStyle.h"

/** Variable Keys
 */
static void* sThemeConfigurationKey = "IonThemeConfiguration";

@implementation UIView (IonTheme)


#pragma mark Theme Configuration Object
/**
 * This is the setter for the themeConfiguration
 * @returns {void}
 */
- (void) setThemeConfiguration:(IonThemeConfiguration *) themeConfiguration {
    // Set the change callback
    __block typeof (self) weakSelf = self;
    [themeConfiguration setChangeCallback: ^( NSError* err ) {
        [weakSelf setParentStyle: weakSelf.themeConfiguration.currentStyle.parentStyle];
    }];
    
    // Set it
    objc_setAssociatedObject(self, sThemeConfigurationKey, themeConfiguration, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/**
 * This is the getter for the themeConfiguration
 * @returns {IonThemeConfiguration*}
 */
- (IonThemeConfiguration*) themeConfiguration {
    IonThemeConfiguration* config = objc_getAssociatedObject(self, sThemeConfigurationKey);
    if ( !config ) {
        config = [[IonThemeConfiguration alloc] init];
        self.themeConfiguration = config;
    }
    return config;
}


#pragma mark Application

/**
 * This sets the theme of the view, this should be called externally.
 * @praram {NSObject} the theme object to set.
 * @returns {void}
 */
- (void) setIonTheme:(IonTheme*) themeObject {
    if ( !themeObject || ![themeObject isKindOfClass:[IonTheme class]] )
        return;
    
    // Set the root style as the parent style
    [self setParentStyle: [themeObject rootStyle]];
}

/**
 * Sets the parent style for the view, and subviews.
 * @param {IonStyle*} the style to be applied
 * @returns {void}
 */
- (void) setParentStyle:(IonStyle*) style {
    if ( !style || ![style isKindOfClass: [IonStyle class]] )
        return;
    
    [self setStyle: [style styleForView: self]];
}

/**
 * Sets the current style for the view, and the parent style for subviews.
 * @param {IonStyle*} the current style to apply.
 * @returns {void}
 */
- (void) setStyle:(IonStyle*) style {
    if ( !style || ![style isKindOfClass:[IonStyle class]] )
        return;
    // Update ourself
    self.themeConfiguration.currentStyle = style;
    
    // Apply to self
    if ( self.themeConfiguration.themeShouldBeAppliedToSelf )
        [style applyToView: self];
    
    // Set Children styles
    for ( UIView* child in self.subviews )
        [child setParentStyle: style];
}


#pragma mark Utilities

/**
 * This will return the object theme settings formatted as a combined string.
 * @returns {NSString*}
 */
- (NSString*) description {
    return [NSString stringWithFormat:@"Theme-Config:{Class:%@,ID:%@}",
            self.themeConfiguration.themeClass,
            self.themeConfiguration.themeID];
}

@end

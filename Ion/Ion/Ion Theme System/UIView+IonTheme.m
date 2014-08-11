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
static void* sThemeConfigurationKey = "IonThemeConfigurations";
static void* sThemeWasSetByUserKey = "IonThemeWasSetByUser";

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
        [weakSelf setIonInternalSystemTheme: weakSelf.themeConfiguration.currentTheme];
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

#pragma mark External Interface
/**
 * This is the setter for theme was set by user
 * @returns {void}
 */
- (void) setThemeWasSetByUser:(BOOL)themeWasSetByUser {
    objc_setAssociatedObject(self, sThemeWasSetByUserKey, [NSNumber numberWithBool:themeWasSetByUser], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/**
 * This is the getter for theme was set by user
 * @returns {BOOL}
 */
- (BOOL) themeWasSetByUser {
    return [(NSNumber*)objc_getAssociatedObject(self, sThemeWasSetByUserKey) boolValue];
}

/**
 * This sets the theme of the view, this should be called externally.
 * @praram {NSObject} the theme object to set.
 * @returns {void}
 */
- (void) setIonTheme:(IonTheme*) themeObject {
    IonThemeConfiguration* config;
    IonStyle* currentStyle;
    if ( !themeObject )
        return;
    
    // Flip the was set by user latch; note if done through system this should cancel out.
    self.themeWasSetByUser = YES;
    if ( !themeObject ) {
        [NSException exceptionWithName:@"Missing Argument" reason:@"No theme object provided!" userInfo:NULL];
        return;
    }
    
    config = self.themeConfiguration;
    currentStyle = [themeObject styleForView: self];
    if ( [currentStyle isKindOfClass:[IonStyle class]] && currentStyle &&
          config.themeShouldBeAppliedToSelf ) {
        
        [currentStyle applyToView: self];
        config.currentTheme = themeObject;
        config.currentStyle = currentStyle;
    }
    
    [self setThemeToChildren: themeObject];
}

#pragma mark Debug

/**
 * This will return the object theme settings formatted as a combined string.
 * @returns {NSString*}
 */
- (NSString*) description {
    return [NSString stringWithFormat:@"Theme-Config:{Class:%@,ID:%@}",
            self.themeConfiguration.themeClass,
            self.themeConfiguration.themeID];
}

#pragma mark Internal

/**
  * This sets the theme of the view if the theme hasn't been set by the user
  * @praram {NSObject} the theme object to set
  * @returns {void}
  */
- (void) setIonInternalSystemTheme:(IonTheme*) themeObject {
    if ( !self.themeWasSetByUser ) {
        [self setIonTheme:themeObject];
        
        // Cancel out the latch flip so we remain in the correct state
        self.themeWasSetByUser = NO;
    }
}

/**
 * This sets theme to the children views.
 * @praram {NSObject} the theme object to set
 * @returns {void}
 */
- (void) setThemeToChildren:(IonTheme*) themeObject {
    for ( UIView* child in self.subviews )
         [child setIonInternalSystemTheme: themeObject];
}



@end

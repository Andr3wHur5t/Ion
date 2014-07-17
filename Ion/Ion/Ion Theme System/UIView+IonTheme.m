//
//  UIView+IonTheme.m
//  Ion
//
//  Created by Andrew Hurst on 7/13/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "UIView+IonTheme.h"
#import <objc/runtime.h>

static char* sThemeIDkey = "IonThemeID";
static void* sThemeClassKey = "IonThemeClass";
//static void* sThemeObjectKey;
//static void* sStyleKey;
static void* sThemeWasSetByUserKey = "IonThemeWasSetByUser";

@implementation UIView (IonTheme)

@dynamic themeClass;
@dynamic themeID;





#pragma mark Externial Interface

/**
 * This is the setter for the ThemeID
 * @returns {void}
 */
- (void) setThemeID:(NSString*) themeID {
    objc_setAssociatedObject(self, sThemeIDkey, themeID,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    // Note Need to re-compile the style here
}

/**
 * This is the getter for the ThemeID
 * @returns {NSString*}
 */
- (NSString*) themeID{
    return objc_getAssociatedObject(self, sThemeIDkey);
}

/**
 * This is the setter for the
 * @returns {void}
 */
- (void) setThemeClass:(NSString *)themeClass {
    objc_setAssociatedObject(self, sThemeClassKey, themeClass,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    // Note Need to re-compile the style here
}

/**
 * This is the getter for theme class;
 * @returns {NSString*}
 */
- (NSString*) themeClass {
    return objc_getAssociatedObject(self, sThemeClassKey);
}

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
 *
 */

/**
 * This sets the theme of the view, this should be called externialy.
 * @praram {NSObject} the theme object to set.
 * @returns {void}
 */
- (void) setIonTheme:(IonTheme*) themeObject {
    // Flip the was set by user latch; note if done through system this should cancel out.
    self.themeWasSetByUser = YES;
    
    if ( !themeObject ) {
        [NSException exceptionWithName:@"Missing Argument" reason:@"No theme object provided!" userInfo:NULL];
        return;
    }
    IonStyle* currentStyle = [themeObject styleForThemeClass: self.themeClass andThemeID: self.themeID];
    
    if ( currentStyle )
        [currentStyle applyToView: self];
    
    [self setThemeToChildren: themeObject];
}

#pragma mark Debug

/**
 * This will retrun the object theme settings formated as a combined string.
 */
- (NSString*) themeToString {
    return [NSString stringWithFormat:@"Theme-Config:{Class:%@,ID:%@}", self.themeClass, self.themeID];
}

/**
 * This will log the theme Debug.
 */
- (void) themeToLog {
    NSLog(@"%@",[self themeToString]);
}

#pragma mark Internial

/**
  * This sets the theme of the view if the theme hasn't been set by the user
  * @praram {NSObject} the theme object to set
  * @returns {void}
  */
- (void) setIonInternialSystemTheme:(IonTheme*) themeObject {
    if ( !self.themeWasSetByUser ) {
        [self setIonTheme:themeObject];
        
        // Cancel out the latch flip so we remain in the correnct state
        self.themeWasSetByUser = NO;
    }
}

/**
 * This sets theme to the childeren views.
 * @praram {NSObject} the theme object to set
 * @returns {void}
 */
- (void) setThemeToChildren:(IonTheme*) themeObject {
    for ( UIView* child in self.subviews )
         [child setIonInternialSystemTheme: themeObject];
}



@end

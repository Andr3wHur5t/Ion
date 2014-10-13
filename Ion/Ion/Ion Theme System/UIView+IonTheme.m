//
//  UIView+IonTheme.m
//  Ion
//
//  Created by Andrew Hurst on 7/13/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "UIView+IonTheme.h"
#import <objc/runtime.h>
#import <IonData/IonData.h>
#import "IonStyle.h"

/** Variable Keys
 */
static void* sThemeConfigurationKey = "IonThemeConfiguration";
static NSString* sIonStyleMarginKey = @"StyleMargin";
static NSString* sIonStylePaddingKey = @"StylePadding";

@implementation UIView (IonTheme)


#pragma mark Theme Configuration Object
/**
 * This is the setter for the themeConfiguration
 
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
 
 */
- (void) setParentStyle:(IonStyle*) style {
    if ( !style || ![style isKindOfClass: [IonStyle class]] )
        return;
    
    [self setStyle: [style styleForView: self]];
}

/**
 * Sets the current style for the view, and the parent style for subviews.
 * @param {IonStyle*} the current style to apply.
 
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

#pragma mark Theme Element

/**
 * Sets KVO notifications to manual mode.
 */
+ (BOOL) automaticallyNotifiesObserversOfThemeElement { return FALSE; }

/**
 * Sets the theme element key.
 * @param {NSString*} the new key
 
 */
- (void) setThemeElement:(NSString*) themeElement {
    [self willChangeValueForKey: @"themeElement"];
    self.themeConfiguration.themeElement = themeElement;
    [self didChangeValueForKey: @"themeElement"];
}

/**
 * Gets the current theme element value.
 * @returns {NSString*}
 */
- (NSString*) themeElement {
    return self.themeConfiguration.themeElement;
}

#pragma mark Theme Element

/**
 * Sets KVO notifications to manual mode.
 */
+ (BOOL) automaticallyNotifiesObserversOfThemeClass { return FALSE; }

/**
 * Sets the theme class key.
 * @param {NSString*} the new key
 
 */
- (void) setThemeClass:(NSString *)themeClass {
    [self willChangeValueForKey: @"themeClass"];
    self.themeConfiguration.themeClass = themeClass;
    [self didChangeValueForKey: @"themeClass"];
}

/**
 * Gets the current theme class value.
 * @returns {NSString*}
 */
- (NSString*) themeClass {
    return self.themeConfiguration.themeClass;
}

#pragma mark Theme Element

/**
 * Sets KVO notifications to manual mode.
 */
+ (BOOL) automaticallyNotifiesObserversOfThemeID { return FALSE; }

/**
 * Sets the theme id key.
 * @param {NSString*} the new key
 
 */
- (void) setThemeID:(NSString *)themeID {
    [self willChangeValueForKey: @"themeId"];
    self.themeConfiguration.themeID = themeID;
    [self didChangeValueForKey: @"themeId"];
}

/**
 * Gets the current theme id value.
 * @returns {NSString*}
 */
- (NSString*) themeID {
    return self.themeConfiguration.themeID;
}

#pragma mark Data Retrevial

/**
 * Applies the style to the view.
 * @param {IonStyle} the style to be applied.
 
 */
- (void) applyStyle:(IonStyle*) style {
    NSNumber *animationDuration;
    CGSize styleMargin, stylePadding;
    NSParameterAssert( style && [style isKindOfClass: [IonStyle class]] );
    if ( !style || ![style isKindOfClass: [IonStyle class]] )
        return;
    
    // Get the style margin
    styleMargin = [style.configuration sizeForKey: sIonThemeView_StyleMargin];
    if ( CGSizeEqualToSize( styleMargin, CGSizeUndefined) )
        styleMargin = CGSizeZero;
    self.styleMargin = styleMargin;
    
    // Get the style Padding
    stylePadding = [style.configuration sizeForKey: sIonThemeView_StylePadding];
    if ( CGSizeEqualToSize( stylePadding, CGSizeUndefined) )
        stylePadding = CGSizeZero;
    self.stylePadding = stylePadding;
    
    // Get Animation Durration
    animationDuration = [style.configuration numberForKey: sIonThemeView_AnimationDuration];
    if ( !animationDuration )
        animationDuration = @0.3;
    self.animationDuration = [animationDuration floatValue];
}

#pragma mark Can Set Background
- (void) setStyleCanSetBackground:(BOOL)styleCanSetBackground {
    [self.categoryVariables setObject: [NSNumber numberWithBool: styleCanSetBackground] forKey: @"canSetBackground"];
}

- (BOOL) styleCanSetBackground {
    return [self.categoryVariables boolForKey: @"canSetBackground" defaultValue: TRUE];
}

#pragma mark Style Margin

/**
 * Switches KVO to manual modes
 */
+ (BOOL)automaticallyNotifiesObserversOfStyleMargin { return FALSE; }

/**
 * Sets the style margin of the view.
 * @param {CGSize} the new size
 
 */
- (void) setStyleMargin:(CGSize) styleMargin {
    [self willChangeValueForKey: @"styleMargin"];
    [self.categoryVariables setObject: [NSValue valueWithCGSize: styleMargin] forKey: sIonStyleMarginKey];
    [self didChangeValueForKey: @"styleMargin"];
}

/**
 * Gets the style margin size.
 * @returns {CGSize}
 */
-(CGSize) styleMargin {
    return [(NSValue*)[self.categoryVariables objectForKey: sIonStyleMarginKey] CGSizeValue];
}

#pragma mark Style Padding
/**
 * Switches KVO to manual modes
 */
+ (BOOL)automaticallyNotifiesObserversOfStylePadding { return FALSE; }

/**
 * Sets the style margin of the view.
 * @param {CGSize} the new size
 
 */
- (void) setStylePadding:(CGSize)stylePadding {
    [self willChangeValueForKey: @"stylePadding"];
    [self.categoryVariables setObject: [NSValue valueWithCGSize: stylePadding] forKey: sIonStylePaddingKey];
    [self didChangeValueForKey: @"stylePadding"];
}

/**
 * Gets the style margin size.
 * @returns {CGSize}
 */
-(CGSize) stylePadding {
    return [(NSValue*)[self.categoryVariables objectForKey: sIonStylePaddingKey] CGSizeValue];
}


#pragma mark Auto Margin

/**
 * Sets the KVO dependents of the auto margin.
 * @returns {NSSet*} the set
 */
+ (NSSet*) keyPathsForValuesAffectingAutoMargin {
    return [NSSet setWithObjects: @"stylePadding", @"layer.cornerRadius", nil];
}

/**
 * Gets the auto margin value.
 * @returns {CGFloat}
 */
- (CGSize) autoMargin {
    CGSize autoMargin;
    autoMargin.width = MAX( self.stylePadding.width, self.layer.cornerRadius );
    autoMargin.height = MAX( self.stylePadding.height, self.layer.cornerRadius );
    return autoMargin;
}

#pragma mark Animation Duration
/**
 * Set animation duration KVO to manual mode.
 */
+ (BOOL) automaticallyNotifiesObserversOfAnimationDuration { return FALSE; }

/**
 * Sets the animation duration.
 * @param {CGFloat} the new value.
 */
- (void) setAnimationDuration:(CGFloat) animationDuration {
    [self willChangeValueForKey: @"animationDuration"];
    [self.categoryVariables setObject: [NSNumber numberWithDouble: animationDuration] forKey: @"animationDuration"];
    [self didChangeValueForKey: @"animationDuration"];
}

/**
 * Gets the animation duration.
 */
- (CGFloat) animationDuration {
    return [[self.categoryVariables numberForKey: @"animationDuration"] floatValue];
}

#pragma mark Utilities

/**
 * This will return the object theme settings formatted as a combined string.
 * @returns {NSString*}
 */
- (NSString*) description {
    return [NSString stringWithFormat:@"{Class:\"%@\",ID:\"%@\",Element:\"%@\",\nframe:%@}",
            self.themeConfiguration.themeClass,
            self.themeConfiguration.themeID,
            self.themeConfiguration.themeElement,
            NSStringFromCGRect( self.frame )];
}

@end

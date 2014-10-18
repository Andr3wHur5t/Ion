//
//  UIView+IonViewProperties.m
//  Ion
//
//  Created by Andrew Hurst on 7/20/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "UIView+IonViewProperties.h"
#import <objc/runtime.h>

// Theme Parameters key
static const char* sThemeAttributeskey = "IonThemethemeAttributes";

/**
 * Item Keys
 */

/**
 * Extended Theme Properties
 */
@implementation UIView (IonViewProperties)

#pragma mark Theme Parameters
/**
 * Gets the current theme parameters map, or creates it if it doesn't already exist.
 * @return {NSMutableDictionary*} the current parameters object.
 */
- (NSMutableDictionary*) themeAttributes {
    NSMutableDictionary*  attr = objc_getAssociatedObject( self, sThemeAttributeskey );
    if ( !attr ) {
        attr = [[NSMutableDictionary alloc] init];
        objc_setAssociatedObject( self, sThemeAttributeskey, attr, OBJC_ASSOCIATION_RETAIN_NONATOMIC );
    }
    return attr;
}

#pragma mark Corner Radius

/**
 * Sets corner radius KVO to manual mode.
 * @return {BOOL}
 */
+ (BOOL) automaticallyNotifiesObserversOfCornerRadius { return FALSE; }

/**
 * Sets the corner radius of the view.
 * @warning can cause "off screen render calls", and will turn on is masking.
 * @param {CGFloat} the radius of the view to be masked out.  
 */
- (void) setCornerRadius:(CGFloat) cornerRadius {
    if ( !self.layer || cornerRadius == 0.0f )
        return;
    [self setClipsToBounds: TRUE];
    
    [self willChangeValueForKey: @"cornerRadius"];
    self.layer.cornerRadius = cornerRadius;
    [self didChangeValueForKey: @"cornerRadius"];
    
}

/**
 * Gets the corner radius or zero if we are not masking.
 */
- (CGFloat) cornerRadius {
    return self.clipsToBounds || self.layer.masksToBounds ? self.layer.cornerRadius : 0.0f;
}

#pragma mark drop Shadow Color

/**
 * Sets shadow color KVO to manual mode.
 * @return {BOOL}
 */
+ (BOOL) automaticallyNotifiesObserversOfShadowColor { return FALSE; }

/**
 * Sets the drop shadow color.
 * @param {UIColor*} the new color
 * @warning won't work with corer radius, or masking.  
 */
- (void) setShadowColor:(UIColor*) shadowColor {
    self.layer.shadowOpacity = 1.0f;
    [self willChangeValueForKey: @"shadowColor"];
    self.layer.shadowColor = shadowColor.CGColor;
    [self didChangeValueForKey: @"shadowColor"];
}

/**
 * Gets the drop shadow color.
 * @return {UIColor*} the current color.
 */
- (UIColor*) shadowColor {
    return [UIColor colorWithCGColor: self.layer.shadowColor];
}

#pragma mark drop Shadow Offset

/**
 * Sets shadow offset KVO to manual mode.
 * @return {BOOL}
 */
+ (BOOL) automaticallyNotifiesObserversOfShadowOffset { return FALSE; }

/**
 * Sets the shadow offset.
 * @warning won't work with corer radius, or masking.  
 */
- (void) setShadowOffset:(CGSize) shadowOffset {
    [self willChangeValueForKey: @"shadowOffset"];
    self.layer.shadowOffset = shadowOffset;
    [self didChangeValueForKey: @"shadowOffset"];
}

/**
 * Gets the shadow offset.
 * @return {CGSize} the current shadow offset.
 */
- (CGSize) shadowOffset {
    return self.layer.shadowOffset;
}

#pragma mark drop Shadow Radius

/**
 * Sets shadow radius KVO to manual mode.
 * @return {BOOL}
 */
+ (BOOL) automaticallyNotifiesObserversOfShadowRadius { return FALSE; }

/**
 * Sets the drop shadow radius.
 * @warning won't work with corer radius, or masking.  
 */
- (void) setShadowRadius:(CGFloat) shadowRadius {
    [self willChangeValueForKey: @"shadowRadius"];
    self.layer.shadowRadius = shadowRadius;
    [self didChangeValueForKey: @"shadowRadius"];
}

/**
 * Gets the drop shadow radius.
 * @return {CGFloat}
 */
- (CGFloat) shadowRadius {
    return self.layer.shadowRadius;
}

#pragma mark Border Color

/**
 * Sets border color KVO to manual mode.
 * @return {BOOL}
 */
+ (BOOL) automaticallyNotifiesObserversOfBorderColor { return FALSE; }

/**
 * Sets the border color.
 * @param {UIColor*} new color.  
 */
- (void) setBorderColor:(UIColor*) borderColor {
    [self willChangeValueForKey: @"borderColor"];
    self.layer.borderColor = borderColor.CGColor;
    [self didChangeValueForKey: @"borderColor"];
}

/**
 * Gets the current Border color.
 * @return {UIColor*}
 */
- (UIColor*) borderColor {
    return [UIColor colorWithCGColor: self.layer.borderColor];
}

#pragma mark Border Width

/**
 * Sets border width KVO to manual mode.
 * @return {BOOL}
 */
+ (BOOL) automaticallyNotifiesObserversOfBorderWidth { return FALSE; }

/**
 * Sets the border width.
 * @param {CGFloat} the new value.  
 */
- (void) setBorderWidth:(CGFloat) borderWidth {
    [self willChangeValueForKey: @"borderWidth"];
    self.layer.borderWidth = borderWidth;
    [self didChangeValueForKey: @"borderWidth"];
}

/**
 * Gets the border width.
 * @return {CGFloat}
 */
- (CGFloat) borderWidth {
    return self.layer.borderWidth;
}


@end

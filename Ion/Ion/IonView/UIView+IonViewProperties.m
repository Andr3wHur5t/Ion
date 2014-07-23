//
//  UIView+IonViewproperties.m
//  Ion
//
//  Created by Andrew Hurst on 7/20/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "UIView+IonViewProperties.h"
#import <objc/runtime.h>

static const char* sThemeParameterkey = "IonThemeParameters";

@implementation UIView (IonViewProperties)

/**
 * Gets the current theme parameter object.
 * @returns {NSMutableDictionary*} the current parameters object.
 */
- (NSMutableDictionary*) themeParameters {
    NSMutableDictionary*  currentThemeParameter = objc_getAssociatedObject(self, sThemeParameterkey);
    if ( !currentThemeParameter ) {
        currentThemeParameter = [[NSMutableDictionary alloc] init];
        objc_setAssociatedObject(self, sThemeParameterkey, currentThemeParameter,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return currentThemeParameter;
}



#pragma mark Macro Controls

/**
 * This sets the corner radius of the view note this can cause "off screen render calls"
 * @param {CGFloat} the radius of the view to be masked out
 * @returns {void}
 */
- (void) setCornerRadius:(CGFloat) radius {
    BOOL isMasking = radius != 0.0f;
    if ( !self.layer )
        return;
    
    self.layer.cornerRadius = radius;
    
    // Turn On Clipping
    [self setClipsToBounds: isMasking];
    [self.layer setMasksToBounds: isMasking];
}

/**
 * This sets the drop shadow of the view.
 * @param {UIColor} the color of the drop shadow.
 * @param {CGFloat} the radius of the drop shadow.
 * @param {CGSize} the offset position of the drop shadow.
 * @return {void}
 */
- (void) setDropShadowWithColor:(UIColor*) color
                         radius:(CGFloat) radius
              andOffsetPosition:(CGSize) offset {
    if ( !self.layer )
        return;
    
    // Corner Radius clips the shadow, we cant support this in a single view we have to nest :(
    [self setCornerRadius: 0.0f];
    
    [self.layer setShadowColor: color.CGColor];
    [self.layer setShadowOpacity: 1.0f];
    [self.layer setShadowRadius: radius];
    [self.layer setShadowOffset: offset];
}

/**
 * This sets the border color, and width inline.
 * @param {UIColor*} the color to set the border
 * @param {CGFloat} the width to set the border
 * @returns {void}
 */
- (void) setBorderColor:(UIColor*) color andWidth:(CGFloat) width {
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
}



#pragma mark Parameter Object

/**
 * Sets the views theme parameters object.
 * @param {NSDictionary*} the new parameters to set.
 * @returns {void}
 */
- (void) setThemeParameters:(NSMutableDictionary*) newParameters {
    if ( !newParameters )
        return;
    objc_setAssociatedObject(self, sThemeParameterkey, newParameters,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}






@end
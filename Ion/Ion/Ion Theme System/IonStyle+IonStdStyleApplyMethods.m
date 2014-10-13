//
//  IonStyle+IonStdStyleApplyMethods.m
//  Ion
//
//  Created by Andrew Hurst on 7/21/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonStyle+IonStdStyleApplyMethods.h"
#import "UIView+IonViewProperties.h"
#import "NSDictionary+IonThemeResolution.h"
#import "IonAttrubutesStanderdResolution.h"

#import "UIView+IonTheme.h"

@implementation IonStyle (IonStdStyleApplyMethods)

/**
 * Adds the STD proprieties to the method map.
 
 */
- (void) addIonStdStyleApplyProprieties {
    // Add Background
    [self.proprietyMethodMap setMethod: @selector(setBackgroundOnView:withPointer:)
                                forKey: sStyleSTDBackgroundKey];
    
    // Add Corrner Radius
    [self.proprietyMethodMap setMethod: @selector(setCornerRadius:withRaidus:)
                                forKey: sStyleSTDCornerRadiusKey];
    
    // Add Border
    [self.proprietyMethodMap setMethod: @selector(setBorder:withConfig:)
                                forKey: sStyleSTDBorderKey];
    
    // Add Drop Shadow
    [self.proprietyMethodMap setMethod: @selector(setShadow:withConfig:)
                                forKey: sStyleSTDShadowKey];
}


/**
 * Sets the background of the view if provided a valid effect pointer.
 * @param {UIView*} the view to set to.
 * @param {NSDitionary*} the effect pointer.
 * @returns {id} null when finshed.
 */
- (id) setBackgroundOnView:(UIView*) view withPointer:(NSDictionary*) pointer {
    id pointedObject;
    NSParameterAssert( view && [view isKindOfClass:[UIView class]] );
    NSParameterAssert( pointer && [pointer isKindOfClass: [NSDictionary class]] );
    if ( !self.theme || !view.styleCanSetBackground )
        return NULL;

    // Get
    pointedObject = [IonThemePointer resolvePointer: pointer withAttributes: self.theme];
    if ( !pointedObject )
        return NULL;
    
    // Set
    if ( [pointedObject isKindOfClass:[UIColor class]] ) {
        view.layer.contents = NULL;
        view.backgroundColor = (UIColor*)pointedObject;
        return NULL;
        
    } else if ( [pointedObject isKindOfClass:[IonGradientConfiguration class]] ) {
        if ( [pointedObject isKindOfClass:[IonLinearGradientConfiguration class]] )
            [view setBackgroundToLinearGradient: (IonLinearGradientConfiguration*)pointedObject];
        return NULL;
    }
    
    return NULL;
}


/**
 * Sets the corner radius on the inputted view to the inputted value.
 * @param {UIView*} the view to set to.
 * @param {NSNumber*} the radius to use.
 * @returns {id} null when finshed.
 */
- (id) setCornerRadius:(UIView*) view withRaidus:(NSNumber*) radius {
    NSParameterAssert( view && [view isKindOfClass:[UIView class]] );
    NSParameterAssert( radius && [radius isKindOfClass: [NSNumber class]] );
    if ( !view ||
         ![radius isKindOfClass:[NSNumber class]] || !radius )
        return NULL;
    
    // Apply
    view.cornerRadius = [radius floatValue];
    return NULL;
}

/**
 * Sets the border color, and width on the inputted view to match the inputted config.
 * @param {UIView*} the view to set to.
 * @param {NSDictionary*} the configuration object to use.
 * @returns {id} null when finshed.
 */
- (id) setBorder:(UIView*) view withConfig:(NSDictionary*) config {
    NSNumber* width;
    UIColor* color;
    NSParameterAssert( view && [view isKindOfClass:[UIView class]] );
    NSParameterAssert( config && [config isKindOfClass: [NSDictionary class]] );
    if ( !view ||
         !config  || ![config isKindOfClass: [NSDictionary class]])
        return NULL;
    
    // Get
    width = [config objectForKey: sBorderWidthKey];
    color = [config colorForKey: sBorderColorKey usingTheme: self.theme];
        
    // Check
    if ( !width || ![width isKindOfClass: [NSNumber class]] ||
         !color )
        return NULL;
    
    // Set
    view.borderWidth = [width floatValue];
    view.borderColor = color;
    return NULL;
}


/**
 * Sets the shadow on the inputted view to match the inputted config.
 * @param {UIView*} the view to set to.
 * @param {NSDictionary*} the configuration object to use.
 * @returns {id} null when finshed.
 */
- (id) setShadow:(UIView*) view withConfig:(NSDictionary*) config {
    NSNumber* radius;
    CGPoint offset;
    UIColor* color;
    NSParameterAssert( view && [view isKindOfClass:[UIView class]] );
    NSParameterAssert( config && [config isKindOfClass: [NSDictionary class]] );
    if ( !view ||
         !config  || ![config isKindOfClass: [NSDictionary class]] )
        return NULL;
    
    // get
    radius = [config objectForKey: sShadowRadiusKey];
    color = [config colorForKey: sShadowColorKey usingTheme: self.theme];
    offset = [config pointForKey: sShadowOffsetKey];
    
    // Check
    NSParameterAssert( radius && [radius isKindOfClass:[NSNumber class]] );
    NSParameterAssert( color && [color isKindOfClass:[UIColor class]] );
    if ( !radius || ![radius isKindOfClass: [NSNumber class]] ||
         !color || ![color isKindOfClass: [UIColor class]] ||
         CGPointEqualToPoint(offset, CGPointUndefined) )
        return NULL;
    
    // Set
    view.shadowColor = color;
    view.shadowRadius = [radius floatValue];
    view.shadowOffset = (CGSize){ offset.x, offset.y };
    return NULL;
}

@end

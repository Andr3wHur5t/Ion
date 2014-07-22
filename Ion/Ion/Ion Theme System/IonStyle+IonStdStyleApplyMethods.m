//
//  IonStyle+IonStdStyleApplyMethods.m
//  Ion
//
//  Created by Andrew Hurst on 7/21/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonStyle+IonStdStyleApplyMethods.h"
#import "UIView+IonViewProperties.h"

@implementation IonStyle (IonStdStyleApplyMethods)

/**
 * This adds the STD proprieties to the method map.
 * @returns {void}
 */
- (void) addIonStdStyleApplyProprieties {
    // Add Background
    [self.proprietyMethodMap setMethod: @selector(setBackgroundOnView:) forKey: sStyleSTDBackgroundKey];
    
    // Add Corrner Radius
    [self.proprietyMethodMap setMethod: @selector(setCornerRadius:) forKey: sStyleSTDCornerRadiusKey];
    
    // Add Border
    [self.proprietyMethodMap setMethod: @selector(setBorder:) forKey: sStyleSTDBorderKey];
    
    // Add Drop Shadow
    [self.proprietyMethodMap setMethod: @selector(setShadow:) forKey: sStyleSTDShadowKey];
    
}


/**
 * This sets the background of the view if it has a valid effect pointer.
 * @param {UIView*} the view to set to.
 * @returns {id} null when finshed.
 */
- (id) setBackgroundOnView:(UIView*) view {
    id pointedObject;
    NSDictionary* pointer;
    if ( !self.attributes || !self.config)
        return NULL;
    
    // Get the pointer
    pointer = (NSDictionary*)[self.config objectForKey:sStyleSTDBackgroundKey];
    if ( !pointer )
        return NULL;
    
    // Get the object
    pointedObject = [IonThemePointer resolvePointer: pointer withAttributes: self.attributes];
    if ( !pointedObject )
        return NULL;
    
    // Set for type of object
    if ( [pointedObject isKindOfClass:[UIColor class]] ) {
        view.backgroundColor = (UIColor*)pointedObject;
        return NULL;
        
    } else if ( [pointedObject isKindOfClass:[IonGradientConfiguration class]] ) {
        if ( [pointedObject isKindOfClass:[IonLinearGradientConfiguration class]] )
            [view setBackgroundToLinearGradient: (IonLinearGradientConfiguration*)pointedObject];
        return NULL;
        
    } else if ( [pointedObject isKindOfClass:[UIImage class]] ) {
        [view setBackgroundImage: (UIImage *)pointedObject];
        return NULL;
    }
    
    return NULL;
}


/**
 * This sets the Border Width on a view.
 * @param {UIView*} the view to set to.
 * @returns {id} null when finshed.
 */
- (id) setCornerRadius:(UIView*) view {
    NSNumber* resultRadius;
    if ( !view )
        return NULL;
    
    // Get
    resultRadius = [self.config objectForKey: sStyleSTDCornerRadiusKey];
    if ( ![resultRadius isKindOfClass:[NSNumber class]] || !resultRadius )
        return NULL;
    
    // Apply
    [view setCornerRadius: [resultRadius floatValue]];
    return NULL;
}

/**
 * This sets the Border Color on a view.
 * @param {UIView*} the view to set to.
 * @returns {id} null when finshed.
 */
- (id) setBorder:(UIView*) view {
    NSDictionary* config;
    NSNumber* width;
    NSString* colorString;
    if ( !view )
        return NULL;
    
    // Get
    config = [self.config objectForKey:sStyleSTDCornerRadiusKey];
    if ( !config  || ![config isKindOfClass:[NSNumber class]])
        return NULL;
    
    
    
    return NULL;
}


/**
 * This sets the Shadow Color on a view.
 * @param {UIView*} the view to set to.
 * @returns {id} null when finshed.
 */
- (id) setShadow:(UIView*) view {
    NSLog(@"Shadow!");
    return NULL;
}



@end

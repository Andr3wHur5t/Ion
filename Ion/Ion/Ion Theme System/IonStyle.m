//
//  IonStyle.m
//  Ion
//
//  Created by Andrew Hurst on 7/16/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonStyle.h"
#import "UIView+IonBackgroundUtilities.h"
#import "IonAccessBasedGenerationMap.h"
#import "IonThemePointer.h"

/** Keys for style
 */
static NSString* sStyleBackgroundKey = @"background";


@interface IonStyle ()

/** This is the config that states what we are.
 */
@property (strong, nonatomic) NSMutableDictionary* config;

/** This are the attrubutes we will resolve with.
 */
@property (strong, nonatomic) IonThemeAttributes* attributes;

@end

@implementation IonStyle
/**
 * This will resolve a style using a map and an Attrbute Set.
 * @param {NSDictionary*} the map to process
 * @param {IonThemeAttributes*} the theme attrubute set to do our searches on if needed.
 * @returns {UIColor*} representation, or NULL of invalid
 */
+ (IonStyle*) resolveWithMap:(NSDictionary*) map andAttrubutes:(IonThemeAttributes*) attributes {
    if ( !attributes || !map)
        return NULL;
    
    IonStyle* result = [[IonStyle alloc] init];
    
    [result setResolutionAttributes: attributes];
    [result setObjectConfig: map];
    
    return result;
}

#pragma mark External Interface

/**
 * This sets the object config.
 * @param {NSDictionary*} the configuration to set.
 * @returns {void}
 */
- (void) setObjectConfig:(NSDictionary*) configMap {
    if ( !configMap )
        return;
    
    _config = [[NSMutableDictionary alloc] initWithDictionary:configMap];
}
/**
 * This sets the attributes that we should resolve with.
 * @param {IonThemeAttributes*} the attrubute we should resolve with.
 * @returns {void}
 */
- (void) setResolutionAttributes:(IonThemeAttributes*) attributes {
    if ( !attributes )
        return;
    
    _attributes = attributes;
}


/**
 * This applys the current style to the inputted view.
 * @param {UIVIew*} the view to apply the style to.
 * @returns {void}
 */
- (void) applyToView:(UIView*) view {
    if ( !_attributes || !_config)
        return;
    // Call all seting to view here
    
    [self setBackgroundOnView: view];
    
    // Call the deligate and dasiy chanined deligates.
}

/**
 * This sets the background of the view if it has a valid effect pointer.
 * @param {UIView*} the view to set the background of.
 * @returns {void}
 */
- (void) setBackgroundOnView:(UIView*) view{
    id pointedObject;
    NSDictionary* pointer;
    if ( !_attributes || !_config)
        return;

    // Get the pointer
    pointer = (NSDictionary*)[_config objectForKey:sStyleBackgroundKey];
    if ( !pointer )
        return;
    
    // Get the object
    pointedObject = [IonThemePointer resolvePointer: pointer withAttributes: _attributes];
    if ( !pointedObject )
        return;
    
    // Set for type of object
    if ( [pointedObject isKindOfClass:[UIColor class]] ) {
          view.backgroundColor = (UIColor*)pointedObject;
        return;
    
    } else if ( [pointedObject isKindOfClass:[IonGradientConfiguration class]] ) {
        if ( [pointedObject isKindOfClass:[IonLinearGradientConfiguration class]] ) {
            [view setBackgroundToLinearGradient: (IonLinearGradientConfiguration*)pointedObject];
            
        }
        return;
        
    } else if ( [pointedObject isKindOfClass:[UIImage class]] ) {
        [view setBackgroundImage: (UIImage *)pointedObject];
        return;
    }
}

/**
 * This overrides the current styles proproties with the inputed style.
 * @param {IonStyle*} the style to override the current style
 * @returns {IonStyle*} the net style of the overide
 */
- (IonStyle*) overideStyleWithStyle:(IonStyle*)overideingStyle {
    id newObject;
    NSArray* keys;
    IonStyle* result;
    if ( !overideingStyle )
        return self;
    
    // Construct Object
    result = [IonStyle resolveWithMap: _config andAttrubutes: _attributes];
    
    // Get Keys
    keys = [overideingStyle.config allKeys];
    
   
    //overide proproties with the overideing styles proproties.
    for ( id key in keys ) {
        newObject = [overideingStyle.config objectForKey:key];
        if ( !newObject )
            break;
        
        [result.config setValue: newObject forKey: key];
    }
    
    return result;
}

/**
 * This returns the description of our config manifest.
 * @return {NSString*}
 */
- (NSString*) description {
    return [_config description];
}

#pragma mark Base View Interface

@end

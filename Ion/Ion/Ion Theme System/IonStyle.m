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

/** Keys for style
 */
static NSString* sStyleBackgroundKey = @"background";

/** Keys for pointer
 */
static NSString* sPointerTypeKey = @"type";
static NSString* sPointerNameKey = @"name";

static NSString* sPointerTargetTypeColor = @"color";
static NSString* sPointerTargetTypeGradient = @"gradient";
static NSString* sPointerTargetTypeImage = @"image";
static NSString* sPointerTargetTypeKVP = @"kvp";
static NSString* sPointerTargetTypeStyle = @"style";


@interface IonStyle ()

/** This is the config that states what we are.
 */
@property (strong, nonatomic) NSDictionary* config;

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
    
    _config = configMap;
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
    pointedObject = [self resolvePointer: pointer withAttributes: _attributes];
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
 * This resolves pointers into objects
 * @param {NSDictionary*} representation of a valid pointer.
 * @param {IonThemeAttributes*} the attrubute we should resolve with.
 * @returns {id} the resulting object, or NULL if invalid.
 */
- (id) resolvePointer:(NSDictionary*) pointer withAttributes:(IonThemeAttributes*) attributes {
    NSString *targetType, *targetName;
    id result;
    if ( !pointer || !attributes )
        return NULL;
    
    // Get Keys
    targetType = [pointer objectForKey:sPointerTypeKey];
    targetName = [pointer objectForKey:sPointerNameKey];
    
    // Is Valid?
    if ( !targetType || !targetName )
        return  NULL;
    if ( ![targetType isKindOfClass:[NSString class]] || ![targetName isKindOfClass:[NSString class]] )
        return  NULL;
    
    // Resolve Color
    if ( [targetType isEqualToString: sPointerTargetTypeColor] )
        result = [attributes resolveColorAttrubute: targetName];
    
    // Resolve Gradient
    else if ( [targetType isEqualToString: sPointerTargetTypeGradient] )
         result = [attributes resolveGradientAttribute: targetName];
    
    // Resolve  Image
    else if ( [targetType isEqualToString: sPointerTargetTypeImage] )
         result = [attributes resolveColorAttrubute: targetName]; // TODO ADD
    
    // Resolve KVP
    else if ( [targetType isEqualToString: sPointerTargetTypeKVP] )
         result = [attributes resolveColorAttrubute: targetName]; // TODO ADD
    
    // Resolve Style
    else if ( [targetType isEqualToString: sPointerTargetTypeStyle] )
         result = [attributes resolveStyleAttribute: targetName];
    
    return result;
}

/**
 * This overrides the current styles proproties with the inputed style.
 * @param {IonStyle*} the style to override the current style
 * @returns {IonStyle*} the net style of the overide
 */
- (IonStyle*) overideStyleWithStyle:(IonStyle*)overideingStyle {
    NSArray* keys;
    if ( !overideingStyle )
        return self;
    NSLog(@"Called");
    
    keys = [overideingStyle.config allKeys];
    
    //overide proproties with the overideing styles proproties.
    for ( NSString* key in keys ) {
        [_config setValue: [overideingStyle.config objectForKey:key] forKey: key];
    }
    
    return self;
}


#pragma mark Base View Interface

@end

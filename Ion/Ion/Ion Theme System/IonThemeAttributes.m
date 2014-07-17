//
//  IonThemeAttributes.m
//  Ion
//
//  Created by Andrew Hurst on 7/16/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonThemeAttributes.h"


static const NSString* sColorsKey = @"colors";
static const NSString* sGradientsKey = @"gradients";
static const NSString* sImagesKey = @"images";
static const NSString* sKVPKey = @"kvp";
static const NSString* sStylesKey = @"styles";

// Limit our search depth incase of evil recusion loops!
static const unsigned int sMaxColorResolveDepth = 2500;


@interface IonThemeAttributes () {
    unsigned int currentColorResolveDepth;
}

@end

@implementation IonThemeAttributes

/**
 * Standerd constructor
 * @returns {instancetype}
 */
- (instancetype) init {
    self = [super init];
    
    if ( self ) {
        [self constructGroupMaps];
        [self setGenerationBlocks];
    }
    
    return self;
}

/**
 * This will init the attributes using the inputed configuration.
 * @param {NSDictionary*} a configuration dictionary
 * @returns {instancetype}
 */
- (instancetype) initWithConfiguration:(NSDictionary*) configuration {
    self = [self init];
    
    if ( self ) {
        [self setAttributeGroupsWithConfiguration:configuration];
    }
    
    return self;
}


#pragma mark Construction Utilities

/**
 * This constructs the groups maps
 */
- (void) constructGroupMaps {
    _colors = [[IonAccessBasedGenerationMap alloc] init];
    _images = [[IonAccessBasedGenerationMap alloc] init];
    _gradients = [[IonAccessBasedGenerationMap alloc] init];
    _kvp = [[IonAccessBasedGenerationMap alloc] init];
    _styles = [[IonAccessBasedGenerationMap alloc] init];
}

/**
 * This sets the generation blocks
 */
- (void) setGenerationBlocks {
    __weak typeof(self) weakSelf = self;
    [_styles setGenerationBlock:^id(id data) {
        return [[IonStyle alloc] initWithConfiguration: (NSDictionary*)data];
    }];
    
    [_colors setGenerationBlock:^id(id data) {
        return [weakSelf resolveColorAtrubute: (NSString*)data];
    }];
}


#pragma mark External Interface



#pragma mark Search Queries

/**
 * This will try to find a color using the inputed name
 * @param {NSString*} the name of the color we want.
 * @returns {UIColor*} a color object, or NULL if nothing could be found.
 */
- (UIColor*) colorWithName:(NSString*) name {
    return (UIColor*)[_colors objectForKey:name];
}

/**
 * This will try to find a gradient using the inputed name
 * @param {NSString*} the name of the gradient we want.
 * @returns {IonGradientConfiguration} a gradient configuration object, or NULL if nothing could be found.
 */
- (IonGradientConfiguration*) gradientWithName:(NSString*) name {
    return (IonGradientConfiguration*)[_gradients objectForKey:name];
}

/**
 * This will try to find a style using the inputed name
 * @param {NSString*} the name of the style we want.
 * @returns {IonStyle} a style object, or NULL if nothing could be found
 */
- (IonStyle*) styleWithName:(NSString*) name {
    return (IonStyle*)[_styles objectForKey:name];
}

#pragma mark Internal Interface

/**
 * This sets the configuration of the atrubute groups using the inputed configuration.
 * @param {NSDictionary*} the configuration to set the attrubuite groups to.
 * @returns {void}
 */
- (void) setAttributeGroupsWithConfiguration:(NSDictionary*) config {
    NSDictionary *unverifiedColors, *unverifiedGradients, *unverifiedImages, *unverifiedKVP, *unverifiedStyles;
    if ( !config )
        return;
    
    unverifiedColors = [config objectForKey: sColorsKey];
    unverifiedGradients = [config objectForKey: sGradientsKey];
    unverifiedImages = [config objectForKey: sImagesKey];
    unverifiedKVP = [config objectForKey: sKVPKey];
    unverifiedStyles = [config objectForKey: sStylesKey];
    
    // Colors
    if ( [self highLevelAttributeGroupIsValid: unverifiedColors] )
        [_colors setRawData: unverifiedColors];
    
    // Gradients
    if ( [self highLevelAttributeGroupIsValid: unverifiedGradients] )
        [_gradients setRawData: unverifiedGradients];
    
    // Images
    if ( [self highLevelAttributeGroupIsValid: unverifiedImages] )
        [_images setRawData: unverifiedImages];
    
    // KVP
    if ( [self highLevelAttributeGroupIsValid: unverifiedKVP] )
        [_kvp setRawData: unverifiedKVP];
    
    // Styles
    if ( [self highLevelAttributeGroupIsValid: unverifiedStyles] )
        [_styles setRawData: unverifiedStyles];
}




/**
 * This is our logging function.
 */
- (NSString*) description {
    return [NSString stringWithFormat: @"\nColors: %@ \n\n Gradents: %@ \n\n Styles: %@ \n\n Images: %@ \n\n KVP: %@ \n\n", _colors, _gradients, _styles, _images, _kvp ];
}

#pragma mark Verification and Item Resolution

/**
 * This dose basic inspection that the high level higharchy of a attribute group is valid.
 * This should only be used in class for verification of attribute groups.
 * @param {NSDictionary*} the high level group to be inspected.
 */
- (BOOL) highLevelAttributeGroupIsValid:(NSDictionary*) highLevelGroup {
    
    if ( !highLevelGroup )
        return false;
    
    if ( highLevelGroup.count < 1 )
        return false;
    
    // Put additional verification tests here
    
    return true;
}


/**
 * This will resolve a color atribute.
 * @param {NSString*} the unresolved, and unverified color attribute
 * @returns {UIColor*} the resolved and verified UIColor, or NULL if it couldnt be verified or resolved.
 */
- (UIColor*) resolveColorAtrubute:(NSString*) value {
    ++currentColorResolveDepth;
    UIColor* result;
    
    // Check if the value is a string.
    if ( ![value isKindOfClass: [NSString class]] )
        return NULL;
    
    // Check if the string is a hex
    if ( [self stingIsValidHex:value] ) {
        // We found it!
        result = [UIColor colorFromHexString: value];
        
        --currentColorResolveDepth;
        return result;
    } else {
        if ( false ) // do we contain illegal char?
            return NULL;
        
        if ( currentColorResolveDepth <= sMaxColorResolveDepth )
            result = [self colorWithName: value];     // Go farther down the rabbit hole!
        
        --currentColorResolveDepth;
        return result;
    }
    
    return NULL;
}

/**
 * This checks if the inputted string is a valid hex.
 */
- (BOOL) stingIsValidHex:(NSString*)str {
    int strLength = [str length];
    
    if ( [[str substringToIndex:1] isEqualToString:@"#"] && strLength < 9) {
        
        // Check for valid length
        switch ( strLength - 1 ) {
            case 8:  // RRGGBBAA
                return true;
                break;
            case 6:  // RRGGBB
                return true;
                break;
            case 4:  // RGBA
                return true;
                break;
            case 3:  // RGB
                return true;
                break;
            default: // Fail Not Hex
                return false;
                break;
        }
    }
    else
        return false;
    
}

@end

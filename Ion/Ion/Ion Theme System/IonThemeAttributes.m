//
//  IonThemeAttributes.m
//  Ion
//
//  Created by Andrew Hurst on 7/16/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonThemeAttributes.h"
#import "IonMath.h"


static const NSString* sColorsKey = @"colors";
static const NSString* sGradientsKey = @"gradients";
static const NSString* sImagesKey = @"images";
static const NSString* sKVPKey = @"kvp";
static const NSString* sStylesKey = @"styles";

/** Gradient Sub Keys
 */
static const NSString* sGradientTypeKey = @"type";

static const NSString* sGradientColorWeightsKey = @"colorWeights";
static const NSString* sGradientColorKey = @"color";
static const NSString* sGradientWeightKey = @"weight";

static const NSString* sGradientLinearKey = @"linear";
static const NSString* sGradientLinearAngleKey = @"angle";
static const CGFloat   sGradientLinearAngleDefault = 90.0f;

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
    
    // Style
    [_styles setGenerationBlock:^id(id data) {
        return [[IonStyle alloc] initWithConfiguration: (NSDictionary*)data];
    }];
    
    // Color
    [_colors setGenerationBlock:^id(id data) {
        return [weakSelf resolveColorAttrubute: (NSString*)data];
    }];
    
    // Gradient
    [_gradients setGenerationBlock:^id(id data) {
        return [weakSelf resolveGradientAttribute: (NSDictionary*)data];
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
 * @returns {BOOL} true if it passes validation, false if it failes
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
 * This will resolve a color attribute.
 * @param {NSString*} the unresolved, and unverified color attribute
 * @returns {UIColor*} the resolved and verified UIColor, or NULL if it couldnt be verified or resolved.
 */
- (UIColor*) resolveColorAttrubute:(NSString*) value {
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
 * @param {NSString*} this is the string to be validated
 * @returns {BOOL} true if the hex is valid, false if it has failed
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

/**
 * This Resolves a gradient object into a gradientConfiguration
 * @param {NSDictionary*} the object for us to process and convert
 * @returns {IonGradientConfiguration*} representation of the input, or NULL if invalid.
 */
- (IonGradientConfiguration*) resolveGradientAttribute:(NSDictionary*) value {
    IonGradientConfiguration* result;
    NSArray* colorWeights;

    if ( !value )
        return NULL;
    
    if ( ![value isKindOfClass:[NSDictionary class]] )
        return NULL;
    
    result = [self gradientTypeConfiguration: value];
    
    if ( !result )
        return NULL;
    
    colorWeights = [self colorWeightArrayFromGradientMap: value];
    
    if ( !colorWeights )
        return NULL;
    
    result.colorWeights = colorWeights;
    
    return result;
}

/**
 * This generates the corect configuration acording to the confis
 * @param {NSDictionary*} the gradient object map
 * @returns {IonGradientConfiguration*} the correct configuration, NULL if invalid
 */
- (IonGradientConfiguration*) gradientTypeConfiguration:(NSDictionary*) dict {
    NSString* type;
    if ( !dict )
        return NULL;
    
    // Get the Keys
    type = [dict objectForKey:sGradientTypeKey] ;
    
    if ( !type )
        return NULL;
    
    // Specific Gradient Type Generation
    // Add More Gradients here
    if ( [type.lowercaseString isEqualToString: sGradientLinearKey.lowercaseString] )
        return [self gradientLinearConfiguration:dict];
    else
        return [self gradientLinearConfiguration:dict];
    
}

/**
 * This gets the correct configuration for a linear gradent using an inputed map.
 * @param {NSDictionary*} map of the gradient configuration
 * @returns {IonGradientConfiguration*} configuration representing the map, or NULL because of invalid data.
 */
- (IonGradientConfiguration*) gradientLinearConfiguration:(NSDictionary*) dict {
    IonLinearGradientConfiguration* result;
    NSNumber* intermedeateAngle;
    
    if ( !dict )
        return NULL;
    
    result = [[IonLinearGradientConfiguration alloc] init];
    
    // Get the angle
    intermedeateAngle = [dict objectForKey: sGradientLinearAngleKey];
    if ( !intermedeateAngle )
        result.angle = DegreesToRadians( sGradientLinearAngleDefault );
    else
        result.angle = DegreesToRadians( [intermedeateAngle floatValue] );
    
    return result;
}

/**
 * This generates the color weight array from the inputted gradient map.
 * @param {NSDictionary*} the gradient map.
 * @returns {NSArray} the resulting color weight array, or NULL if invalid.
 */
- (NSArray*) colorWeightArrayFromGradientMap:(NSDictionary*) dict {
    NSMutableArray* resultArray;
    NSArray* kvpColorWeightsUnverified;
    
    if ( !dict )
        return NULL;
    
    resultArray = [[NSMutableArray alloc] init];
    kvpColorWeightsUnverified = [dict objectForKey:sGradientColorWeightsKey];
    
    // Verify status of kvpColorWeightsUnverified
    if ( !kvpColorWeightsUnverified )
        return NULL;
    if ( kvpColorWeightsUnverified.count < 1 )
        return NULL;
    
    // Setup Enviorment
    NSString* colorString;
    NSNumber* weight;
    UIColor* color;
    
    // Go through each KVP verify them and add them
    for ( NSDictionary* kvp in kvpColorWeightsUnverified ) {
        colorString = [kvp objectForKey:sGradientColorKey];
        weight = [kvp objectForKey:sGradientWeightKey];
        
        if ( !colorString || !weight )
            break;
        
        color = [self resolveColorAttrubute: colorString];
        
        if ( !color )
            break;
        
        // Add Color Weight
        [resultArray addObject: [[IonColorWeight alloc] initWithColor: color andWeight: [weight floatValue]]];
        
        // Clean UP
        color = NULL;
        colorString = NULL;
        weight = NULL;
    }
    
    return resultArray;
}

@end

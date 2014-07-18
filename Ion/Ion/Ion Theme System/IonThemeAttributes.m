//
//  IonThemeAttributes.m
//  Ion
//
//  Created by Andrew Hurst on 7/16/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonThemeAttributes.h"
#import "IonMath.h"

#import "IonStyle.h"
#import "UIColor+IonColor.h"
#import "IonGradientConfiguration.h"

@implementation IonThemeAttributes

#pragma mark Constructors
/**
 * Standerd constructor
 * @returns {instancetype}
 */
- (instancetype) init {
    self = [super init];
    if ( self ) {
        [self constructAttributeMaps];
        [self setAttributeGenerationBlocks];
    }
    return self;
}

/**
 * This will construct our attribute using the inputed configuration object.
 * @param {NSDictionary*} the configuration to use.
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
 * This is where we construct all our Attrubute maps.
 * @returns {void}
 */
- (void) constructAttributeMaps {
    // Colors
    _colors = [[IonAccessBasedGenerationMap alloc] init];
    
    // Images
    _images = [[IonAccessBasedGenerationMap alloc] init];
    
    // Gradients
    _gradients = [[IonAccessBasedGenerationMap alloc] init];
    
    // Key Value Pairs
    _kvp = [[IonAccessBasedGenerationMap alloc] init];
    
    // Styles
    _styles = [[IonAccessBasedGenerationMap alloc] init];
}

/**
 * This sets the Attribute generation construction block.
 * @returns {void}
 */
- (void) setAttributeGenerationBlocks {
    __weak typeof(self) weakSelf = self;
    // Style
    [_styles setGenerationBlock: ^id( id data ) {
        return [IonStyle resolveWithMap: (NSDictionary*)data andAttrubutes: weakSelf];
    }];
    
    // Color
    [_colors setGenerationBlock: ^id( id data ) {
        return [UIColor resolveWithValue: (NSString*)data andAttrubutes: weakSelf];
    }];
    
    // Gradient
    [_gradients setGenerationBlock: ^id( id data ) {
        return [IonGradientConfiguration resolveWithMap: (NSDictionary*)data andAttrubutes: weakSelf];
    }];
}


#pragma mark External Interface

/**
 * This is our logging function.
 * @returns {NSString*}
 */
- (NSString*) description {
    return [NSString stringWithFormat: @"\nColors: %@ \n\n Gradents: %@ \n\n Styles: %@ \n\n Images: %@ \n\n KVP: %@ \n\n", _colors, _gradients, _styles, _images, _kvp ];
}


#pragma mark Attribute Resolution

/**
 * This resolves a color key into a UIColor.
 * @param {NSString*} the key for us to look for.
 * @returns {IonGradientConfiguration*} representation of the input, or NULL if invalid.
 */
- (UIColor*) resolveColorAttrubute:(NSString*) value {
    return [UIColor resolveWithValue:value andAttrubutes: self];
}

/**
 * This resolves a gradient key into a gradientConfiguration
 * @param {NSString*} the key for us to look for.
 * @returns {IonGradientConfiguration*} representation of the input, or NULL if invalid.
 */
- (IonGradientConfiguration*) resolveGradientAttribute:(NSString*) value {
    return (IonGradientConfiguration*)[_gradients objectForKey: value];
}

/**
 * This resolves a style key into a IonStyle object.
 * @param {NSString*} the key for us to look for.
 * @returns {IonStyle*} representation of the input, or NULL if invalid.
 */
- (IonStyle*) resolveStyleAttribute:(NSString*) value {
    return (IonStyle*)[_styles objectForKey: value];
}

/**
 * This resolves a Image key into a UIImage object.
 * @param {NSString*} the key for us to look for.
 * @returns {UIImage*} representation of the input, or NULL if invalid.
 */
- (UIImage*) resolveImageAttribute:(NSString*) value {
    return (UIImage*)[_images objectForKey: value];
}

/**
 * This resolves a KVP key into a KVP object.
 * @param {NSString*} the key for us to look for.
 * @returns {UIImage*} representation of the input, or NULL if invalid.
 */
- (NSObject*) resolveKVPAttribute:(NSString*) value {
    return (NSObject*)[_kvp objectForKey: value];
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

    // Colors
    unverifiedColors = [config objectForKey: sColorsKey];
    if ( [self highLevelAttributeGroupIsValid: unverifiedColors] )
        [_colors setRawData: unverifiedColors];
    
    // Gradients
    unverifiedGradients = [config objectForKey: sGradientsKey];
    if ( [self highLevelAttributeGroupIsValid: unverifiedGradients] )
        [_gradients setRawData: unverifiedGradients];
    
    // Images
    unverifiedImages = [config objectForKey: sImagesKey];
    if ( [self highLevelAttributeGroupIsValid: unverifiedImages] )
        [_images setRawData: unverifiedImages];
    
    // KVP
    unverifiedKVP = [config objectForKey: sKVPKey];
    if ( [self highLevelAttributeGroupIsValid: unverifiedKVP] )
        [_kvp setRawData: unverifiedKVP];
    
    // Styles
    unverifiedStyles = [config objectForKey: sStylesKey];
    if ( [self highLevelAttributeGroupIsValid: unverifiedStyles] )
        [_styles setRawData: unverifiedStyles];
}

#pragma mark validation

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

@end

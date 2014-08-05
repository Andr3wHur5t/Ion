//
//  IonStyle.m
//  Ion
//
//  Created by Andrew Hurst on 7/16/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonStyle.h"
#import "IonStyle+IonStdStyleApplyMethods.h"
#import "NSDictionary+IonTypeExtension.h"
#import "IonKVPAccessBasedGenerationMap.h"
#import "IonTheme.h"
#import "IonThemePointer.h"




@interface IonStyle () {
    BOOL styleHasBeenCompiled;
}

@end

@implementation IonStyle
/**
 * This will resolve a style using a map and an Attribute Set.
 * @param {NSDictionary*} the map to process
 * @param {IonThemeAttributes*} the theme attributes set to do our searches on if needed.
 * @returns {UIColor*} representation, or NULL of invalid
 */
+ (IonStyle*) resolveWithMap:(NSDictionary*) map andAttributes:(IonTheme*) attributes {
    if ( !attributes || !map)
        return NULL;
    return [[IonStyle alloc] initWithDictionary: map andResolutionAttributes: attributes];;
}

#pragma mark Constructors

/**
 * This is the default constructor
 * @returns {instancetype}
 */
- (instancetype) init {
    self = [super init];
    if ( self ) {
        _proprietyMethodMap = [[IonMethodMap alloc] initWithTarget: self];
        [self addIonStdStyleApplyProprieties];
        styleHasBeenCompiled = false;
    }
    
    return self;
}

/**
 * Constructs a style using a dictionary configuatation.
 * @param {NSDictionary*} configuration
 * @returns {instancetype}
 */
- (instancetype) initWithDictionary:(NSDictionary*) dict {
    return [self initWithDictionary: dict andResolutionAttributes: NULL];
}


/**
 * Constructs a style using a dictionary configuatation.
 * @param {NSDictionary*} configuration
 * @param {IonThemeAttributes*} the attributes we should resolve with.
 * @returns {instancetype}
 */
- (instancetype) initWithDictionary:(NSDictionary*) dict andResolutionAttributes:(IonTheme*) attributes {
    self = [self init];
    if ( self ) {
        [self setResolutionAttributes: attributes];
        [self setObjectConfig: dict];
    }
    
    return self;
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
    _configuration = [[NSMutableDictionary alloc] initWithDictionary:configMap];
}
/**
 * This sets the attributes that we should resolve with.
 * @param {IonThemeAttributes*} the attributes we should resolve with.
 * @returns {void}
 */
- (void) setResolutionAttributes:(IonTheme*) attributes {
    if ( !attributes )
        return;
    _theme = attributes;
}

/**
 * This applies the current style to the inputted view.
 * @param {UIView*} the view to apply the style to.
 * @returns {void}
 */
- (void) applyToView:(UIView*) view {
    NSArray* keys;
    if ( !view )
        return;
    
    [self compileConfiguration];
    if ( !_theme || !_configuration )
        return;
    
    keys =  _configuration.allKeys;
    if ( !keys )
        return;
    
    
    // To Animate we will have to to a ca transaction for the CALayer, UI Animation Block for others.
    
    // Set each
    for ( NSString* key in keys )
        if ( key )
            [_proprietyMethodMap invokeMethodOnTargetWithKey: key
                                                  withObject: view
                                                   andObject: [_configuration objectForKey: key]];
    
    
}

/**
 * Compiles the style recursively using the composited styles of all ancestors
 */
- (void) compileConfiguration {
    if ( !_parentStyle || styleHasBeenCompiled )
        return;
    if ( !_configuration )
        _configuration = [[NSMutableDictionary alloc] init];
    
    [_parentStyle compileConfiguration];
    _configuration = [[NSMutableDictionary alloc] initWithDictionary:
                      [_parentStyle.configuration overriddenByDictionaryRecursively: _configuration]];
}

/**
 * This overrides the current styles proprieties with the inputed style.
 * @param {IonStyle*} the style to override the current style
 * @returns {IonStyle*} the net style of the override
 */
- (IonStyle*) overrideStyleWithStyle:(IonStyle*) overridingStyle {
    IonStyle* result;
    if ( !overridingStyle )
        return self;
    
    // Construct Object
    result = [[IonStyle alloc] initWithDictionary: _configuration andResolutionAttributes: _theme];
    
    // Override
    result.configuration = [[NSMutableDictionary alloc] initWithDictionary:
                       [self.configuration overriddenByDictionaryRecursively: overridingStyle.configuration]];
    
    return result;
}

/**
 * This returns the description of our config manifest.
 * @return {NSString*}
 */
- (NSString*) description {
    return [_configuration description];
}

/**
 * Comparison of styles.
 * @param {IonStyle*} the style to be compared.
 * @returns {BOOL}
 */
- (BOOL) isEqualToStyle:(IonStyle*) style {
    if ( !style || ![style isKindOfClass: [IonStyle class]] )
        return FALSE;
    
    if ( ![self.configuration isEqualToDictionary: style.configuration] )
        return FALSE;
    
    return TRUE;
}

@end

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
    
    IonStyle* result = [[IonStyle alloc] init];
    
    [result setResolutionAttributes: attributes];
    [result setObjectConfig: map];
    
    return result;
}

#pragma mark Constructors

/**
 * This is the default constructor
 * @returns {instancetpe}
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
 * returnes a copy of our configuration overwriten by the inputted configuration.
 * @param {NSDictionary*} the configuration which will overwrite.
 * @returns {NSDictionary*} an overwriten ditcionary, or NULL if invalid.
 */
- (NSDictionary*) configurationOverwritenBy:(NSDictionary*) configuration {
    NSMutableDictionary* resultConfiguration;
    id newObject;
    NSArray* keys;
    if ( !configuration || !_configuration )
        return NULL;
    
    // Set up
    resultConfiguration = [[NSMutableDictionary alloc] initWithDictionary: _configuration];
    keys = [configuration allKeys];
    if ( !keys || !resultConfiguration )
        return NULL;
    
    //override proprieties with the overriding configuration proprieties.
    for ( id key in keys ) {
        newObject = [configuration objectForKey:key];
        if ( !newObject )
            break;
        
        [resultConfiguration setValue: newObject forKey: key];
    }
    
    return resultConfiguration;
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
    result = [IonStyle resolveWithMap: _configuration andAttributes: _theme];
    
    // Overide
    result.configuration = [[NSMutableDictionary alloc] initWithDictionary:
                       [self configurationOverwritenBy: overridingStyle.configuration]];
    
    return result;
}

/**
 * This returns the description of our config manifest.
 * @return {NSString*}
 */
- (NSString*) description {
    return [_configuration description];
}

@end

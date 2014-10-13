//
//  IonStyle.m
//  Ion
//
//  Created by Andrew Hurst on 7/16/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonStyle.h"
#import "IonStyle+IonStdStyleApplyMethods.h"
#import <IonData/IonData.h>
#import "UIView+IonTheme.h"
#import "IonTheme.h"
#import "IonThemePointer.h"




@interface IonStyle () {
    // Used to reduce recompilation
    BOOL styleHasBeenCompiled;
}

@end

@implementation IonStyle

/**
 * Resolves a style using a map and an attribute Set.
 * @param {NSDictionary*} the map to process
 * @param {IonThemeAttributes*} the theme attributes set to do our searches on if needed.
 * @return {UIColor*} representation, or NULL of invalid
 */
+ (IonStyle*) resolveWithMap:(NSDictionary*) map andAttributes:(IonTheme*) attributes {
    if ( !attributes || !map)
        return NULL;
    return [[IonStyle alloc] initWithDictionary: map andResolutionAttributes: attributes];;
}

#pragma mark Constructors

/**
 * The default constructor  
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
 * Constructs a style using a dictionary configuration.
 * @param {NSDictionary*} configuration  
 */
- (instancetype) initWithDictionary:(NSDictionary*) dict {
    return [self initWithDictionary: dict andResolutionAttributes: NULL];
}


/**
 * Constructs a style using a dictionary configuration.
 * @param {NSDictionary*} configuration
 * @param {IonThemeAttributes*} the attributes we should resolve with.  
 */
- (instancetype) initWithDictionary:(NSDictionary*) dict andResolutionAttributes:(IonTheme*) attributes {
    self = [self init];
    if ( self ) {
        [self setResolutionAttributes: attributes];
        [self setObjectConfig: dict];
    }
    return self;
}


#pragma mark Setters

/**
 * Sets the object config.
 * @param {NSDictionary*} the configuration to set.  
 */
- (void) setObjectConfig:(NSDictionary*) configMap {
    if ( !configMap )
        return;
    _configuration = [[NSMutableDictionary alloc] initWithDictionary:configMap];
}

/**
 * Sets the attributes that we should resolve with.
 * @param {IonThemeAttributes*} the attributes we should resolve with.  
 */
- (void) setResolutionAttributes:(IonTheme*) attributes {
    if ( !attributes )
        return;
    _theme = attributes;
}

#pragma mark Application

/**
 * Applies the current style to the inputted view.
 * @param {UIView*} the view to apply the style to.  
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
    
    // Set General
    for ( NSString* key in keys )
        if ( key )
            [_proprietyMethodMap invokeMethodOnTargetWithKey: key
                                                  withObject: view
                                                   andObject: [_configuration objectForKey: key]];
    
    // Set the view using the special properties
    if ( [view conformsToProtocol:@protocol(IonThemeSpecialUIView)] )
        [view performSelector: @selector(applyStyle:) withObject: self];
}

#pragma mark Children Retrieval

/**
 * Gets the style that corisponds to the inputted View.
 * @param {UIView*} the view to get the style for.
 * @return {IonStyle*} the resulting style
 */
- (IonStyle*) styleForView:(UIView*) view {
    IonStyle *res, *ele, *cls, *Id;
    NSString *eleStr, *clsStr, *idStr;
    if ( !view || ![view isKindOfClass:[UIView class]] )
        return self; // return the default style which is self
    
    // Get Substyles for keys
    eleStr = view.themeConfiguration.themeElement;
    if ( eleStr )
        ele = [self childStyleForKey: [sIonTheme_StyleElement   stringByAppendingString: eleStr]];
    
    clsStr = view.themeConfiguration.themeClass;
    if ( clsStr )
        cls = [self childStyleForKey: [sIonTheme_StyleClass     stringByAppendingString: clsStr]];
    
    idStr = view.themeConfiguration.themeID;
    if ( idStr )
        Id =  [self childStyleForKey: [sIonTheme_StyleId        stringByAppendingString: idStr]];
    
    // Combine
    res = self;
    if ( ele )
        res = [res overrideStyleWithStyle: ele];
    if ( cls )
        res = [res overrideStyleWithStyle: cls];
    if ( Id )
        res = [res overrideStyleWithStyle: Id];
    
    return res;
}

/**
 * Gets the substyle for the specified key.
 * @param {NSString*} the key for the style to retrive
 * @return {IonStyle*} the style, or NULL.
 */
- (IonStyle*) childStyleForKey:(NSString*) key {
    NSDictionary *children, *target;
    IonStyle* child;
    if ( !key || ![key isKindOfClass: [NSString class]] )
        return NULL;
    
    children = [_configuration dictionaryForKey: @"children"];
    if ( !children )
        return NULL;
    
    target = [children dictionaryForKey: key];
    if ( !target )
        return NULL;
    
    child = [[IonStyle alloc] initWithDictionary: target andResolutionAttributes: self.theme];
    child.parentStyle = self;
    
    return child;
}

#pragma mark Utilities

/**
 * Compiles the style recursively using the composited styles of all ancestors.  
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
 * Overrides the current styles proprieties with the inputed style.
 * @param {IonStyle*} the style to override the current style
 * @return {IonStyle*} the net style of the override
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
 * Returns the description of our config manifest.
 * @return {NSString*}
 */
- (NSString*) description {
    return [_configuration description];
}

/**
 * Compares styles.
 * @param {IonStyle*} the style to be compared.
 * @return {BOOL}
 */
- (BOOL) isEqualToStyle:(IonStyle*) style {
    if ( !style || ![style isKindOfClass: [IonStyle class]] )
        return FALSE;
    
    if ( ![self.configuration isEqualToDictionary: style.configuration] )
        return FALSE;
    
    return TRUE;
}

@end

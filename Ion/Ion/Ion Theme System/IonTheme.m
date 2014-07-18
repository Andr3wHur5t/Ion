//
//  IonTheme.m
//  Ion
//
//  Created by Andrew Hurst on 7/16/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonTheme.h"
#import "IonStyle.h"
#import "UIView+IonTheme.h"

/**
 * Search Keys
 */
static NSString* sIonThemeFileExtension = @"theme";
static NSString* sIonThemeDefaultStyleKey = @"default";
static NSString* sIonThemeThemeNameKey = @"name";

/**
 * Search Formats
 */
static NSString* sIonThemeClassFormat = @"cls_%@";
static NSString* sIonThemeIdFormat = @"id_%@";

@interface IonTheme () {
    
}

/* This the default style
 */
@property (strong, nonatomic) IonStyle* defaultStyle;

@end


/**
 * ===========================================================================
 * ===========================================================================
 */


@implementation IonTheme

#pragma mark Construction

/**
 * Standerd constructor
 * @returns {instancetype}
 */
- (instancetype) init {
    self = [super init];
    
    if ( self ) {
        self.attributes = [[IonThemeAttributes alloc] init];
    
    }
    
    return self;
}

/**
 * This will construct a theme with the provided name from application resources.
 * @param {NSString*} the file name of the theme in the file system
 * @returns {instancetype}
 */
- (instancetype) initWithFileName:(NSString*) fileName {
    return [self initWithFileAtPath: [[NSBundle mainBundle] pathForResource: fileName
                                                                     ofType: sIonThemeFileExtension]];
}

/**
 * This constructs and cofigures a theme using the file at the provided path.
 * @param {NSString*} the literal path of the theme file.
 * @returns {instancetype}
 */
- (instancetype) initWithFileAtPath:(NSString*) path {
    // Do in Ion File manager
    NSData* file = [[NSData alloc] initWithContentsOfFile:path];
    NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:file options:0 error:NULL];
    return [self initWithConfiguration:dict];
}

/**
 * This constructs and configures a theme using the provided configuration object
 * @param {NSDictionary*} the config object to create the theme with.
 * @returns {instancetype}
 */
- (instancetype) initWithConfiguration:(NSDictionary*) config {
    self = [self init];
    if ( self ) {
        if ( !config )
            return NULL;
        [_attributes setAttributeGroupsWithConfiguration: config];
        
        _name = [config objectForKey: sIonThemeThemeNameKey];
    }
    return self;
}

#pragma mark External Interface
/**
 * This gets the style for the inputted view.
 * @param {UIView*} the view to get the style for the view.
 * @param {IonStyle*] will return the net style
 */
- (IonStyle*) styleForView: (UIView*)view {
    IonStyle *idAndClassStyle, *elementStyle;
    if ( !view )
        return NULL;
    
    idAndClassStyle = [self styleForThemeClass: view.themeClass andThemeID: view.themeID];
    elementStyle = [self styleForElementName: view.themeElementName];
    
    if ( elementStyle ) {
        idAndClassStyle = [elementStyle overideStyleWithStyle: idAndClassStyle ];
    }
    
    
    return idAndClassStyle;
}

/**
 * This gets the style for the inputted element name.
 * @param {NSString*} the element name to search for
 * @retutns {IonStyle*} will return the net style
 */
- (IonStyle*) styleForElementName:(NSString*) name {
    IonStyle* result;
    if ( !name )
        return NULL;
    
    result = [self.attributes resolveStyleAttribute: name];
    
    return result;
}

/**
 * This compiles the theme into a style class for the sepecified view.
 * @param {NSString*} the theme class to look for; Can Be NULL if other provided
 * @param {NSString*} the theme id to look for; Can Be NULL if other provided
 * @returns {IonStyle*} will return the net style
 */
- (IonStyle*) styleForThemeClass:(NSString*) themeClass andThemeID:(NSString*) themeID {
    IonStyle *classStyle, *idStyle;
    
    // Search if we have generated one with the same parameters; Optomization;
    
    if ( themeClass )
            classStyle = [self styleForClassName: themeClass];
        
    
    if ( themeID )
            idStyle = [self styleForIdName: themeID];
    
    return [self styleFromCompositedClassStyle: classStyle andIdStyle: idStyle];
}

#pragma mark Internal Interface
/**
 * This gets the style for the inputted class name.
 * @param {NSString*} the class name to search for
 * @retutns {IonStyle*}
 */
- (IonStyle*) styleForClassName:(NSString*) className {
    IonStyle* result;
    if ( !className )
        return NULL;
    
    NSString* fullClassName = [NSString stringWithFormat: sIonThemeClassFormat, className];
    
    result = [self.attributes resolveStyleAttribute: fullClassName];
    
    return result;
}

/**
 * This gets the style for the inputted id name.
 * @param {NSString*} the class ID to search for.
 * @retutns {IonStyle*}
 */
- (IonStyle*) styleForIdName:(NSString*) idName {
    IonStyle* result;
    if ( !idName )
        return NULL;
    NSString* fullIdName = [NSString stringWithFormat: sIonThemeIdFormat, idName];
    
    result = [self.attributes resolveStyleAttribute: fullIdName];
    
    return result;
}

/**
 * This compiles an ID style and a Class style into one style, if both are NULL it will return the default style;
 * @param {IonStyle*} the class style to composite
 * @param {IonStyle*} the id style to composite
 * @returns {IonStyle*} the resulting style
 */
- (IonStyle*) styleFromCompositedClassStyle:(IonStyle*) classStyle andIdStyle:(IonStyle*) idStyle {
    IonStyle* result = [self currentDefaultStyle];

    if ( classStyle && idStyle ) {
        result = [classStyle overideStyleWithStyle: idStyle];
    } else if ( idStyle ) {
        result = idStyle;
    } else if ( classStyle ) {
        result = classStyle;
    }
    
    return result;
}


/**
 * This gets the current defualt style.
 * @returns {IonStyle*} the current default style.
 */
- (IonStyle*) currentDefaultStyle {
    if ( !_defaultStyle )
        _defaultStyle = [self.attributes resolveStyleAttribute: sIonThemeDefaultStyleKey];
    
    if ( !_defaultStyle )
        _defaultStyle = [[IonStyle alloc] init];
    
    return _defaultStyle;
}

@end

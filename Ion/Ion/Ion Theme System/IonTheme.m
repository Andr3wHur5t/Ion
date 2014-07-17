//
//  IonTheme.m
//  Ion
//
//  Created by Andrew Hurst on 7/16/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonTheme.h"



static NSString* sIonThemeFileExtension = @"theme";

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
 * Default constructor
 */
- (instancetype) init {
    self = [super init];
    
    if ( self )
        self.attributes = [[IonThemeAttributes alloc] init];
    
    return self;
}

/**
 * This will construct a theme with the provided name from application resources.
 */
- (instancetype) initWithFileName:(NSString*) fileName {
    return [self initWithFileAtPath: [[NSBundle mainBundle] pathForResource: fileName
                                                                     ofType: sIonThemeFileExtension]];
}

/**
 * This constructs and cofigures a theme using the file at the provided path.
 */
- (instancetype) initWithFileAtPath:(NSString*)path {
    // Do in Ion File manager
    NSData* file = [[NSData alloc] initWithContentsOfFile:path];
    NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:file options:0 error:NULL];
    return [self initWithConfiguration:dict];
}

/**
 * This constructs and configures a theme using the provided configuration object
 */
- (instancetype) initWithConfiguration:(NSDictionary*)config {
    self = [self init];
    
    if ( self ) {
        [_attributes setAttributeGroupsWithConfiguration: config];
    }
    
    return self;
}


#pragma mark Internial Interface

/**
 * This compiles the theme into a style class for the sepecified view.
 * @param {NSString*} the theme class to look for; Can Be NULL if other provided
 * @param {NSString*} the theme id to look for; Can Be NULL if other provided
 * @returns {IonStyle*} will returned the style
 */
- (IonStyle*) styleForThemeClass:(NSString*) themeClass andThemeID:(NSString*) themeID {
    IonStyle *classStyle, *idStyle;
    
    // Search if we have generated one with the same parameters; Optomization;
    
    if ( themeClass )
        if ( true ) // if the Key exsists in theme
            classStyle = [self styleForClassName: themeClass];
        
    
    if ( themeID )
        if ( true ) // if the Key exsists in theme
            idStyle = [self styleForIdName: themeID];
    
    return [self styleFromCompositedClassStyle: classStyle andIdStyle: idStyle];
}



#pragma mark Internal Interface

/**
 * This gets the style for the inputed class name.
 * @param {NSString*} the class name to search for
 * @retutns {IonStyle*}
 */
- (IonStyle*) styleForClassName:(NSString*) className {
    IonStyle* result;
    NSString* fullClassName = [NSString stringWithFormat:@"%@",className];
    
    result = [self.attributes styleWithName: fullClassName];
    
    return result;
}

/**
 * This gets the style for the inputed id name.
 * @param {NSString*} the class ID to search for.
 * @retutns {IonStyle*}
 */
- (IonStyle*) styleForIdName:(NSString*) idName {
    IonStyle* result;
    NSString* fullIdName = [NSString stringWithFormat:@"%@",idName];
    
    result = [self.attributes styleWithName: fullIdName];
    
    return result;
}

/**
 * This compiles an ID style and a Class style into one style, if both are NULL it will return the default style;
 * @param {IonStyle*} the class style to composite
 * @param {IonStyle*} the id style to composite
 * @returns {IonStyle*} the resulting style
 */
- (IonStyle*) styleFromCompositedClassStyle:(IonStyle*)classStyle andIdStyle:(IonStyle*)idStyle {
    IonStyle* result = [self currentDefaultStyle];
    
    if ( classStyle && idStyle ) {
        result = [classStyle overideStyleWithStyle:idStyle];
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
        _defaultStyle = [[IonStyle alloc] init];
    
    return _defaultStyle;
}

@end

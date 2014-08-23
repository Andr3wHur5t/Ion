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
 * This will construct a theme with the provided name from application resources.
 * @param {NSString*} the file name of the theme in the file system
 * @returns {instancetype}
 */
- (instancetype) initWithFileName:(NSString*) fileName {
    return [self initWithFileAtPath: [[NSBundle mainBundle] pathForResource: fileName
                                                                     ofType: sIonThemeFileExtension]];
}

/**
 * This constructs and configures a theme using the file at the provided path.
 * @param {NSString*} the literal path of the theme file.
 * @returns {instancetype}
 */
- (instancetype) initWithFileAtPath:(NSString*) path {
    if ( !path || ![path isKindOfClass:[NSString class]] )
        return NULL;
    // Do in Ion File manager
    NSData* file = [[NSData alloc] initWithContentsOfFile:path];
    if ( !file || ![file isKindOfClass:[NSData class]] )
        return NULL;
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
        [self setRawData: config];
        _name = [config objectForKey: sIonThemeThemeNameKey];
    }
    return self;
}
@end

//
//  IonTheme.h
//  Ion
//
//  Created by Andrew Hurst on 7/16/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <IonData/IonData.h>
#import "IonAttrubutesStanderdResolution.h"

@class IonKeyValuePair;
@class IonImageRef;
@class IonStyle;
@class IonGradientConfiguration;

@interface IonTheme : IonKVPAccessBasedGenerationMap

/**
 * This is the style name.
 */
@property (strong, nonatomic, readonly) NSString* name;

#pragma mark Construction

/**
 * This will construct a theme with the provided name from application resources.
 * @param {NSString*} the file name of the theme in the file system
 * @returns {instancetype}
 */
- (instancetype) initWithFileName:(NSString*) fileName;

/**
 * This constructs and configures a theme using the file at the provided path.
 * @param {NSString*} the literal path of the theme file.
 * @returns {instancetype}
 */
- (instancetype) initWithFileAtPath:(NSString*) path;

/**
 * This constructs and configures a theme using the provided configuration object
 * @param {NSDictionary*} the config object to create the theme with.
 * @returns {instancetype}
 */
- (instancetype) initWithConfiguration:(NSDictionary*) config;

@end

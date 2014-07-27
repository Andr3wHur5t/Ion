//
//  IonTheme.h
//  Ion
//
//  Created by Andrew Hurst on 7/16/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <IonData/IonKVPAccessBasedGenerationMap.h>
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
 * This constructs and cofigures a theme using the file at the provided path.
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



#pragma mark External Interface

/**
 * This gets the style for the inputted view.
 * @param {UIView*} the view to get the style for the view.
 * @param {IonStyle*] will return the net style
 */
- (IonStyle*) styleForView: (UIView*)view;

/**
 * This compiles the theme into a style class for the sepecified view.
 * @param {NSString*} the theme class to look for; Can Be NULL if other provided
 * @param {NSString*} the theme id to look for; Can Be NULL if other provided
 * @returns {IonStyle*} will returned the style
 */
- (IonStyle*) styleForThemeClass:(NSString*) themeClass andThemeID:(NSString*) themeID;

/**
 * This gets the style for the inputted element name.
 * @param {NSString*} the element name to search for
 * @retutns {IonStyle*}
 */
- (IonStyle*) styleForElementName:(NSString*) name;


#pragma mark Internal Interface

/**
 * This gets the style for the inputted class name.
 * @param {NSString*} the class name to search for
 * @retutns {IonStyle*}
 */
- (IonStyle*) styleForClassName:(NSString*) className;

/**
 * This gets the style for the inputted id name.
 * @param {NSString*} the class ID to search for.
 * @retutns {IonStyle*}
 */
- (IonStyle*) styleForIdName:(NSString*) idName;

/**
 * This compiles an ID style and a Class style into one style, if both are NULL it will return the default style;
 * @param {IonStyle*} the class style to composite
 * @param {IonStyle*} the id style to composite
 * @returns {IonStyle*} the resulting style
 */
- (IonStyle*) styleFromCompositedClassStyle:(IonStyle*) classStyle andIdStyle:(IonStyle*) idStyle;

/**
 * This gets the current defualt style.
 * @returns {IonStyle*} the current default style.
 */
- (IonStyle*) currentDefaultStyle;

@end

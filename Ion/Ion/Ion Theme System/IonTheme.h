//
//  IonTheme.h
//  Ion
//
//  Created by Andrew Hurst on 7/16/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IonThemeAttributes.h"

@interface IonTheme : NSObject

/* Atomic so we can do multi-threaded searches
 */
@property (strong) IonThemeAttributes* attributes;

#pragma mark Construction
/**
 * This will construct a theme with the provided name from application resources.
 */
- (instancetype) initWithFileName:(NSString*) fileName;

- (instancetype) initWithFileAtPath:(NSString*)path;

#pragma mark External Interface

/**
 * This compiles the theme into a style class for the sepecified view.
 */
- (IonStyle*) styleForThemeClass:(NSString*) themeClass andThemeID:(NSString*) themeID;


#pragma mark Internal Interface

/**
 * This gets the style for the inputed id name.
 * @param {NSString*} the class ID to search for.
 * @retutns {IonStyle*}
 */
- (IonStyle*) styleForIdName:(NSString*) idName;

/**
 * This gets the style for the inputed class name.
 * @param {NSString*} the class name to search for
 * @retutns {IonStyle*}
 */
- (IonStyle*) styleForClassName:(NSString*) className;

/**
 * This compiles an ID style and a Class style into one style, if both are NULL it will return the default style;
 * @param {IonStyle*} the class style to composite
 * @param {IonStyle*} the id style to composite
 * @returns {IonStyle*} the resulting style
 */
- (IonStyle*) styleFromCompositedClassStyle:(IonStyle*)classStyle andIdStyle:(IonStyle*)idStyle;

/**
 * This gets the current defualt style.
 * @returns {IonStyle*} the current default style.
 */
- (IonStyle*) currentDefaultStyle;



@end

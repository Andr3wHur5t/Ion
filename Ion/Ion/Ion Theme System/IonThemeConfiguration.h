//
//  IonThemeConfiguration.h
//  Ion
//
//  Created by Andrew Hurst on 7/23/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IonTheme.h"
#import "IonStyle.h"

@interface IonThemeConfiguration : NSObject


/**
 * The theme element type identifier
 */
@property (strong, nonatomic) NSString* themeElement;

/**
 * The theme class identifier
 */
@property (strong, nonatomic) NSString* themeClass;

/**
 * The theme ID identifier
 */
@property (strong, nonatomic) NSString* themeID;

#pragma mark State Object
/**
 * The current theme.
 */
@property (strong, nonatomic) IonTheme* currentTheme;

/**
 * The current style.
 */
@property (strong, nonatomic) IonStyle* currentStyle;

/**
 * States weither we should apply the theme to ourself.
 */
@property (assign, nonatomic) BOOL themeShouldBeAppliedToSelf;

@end

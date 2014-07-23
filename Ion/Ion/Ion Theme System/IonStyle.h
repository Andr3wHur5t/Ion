//
//  IonStyle.h
//  Ion
//
//  Created by Andrew Hurst on 7/16/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IonMethodMap.h"


@class IonKVPAccessBasedGenerationMap;
@class IonTheme;

@interface IonStyle : NSObject
#pragma mark proprieties


/**
 * This is our method map of what to invoke for each style configuration propriety; TODO: move to a singleton!
 */
@property (strong, nonatomic) IonMethodMap* proprietyMethodMap;

/** Our configuration parameters
 */
@property (strong, nonatomic) NSMutableDictionary* configuration;

/** The theme attributes we will resolve with.
 */
@property (strong, nonatomic) IonTheme* theme;

/** Our parent theme, if any...
 * Note: this only applies to themes which are derived from themes.
 */
@property (strong, nonatomic) IonStyle* parentStyle;

#pragma mark External Interface

/**
 * This will resolve a style using a map and an Attribute Set.
 * @param {NSDictionary*} the map to process
 * @param {IonThemeAttributes*} the theme attributes set to do our searches on if needed.
 * @returns {UIColor*} representation, or NULL of invalid
 */
+ (IonStyle*) resolveWithMap:(NSDictionary*) map andAttributes:(IonKVPAccessBasedGenerationMap*) attributes;

/**
 * This applies the current style to the inputted view.
 * @param {UIView*} the view to apply the style to.
 * @returns {void}
 */
- (void) applyToView:(UIView*)view;


/**
 * returnes a copy of our configuration overwriten by the inputted configuration.
 * @param {NSDictionary*} the configuration which will overwrite.
 * @returns {NSDictionary*} an overwriten ditcionary, or NULL if invalid.
 */
- (NSDictionary*) configurationOverwritenBy:(NSDictionary*) configuration;

/**
 * This overrides the current styles proprieties  with the inputed style.
 * @param {IonStyle*} the style to override the current style
 * @returns {IonStyle*} the net style of the override
 */
- (IonStyle*) overrideStyleWithStyle:(IonStyle*)overridingStyle;

/**
 * This sets the attributes that we should resolve with.
 * @param {IonThemeAttributes*} the attribute we should resolve with.
 * @returns {void}
 */
- (void) setResolutionAttributes:(IonKVPAccessBasedGenerationMap*) attributes;
@end

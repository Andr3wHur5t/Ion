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

@interface IonStyle : NSObject
#pragma mark proprieties

/**
 * This is our method map of what to invoke for each style configuration propriety.
 */
@property (strong, nonatomic) IonMethodMap* proprietyMethodMap;

/** This is the config that states what we are.
 */
@property (strong, nonatomic) NSMutableDictionary* config;

/** This are the attributes we will resolve with.
 */
@property (strong, nonatomic) IonKVPAccessBasedGenerationMap* attributes;

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

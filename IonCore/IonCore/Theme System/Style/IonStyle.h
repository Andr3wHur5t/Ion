//
//  IonStyle.h
//  Ion
//
//  Created by Andrew Hurst on 7/16/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IonData/IonData.h>

/**
 * Keys
 */
static NSString* sIonTheme_StyleChildren = @"children";
static NSString* sIonTheme_StyleElement = @"";
static NSString* sIonTheme_StyleClass = @"cls_";
static NSString* sIonTheme_StyleId = @"id_";

@class IonKVPAccessBasedGenerationMap;
@class IonTheme;
@class IonStyle;


@protocol IonThemeSpecialUIView <NSObject>

/**
 * Applys The Style to self.
 * @param style - the style to apply to the view.
 */
- (void) applyStyle:(IonStyle*) style;

@end


@interface IonStyle : NSObject
#pragma mark proprieties

/**
 * Constructs a style using a dictionary configuatation.
 * @param dict - configuration
 */
- (instancetype) initWithDictionary:(NSDictionary *)dict;

/**
 * This is our method map of what to invoke for each style configuration propriety; TODO: move to a singleton!
 */
@property (strong, nonatomic) IonMethodMap *proprietyMethodMap;

/** Our configuration parameters
 */
@property (strong, nonatomic) NSMutableDictionary *configuration;

/** The theme attributes we will resolve with.
 */
@property (strong, nonatomic) IonTheme *theme;

/** Our parent theme, if any...
 * Note: this only applies to themes which are derived from themes.
 */
@property (strong, nonatomic) IonStyle *parentStyle;

#pragma mark External Interface

/**
 * Constructs a style using a dictionary configuatation.
 * @param dict - configuration
 * @param attributes - the attributes we should resolve with.
 */
- (instancetype) initWithDictionary:(NSDictionary *)dict andResolutionAttributes:(IonTheme *)attributes;

/**
 * This will resolve a style using a map and an Attribute Set.
 * @param map - the map to process
 * @param attributes the theme attributes set to do our searches on if needed.
 */
+ (IonStyle*) resolveWithMap:(NSDictionary *)map andAttributes:(IonKVPAccessBasedGenerationMap *)attributes;

/**
 * Sets the attributes that we should resolve with.
 * @param attributes - the attribute we should resolve with.
 */
- (void) setResolutionAttributes:(IonKVPAccessBasedGenerationMap*) attributes;

/**
 * This applies the current style to the inputted view.
 * @param view - the view to apply the style to.
 */
- (void) applyToView:(UIView *)view;


#pragma mark Children Retrieval

/**
 * Gets the style that corisponds to the inputted View.
 * @param view - the view to get the style for.
 * @return {IonStyle*} the resulting style
 */
- (IonStyle *)styleForView:(UIView *)view;

/**
 * Gets the substyle for the specified key.
 * @param key - the key for the style to retrive.
 */
- (IonStyle *)childStyleForKey:(NSString*) key;

#pragma mark Utilities

/**
 * Overrides the current styles proprieties  with the inputed style.
 * @param overridingStyle - the style to override the current style.
 */
- (IonStyle *)overrideStyleWithStyle:(IonStyle *)overridingStyle;

/**
 * Comparison of styles.
 * @param style - the style to be compared.
 */
- (BOOL) isEqualToStyle:(IonStyle *)style;

@end

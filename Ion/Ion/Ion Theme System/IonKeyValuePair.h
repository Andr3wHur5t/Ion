//
//  IonKeyValuePair.h
//  Ion
//
//  Created by Andrew Hurst on 7/18/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IonStyle;
@class IonGradientConfiguration;
@class IonImageRef;

@class IonThemeAttributes;

@interface IonKeyValuePair : NSObject

/**
 * This is where we hold the KVP value
 */
@property (strong, nonatomic) id value;

/**
 * This is where we hold the parent attributes refrence.
 */
@property (strong, nonatomic) IonThemeAttributes* attributes;

/**
 * This will resolve a KVP object using a map and an Attrbute Set.
 * @param {id} the value to process
 * @param {IonThemeAttributes*} the theme attrubute set to do our searches on if needed.
 * @returns {IonKeyValuePair*} representation, or NULL of invalid
 */
+ (IonKeyValuePair*) resolveWithValue:(id) value andAttrubutes:(IonThemeAttributes*) attributes;

#pragma Conversions

/**
 * This gets the string form of our value.
 * @returns {NSString*} representation, or NULL if incorect type.
 */
- (NSString*) toString;

/**
 * This gets the NSNumber form of our value.
 * @returns {NSNumber*} representation, or NULL if incorect type.
 */
- (NSNumber*) toNumber;

/**
 * This gets the NSDictionary form of our value.
 * @returns {NSDictionary*} representation, or NULL if incorect type.
 */
- (NSDictionary*) toDictionary;

/**
 * This gets the BOOL form of our value.
 * @returns {BOOL} representation, or NO if incorect type.
 */
- (BOOL) toBOOL;

/**
 * This gets the UIColor form of our value.
 * @returns {UIColor*} representation, or NULL if incorect type.
 */
- (UIColor*) toColor;

/**
 * This gets the IonImageRef form of our value.
 * @returns {IonImageRef*} representation, or NULL if incorect type.
 */
- (IonImageRef*) toImageRef;

/**
 * This gets the IonGradientConfiguration form of our value.
 * @returns {IonGradientConfiguration*} representation, or NULL if incorect type.
 */
- (IonGradientConfiguration*) toGradientConfiguration;

/**
 * This gets the IonStyle form of our value.
 * @returns {IonStyle*} representation, or NULL if incorect type.
 */
- (IonStyle*) toStyle;


@end

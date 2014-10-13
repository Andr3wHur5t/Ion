//
//  IonThemePointer.h
//  Ion
//
//  Created by Andrew Hurst on 7/18/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IonThemeAttributes;
@class IonKeyValuePair;
@class IonKVPAccessBasedGenerationMap;

@interface IonThemePointer : NSObject

/**
 * This resolves pointers into objects
 * @param {NSDictionary*} representation of a valid pointer.
 * @param {IonThemeAttributes*} the attrubute we should resolve with.
 * @returns {IonKeyValuePair} the resulting object, or NULL if invalid.
 */
+ (IonKeyValuePair*) resolvePointer:(NSDictionary*) pointer withAttributes:(IonKVPAccessBasedGenerationMap*) attributes;

/**
 * This creates a theme pointer which can be resolved latter.
 * @param {NSDictionary*} the map to configure our self with.
 * @param {IonThemeAttributes*} the attrbutes object to reslove with.
 * @returns {instancetype}
 */
- (instancetype) initWithMap:(NSDictionary*) map andAttrubutes:(IonKVPAccessBasedGenerationMap*) attributes;


/**
 * This will set our target with the inputed map.
 * @param {NSDictionary*} the map to configure our self with.
 
 */
- (void) setTargetWithMap:(NSDictionary*) map;

/**
 * This will resolve the pointer into a KVP
 * @return {IonKeyValuePair}
 */
- (IonKeyValuePair*) resolve;

@end

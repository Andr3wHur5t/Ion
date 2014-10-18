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
 * @param pointer - representation of a valid pointer.
 * @param attributes - the attrubute we should resolve with.
 * @return the resulting object, or NULL if invalid.
 */
+ (IonKeyValuePair*) resolvePointer:(NSDictionary *)pointer withAttributes:(IonKVPAccessBasedGenerationMap *)attributes;

/**
 * This creates a theme pointer which can be resolved latter.
 * @param map - the map to configure our self with.
 * @param attributes - the attrbutes object to reslove with.
 */
- (instancetype) initWithMap:(NSDictionary *)map andAttrubutes:(IonKVPAccessBasedGenerationMap *)attributes;


/**
 * This will set our target with the inputed map.
 * @param map - the map to configure our self with.
 */
- (void) setTargetWithMap:(NSDictionary*) map;

/**
 * This will resolve the pointer into a KVP
 */
- (IonKeyValuePair*) resolve;

@end

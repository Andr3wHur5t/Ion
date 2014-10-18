//
//  IonAnimationMap.h
//  Ion
//
//  Created by Andrew Hurst on 9/20/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IonPath;
@class IonAnimationFrame;

static NSString* sIonAnimationFileExtension = @".animation";
static NSString* sIonAnimationMap_FramesKey = @"transformations";

@interface IonAnimationMap : NSObject
#pragma mark Construction
/**
 * Constructs the map with the inputted dictionary.
 * @param {NSDictionary*} the configuration dictionary  
 */
- (instancetype) initWithDictionary:(NSDictionary *)dict;

/**
 * Constructs witht the inputted name as the file name in the bundel.
 * @param {NSString*} the key for the name in the bundel.  
 */
- (instancetype) initWithName:(NSString *)name;

/**
 * Constructs the the inputted path.
 * @param {IonPath*} the path of the animation configuration file.  
 */
- (instancetype) initWithPath:(IonPath *)path;

#pragma mark Frame Retrieval
/**
 * Gets the frame for the inputted key.
 * @param {NSString*} the key for the frame.
 * @return {IonAnimationFrame}
 */
- (IonAnimationFrame *)frameForKey:(NSString *)key;

#pragma mark Cache Methods
/**
 * Cache of all loaded maps.
 * @param {NSString*} the name for the specified cache.
 * @return {IonAnimationMap*}
 */
+ (IonAnimationMap *)mapForName:(NSString *)name;

/**
 * Adds an animation map to the cache.
 * @param {NSString*} the name to add the map for.
 * @param {IonAnimationMap*} the map to add to the cache.
 */
+ (void) addMapToCache:(IonAnimationMap *)map withName:(NSString *)name;

/**
 * Removes the map for the specified name.
 * @param {NSString*} the name to remove.
 */
+ (void) removeMapFromCacheWithName:(NSString *)name;

/**
 * The cache object.
 * @return {NSMutableDictionary*}
 */
+ (NSMutableDictionary *)cache;

@end
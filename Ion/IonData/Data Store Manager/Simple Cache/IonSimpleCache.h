//
//  IonSimpleCache.h
//  Ion
//
//  Created by Andrew Hurst on 7/26/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IonAsyncAccessBasedGenerationMap.h"

@class IonPath;
@class IonDirectory;
@class IonFile;
@class IonSimpleCache;


static BOOL sIonCacheManifestWillPersist = TRUE;

/** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
 *                                         Simple Cache
 *  = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = */

/**
 * The Fundmental Request Cache Mechanism.
 */
@interface IonSimpleCache : IonAsyncAccessBasedGenerationMap
#pragma mark Constructors

/**
 * Constructs the cache at the inputted path.
 * @param {IonCompletionBlock} the completion thats called once the manifest is loaded.
 * @param {IonPath} the path to construct at.
 * @returns {instancetype}
 */
- (instancetype) initAtPath:(IonPath*) path withLoadCompletion:(IonCompletionBlock) manifestLoadCompletion;

/**
 * Constructs a cache in the caches directory with the specified name.
 * @param {NSString*} the cache directory name.
 * @param {IonCompletionBlock} the completion thats called once the manifest is loaded.
 * @returns {instancetype}
 */
- (instancetype) initWithName:(NSString*) name withLoadCompletion:(IonCompletionBlock) manifestLoadCompletion;

/**
 * Constructs a cache in the caches directory with the specified name.
 * @param {NSString*} the cache directory name.
 * @returns {instancetype}
 */
- (instancetype) initWithName:(NSString*) name;

/**
 * Constructs the cache at the inputted path.
 * @param {IonPath} the path to construct at.
 * @param {IonCompletionBlock} the completion thats called once the manifest is loaded.
 * @returns {IonSimpleCache*}
 */
+ (IonSimpleCache*) cacheAtPath:(IonPath*) path withLoadCompletion:(IonCompletionBlock) manifestLoadCompletion;

/**
 * Constructs a cache in the caches directory with the specified name.
 * @param {NSString*} the cache directory name.
 * @param {IonCompletionBlock} the completion thats called once the manifest is loaded.
 * @returns {IonSimpleCache}
 */
+ (IonSimpleCache*) cacheWithName:(NSString*) cacheName
               withLoadCompletion:(IonCompletionBlock) manifestLoadCompletion;

/**
 * Constructs a cache in the cache directory with the specified name.
 * @param {NSString*} the cache directory name.
 
 */
+ (IonSimpleCache*) cacheWithName:(NSString*) cacheName;

#pragma mark Proprieties
/**
 * States if the cache will persist to the next session.
 * Note: You Can clear all created caches by constructing a session with
 */
@property (assign, nonatomic) BOOL manifestWillPersist;

#pragma mark Manaifest Management

/**
 * Gets the manifest path.
 * @returns {IonPath} the manifests full path.
 */
- (IonPath*) manifestPath;

/**
 * Loads the cache manifest from the file system.
 * @param {IonCompletionBlock} the completion block to call.
 
 */
- (void) loadManifest:(IonCompletionBlock) completion;

/**
 * Saves the cache manifest to the file system.
 * @param {IonCompletionBlock} the completion block to call.
 
 */
- (void) saveManifest:(IonCompletionBlock) completion;
/**
 * Deletes the cache manifest from the file system.
 * @param {IonCompletionBlock} the completion block to call.
 
 */
- (void) deleteManifest:(IonCompletionBlock) completion;

#pragma mark Manifest Minipulation

/**
 * Gets the extra info for the specified item key.
 * @param {NSString*} the key to get the object for.
 * @returns {NSDictionary*} the current extra info object.
 */
- (NSDictionary*) extraInfoForItemWithKey:(NSString*) key;
/**
 * Sets the extra info for the specified item key.
 * @param {NSString*} the key to get the object for.
 * @param {NSDictionary*} the extra info object to set.
 
 */
- (void) setExtraInfo:(NSDictionary*) extraInfo ForItemWithKey:(NSString*) key;


#pragma mark Cache Management

/**
 * Sets an item to the specified key and forces it in the memory cache.
 * @param {NSString*} the key for the object to set.
 * @param {id} the object to put in the data system.
 * @param {IonRawDataSourceCompletion} the completion.
 
 */
- (void) setObject:(id) object forKeyInMemory:(NSString*) key withCompletion:(IonRawDataSourceCompletion) completion;


/**
 * Finished Current Tasks Callback.
 * @peram {void(^)( )} the callback.
 
 */
- (void) tasksDidComplete:(void(^)( )) completion;

@end

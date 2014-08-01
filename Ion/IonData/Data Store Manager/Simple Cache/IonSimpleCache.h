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

/**
 * The data result callback.
 * @param {id} the resulting object
 * @returns {void}
 */
typedef void(^IonResultCallback)( id result );

/**
 * The sub-cache result callback.
 * @param {IonSimpleCache*} the resulting sub-cache
 * @returns {void}
 */
typedef void(^IonSubCacheResultCallback)( IonSimpleCache* result );

/**
 * The completion callback.
 * @returns {void}
 */
typedef void(^IonCompletionCallback)( );


/**
 * The Fundmental Request Cache Mechnisim.
 */
@interface IonSimpleCache : NSObject
#pragma mark Constructors

/**
 * Constructs the cache at the inputted path.
 * @param {IonPath} the path to construct at.
 * @returns {instancetype}
 */
- (instancetype) initAtPath:(IonPath*) path;

#pragma mark Proprieties

/**
 * The directory which the cache resides.
 */
@property (strong, readonly) IonDirectory* directory;

/**
 * The update rate of the expiration check timer.
 * Note: this should be a Infrequent check, once every hour would be good.
 */
@property (assign, nonatomic) double expirationCheckFrequency;


#pragma mark Data Retrieval Management

/**
 * Gets the file for the specified key.
 * @param {NSString*} the key to get the data from.
 * @param {IonResultCallback} the callback to get the results from.
 * @returns {void}
 */
- (void) getDataForKey:(NSString*) key withResultCallback:(IonResultCallback) resultCallback;

/**
 * Sets the file in the cache, with the file name as the key.
 * @param {IonFile*} the file to add to the cache.
 * @param {IonCompletionCallback}
 * @returns {void}
 */
- (void) setFileInCache:(IonFile*) file withCompletion:(IonCompletionCallback) completion;

/**
 * Removes the file for the specified key.
 * @param {NSString*} the key to remove the file for.
 * @param {IonCompletionCallback} the completion.
 * @returns {void}
 */
- (void) removeFileForKey:(NSString*) key withCompletion:(IonCompletionCallback) completion;

/**
 * Sets the expiration of a cached file using the key as the identifier.
 * @param {NSDate*} the expiration of the cache file, NULL meaning the file wont expire.
 * @param {NSString*} the key of the file to set the expiration of.
 * @returns {void}
 */
- (void) setFileExpiration:(NSDate*) expiration withKey:(NSString*) key;

/**
 * This force checks the files for expiration.
 * @returns {void}
 */
- (void) checkFilesForExpiration;

#pragma mark Cache Management

/**
 * Removes the file with the specified key from the memory (RAM) cache.
 * @param {NSString*} the key to be removed from the memory cache.
 * @param {IonCompletionCallback} the completion to call.
 * @returns {void}
 */
- (void) removeFileFromMemoryCacheWithKey:(NSString*) key;

/**
 * Clears the memory (RAM) cache.
 * @returns {void}
 */
- (void) clearMemoryCache;

/**
 * Clears the storage (HDD) cache.
 * @returns {void}
 */
- (void) clearStorageCache;

#pragma mark Conversions

/**
 * Converts the inputted key to the correct format.
 * @param {NSString*} the key to be converted.
 * @returns {NSString*} the string in the correct format, or NULL if invalid.
 */
+ (NSString*) convertKey:(NSString*) key;

#pragma mark Singletons
/**
 * The cache dispatch queue.
 * @returns {dispatch_queue_attr_t}
 */
+ (dispatch_queue_t) cacheDispatchQueue;

@end

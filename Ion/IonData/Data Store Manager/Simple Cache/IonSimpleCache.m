//
//  IonSimpleCache.m
//  Ion
//
//  Created by Andrew Hurst on 7/26/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonSimpleCache.h"
#import "IonCacheItemStats.h"
#import "IonDirectory.h"
#import "IonFile.h"


/**
 * The Cache Dispatch Queue label.
 */
static const char* sCacheDispatchQueueLabel = "ION_CACHE_DISPATCH_LABEL";


/** ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== =====
 *                                      Private Interface
 *  ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== */
@interface IonSimpleCache ()

/**
 * The Dictionary of access statistics, and file system paths.
 */
@property (strong) NSMutableDictionary* keyStats;

/**
 * The memory (RAM) cache, where we store our in memory cache data.
 */
@property (strong) NSMutableDictionary* memoryCache;

@end


/** ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== =====
 *                                      Implementation
 *  ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== */
@implementation IonSimpleCache
#pragma mark Constructors

/**
 * The standard constructor.
 * @returns {instancetype}
 */
- (instancetype) init {
    self = [super init];
    if ( self ) {
        _keyStats = [[NSMutableDictionary alloc] init];
        _memoryCache = [[NSMutableDictionary alloc] init];
    }
    return self;
}

/**
 * Constructs the cache at the inputted path.
 * @param {IonPath} the path to construct at.
 * @returns {instancetype}
 */
- (instancetype) initAtPath:(IonPath*) path {
    self = [self init];
    if ( self )
        _directory = [[IonDirectory alloc] initWithPath: path];
    
    return self;
}


#pragma mark Data Retrieval Management

/**
 * Gets the file for the specified key.
 * @param {NSString*} the key to get the data from.
 * @param {IonResultCallback} the callback to get the results from.
 * @returns {void}
 */
- (void) getDataForKey:(NSString*) key withResultCallback:(IonResultCallback) resultCallback {
    __block NSString *convertedKey, *filePath;
    __block id memCacheData, keyStatsData, fileData;
    
    if ( !key || ![key isKindOfClass: [NSString class]] || !resultCallback || !self.directory )
        return;
    
    // Convert the key
    convertedKey = [IonSimpleCache convertKey: key];
    if ( !convertedKey )
        return;
    
    dispatch_async( [IonSimpleCache cacheDispatchQueue] , ^{
        // Check memory cache for the data
        memCacheData = [self.memoryCache objectForKey: convertedKey];
        if ( memCacheData ) {
            dispatch_async( dispatch_get_main_queue(), ^{
                resultCallback( memCacheData );
            });
            return;
        }
        
        // Check For the keys data in key stats
        keyStatsData = [self.keyStats objectForKey: convertedKey];
        if ( keyStatsData && [keyStatsData isKindOfClass: [IonCacheItemStats class]] ) {
            // We found the key update stats, and get the file name so we can open the file.
            filePath = keyStatsData;
            if ( !filePath || ![filePath isKindOfClass: [NSString class]] )
                return;
            
            // Open the file path in the current directory
            [self.directory openFile: filePath withResultBlock:^(IonFile *file) {
                fileData = file.content;
                if ( !fileData )
                    return;
                
                // We are already in main, report data.
                resultCallback ( fileData );
                [(IonCacheItemStats*)keyStatsData incrementsRequestCount];
                
                //Cache the data if we need to
                if ( ![(IonCacheItemStats*)keyStatsData dataShouldBeCached] )
                    return;
                
                // Cache data async
                dispatch_async( [IonSimpleCache cacheDispatchQueue] , ^{
                    [self.memoryCache setObject: fileData forKey: convertedKey];
                });
            }];
        }
    });
}

/**
 * Sets a file in the cache, with the file name as the key.
 * @param {IonFile*} the file to add to the cache.
 * @param {IonCompletionCallback}
 * @returns {void}
 */
- (void) setFileInCache:(IonFile*) file withCompletion:(IonCompletionCallback) completion {
    NSString* key;
    IonCacheItemStats* stats;
    if ( !file || ![file isKindOfClass: [IonFile class]] )
        return;
    
    // Construct
    stats = [[IonCacheItemStats alloc] initWithFile: file];
    key = [IonSimpleCache convertKey: file.name];
    
    // Add
    [self.keyStats setObject: stats forKey: key];
    [self.memoryCache removeObjectForKey: key];
    [self.directory saveFile: file withCompletion: ^(NSError *error) {
        if ( !error && completion )
            completion();
    }];
}

/**
 * Removes the file for the specified key.
 * @param {NSString*} the key to remove the file for.
 * @param {IonCompletionCallback} the completion.
 * @returns {void}
 */
- (void) removeFileForKey:(NSString*) key withCompletion:(IonCompletionCallback) completion {
    NSString* convertedKey;
    if ( !key || ![key isKindOfClass: [NSString class]] )
        return;
    
    // Convert
    convertedKey = [IonSimpleCache convertKey: key];
    
    // Remove
    [self.keyStats removeObjectForKey: key];
    [self.memoryCache removeObjectForKey: key];
    [self.directory deleteItem:key withCompletion: ^(NSError *error) {
        if ( !error && completion )
            completion();
    }];
}

/**
 * Sets the expiration of a cached file using the key as the identifier.
 * @param {NSDate*} the expiration of the cache file, NULL meaning the file wont expire.
 * @param {NSString*} the key of the file to set the expiration of.
 * @returns {void}
 */
- (void) setFileExpiration:(NSDate*) expiration withKey:(NSString*) key {
    __block NSString* convertedKey;
    __block IonCacheItemStats* item;
    if ( !expiration || ![expiration isKindOfClass: [NSDate class]] ||
         !key || ![key isKindOfClass: [NSString class]] )
        return;
    
    convertedKey = [IonSimpleCache convertKey: key];
    dispatch_async( [IonSimpleCache cacheDispatchQueue], ^{
        item = [self.keyStats objectForKey: convertedKey];
        if ( !item || ![item isKindOfClass: [IonCacheItemStats class]] )
            return;
        if ( [expiration timeIntervalSince1970] <= [[NSDate date] timeIntervalSince1970] )
            [self removeFileForKey: key withCompletion: NULL];
        else {
            item.experationDate = expiration;
            [self.keyStats setObject: item forKey: convertedKey];
        }
    });
}

/**
 * This force checks the files for expiration.
 * @returns {void}
 */
- (void) checkFilesForExpiration {
    dispatch_async( [IonSimpleCache cacheDispatchQueue], ^{
        __block NSDate* currentDate = [NSDate date];
        __block IonCacheItemStats* currentStats;
        
        [self.keyStats enumerateKeysAndObjectsUsingBlock: ^(id key, id obj, BOOL *stop) {
            if ( !obj || ![obj isKindOfClass: [IonCacheItemStats class]] )
                return;
            currentStats = obj;
            
            // Remove it if its old...
            if ( [currentStats.experationDate timeIntervalSince1970] >= [currentDate timeIntervalSince1970] )
                [self removeFileForKey: key withCompletion: NULL];
            
            // Clean Up
            currentStats = NULL;
        }];
    });
}

#pragma mark Cache Management

/**
 * Removes the file with the specified key from the memory (RAM) cache.
 * @param {NSString*} the key to be removed from the memory cache.
 * @param {IonCompletionCallback} the completion to call.
 * @returns {void}
 */
- (void) removeFileFromMemoryCacheWithKey:(NSString*) key {
    __block NSString* convertedKey;
    if ( !key || ![key isKindOfClass: [NSString class]] )
        return;
    dispatch_async( [IonSimpleCache cacheDispatchQueue], ^{
        // Convert
        convertedKey = [IonSimpleCache convertKey: key];
    
        // Remove
        [self.memoryCache removeObjectForKey: convertedKey];
    });
}

/**
 * Clears the memory (RAM) cache.
 * @returns {void}
 */
- (void) clearMemoryCache {
    dispatch_async( [IonSimpleCache cacheDispatchQueue], ^{
        [self. memoryCache removeAllObjects];
    });
}

/**
 * Clears the storage (HDD) cache.
 * @returns {void}
 */
- (void) clearStorageCache {
    // Delete the current durrectory... this is already a async operation...
}

#pragma mark Sub Caches

/**
 * Gets a sub-cache with the specified key.
 * @param {NSString*} the key of the sub-cache to get.
 * @param {IonSubCacheResultCallback} the return callback to call with the result.
 * @return {void}
 */
- (void) getSubCacheWithKey:(NSString*) key andResultCallback:(IonSubCacheResultCallback*) resultCallback {
    
}

/**
 * Adds a sub-cache with the specified key as the directory name.
 * @param {NSString*} the key to have the sub-cache linked to.
 * @param {IonSubCacheResultCallback} the rerun callback to call with the result.
 * @returns {void}
 */
- (void) addSubCacheWithKey:(NSString*) key andResultCallback:(IonSubCacheResultCallback*) resultCallback {
    
}

/**
 * Removes the cache with the specified key.
 * @param {NSString*} the key of the cache to remove.
 * @param {IonCompletionCallback} the completion call back to call.
 * @retrurns {void}
 */
- (void) removeSubCacheWithKey:(NSString*) key withCompletion:(IonCompletionCallback) completion {
    
}

#pragma mark Conversions

/**
 * Converts the inputted key to the correct format.
 * @param {NSString*} the key to be converted.
 * @returns {NSString*} the string in the correct format, or NULL if invalid.
 */
+ (NSString*) convertKey:(NSString*) key {
    NSRegularExpression* expression;
    NSString* resultString;
    if ( !key || ![key isKindOfClass: [NSString class]] )
        return NULL;
    
    resultString = @"";
    // Create Expression
    expression = [[NSRegularExpression alloc] initWithPattern: @"[^a-zA-Z0-9 ]+"
                                                      options: 0
                                                        error: NULL];
    
    // Evaluate
    resultString = [expression stringByReplacingMatchesInString: key
                                         options: 0
                                           range: NSMakeRange(0, key.length)
                                    withTemplate: @"-"];
    
    return resultString;
}


#pragma mark Singletons
/**
 * The cache dispatch queue.
 * @returns {dispatch_queue_t}
 */
+ (dispatch_queue_t) cacheDispatchQueue {
    static dispatch_queue_t cacheDispatchQueue;
    static dispatch_once_t cacheDispatchQueue_OnceToken;
    
    dispatch_once( &cacheDispatchQueue_OnceToken, ^{
        cacheDispatchQueue = dispatch_queue_create( sCacheDispatchQueueLabel, NULL );
    });
    
    return cacheDispatchQueue;
}
@end

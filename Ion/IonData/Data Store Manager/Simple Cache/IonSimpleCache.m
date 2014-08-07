//
//  IonSimpleCache.m
//  Ion
//
//  Created by Andrew Hurst on 7/26/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonSimpleCache.h"
#import "NSData+IonTypeExtension.h"
#import "NSDictionary+IonTypeExtension.h"
#import "IonCacheItemStats.h"
#import "IonFileIOmanager.h"
#import "IonDirectory.h"



#define IonCacheManifestFileName @"cache.manifest"


/** ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== =====
 *                                      Private Interface
 *  ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== */
@interface IonSimpleCache () {
    IonPath* _path;
    BOOL mainfestHasBeenLoaded;
}

/**
 * The session persistent manifest of all data related to the cache.
 */
@property (strong) NSMutableDictionary* manifest;

@end




/** ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== =====
 *                                      Implementation
 *  ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== */
@implementation IonSimpleCache
#pragma mark Constructors

/**
 * Constructs the cache at the inputted path.
 * @param {IonCompletionBlock} the completion thats called once the manifest is loaded.
 * @param {IonPath} the path to construct at.
 * @returns {instancetype}
 */
- (instancetype) initAtPath:(IonPath*) path withLoadCompletion:(IonCompletionBlock) manifestLoadCompletion {
    _path = [IonPath pathFromPath: path];
    self = [super initWithDataSource: [IonDirectory directoryWithPath: _path]];
    if ( self ) {
        [self configureObjects];
        [self loadManifest: manifestLoadCompletion];
    }
    return self;
}

/**
 * Constructs the cache at the inputted path.
 * @param {IonPath} the path to construct at.
 * @param {IonCompletionBlock} the completion thats called once the manifest is loaded.
 * @returns {IonSimpleCache*}
 */
+ (IonSimpleCache*) cacheAtPath:(IonPath*) path withLoadCompletion:(IonCompletionBlock) manifestLoadCompletion {
    return [[IonSimpleCache alloc] initAtPath: path withLoadCompletion: manifestLoadCompletion];
}

/**
 * Constructs a cache in the caches directory with the specified name.
 * @param {NSString*} the cache directory name.
 * @param {IonCompletionBlock} the completion thats called once the manifest is loaded.
 * @returns {IonSimpleCache}
 */
+ (IonSimpleCache*) cacheWithName:(NSString*) cacheName withLoadCompletion:(IonCompletionBlock) manifestLoadCompletion {
    IonPath* cachePath = [[IonPath cacheDirectory] pathAppendedByElement: cacheName];
    return [[IonSimpleCache alloc] initAtPath: cachePath withLoadCompletion: manifestLoadCompletion];
}

/**
 * Constructs a cache in the cache directory with the specified name.
 * @param {NSString*} the cache directory name.
 * @returns {void}
 */
+ (IonSimpleCache*) cacheWithName:(NSString*) cacheName {
    return [IonSimpleCache cacheWithName: cacheName withLoadCompletion: NULL];
}

#pragma mark Constructor Utilities

/**
 * The base post construction method.
 * @returns {void}
 */
- (void) configureObjects {
    mainfestHasBeenLoaded = FALSE;
    _manifestWillPersist = sIonCacheManifestWillPersist;
    [self constructManifest];
}

#pragma mark Deconstructs

/**
 * The deconstruction function.
 * @returns {void}
 */
- (void)dealloc {
    __block IonPath* manifestPath = [self manifestPath];
    if ( _manifestWillPersist )
        [self saveManifest: ^(NSError *error) {
            if ( !error )
                NSLog( @"Saved Cache Manifest At '%@' ", manifestPath );
        }];
    else
        [self deleteManifest: ^(NSError *error) {
           if ( !error )
               NSLog( @"Deleted Cache Manifest At '%@' ", manifestPath );
        }];
}

#pragma mark Cache Management

/**
 * Deletes the entire cache directory.
 * @param {IonCompletionBlock} the completion block to call.
 * @returns {void}
 */
- (void) deleteWithCompletion:(IonCompletionBlock) completion {
    [IonFileIOmanager deleteItem: _path withCompletion: completion];
}

#pragma mark Manifest Management

/**
 * The Manifest Construction Function.
 * @returns {void}
 */
- (void) constructManifest {
    _manifest = [[NSMutableDictionary alloc] init];
}

/**
 * Gets the manifest path.
 * @returns {IonPath} the manifests full path.
 */
- (IonPath*) manifestPath {
    return [_path pathAppendedByElement: IonCacheManifestFileName];
}

/**
 * Loads the cache manifest from the file system.
 * @param {IonCompletionBlock} the completion block to call.
 * @returns {void}
 */
- (void) loadManifest:(IonCompletionBlock) completion {
    __block NSDictionary* unconfirmedObject;
    [IonFileIOmanager openDataAtPath: [self manifestPath]
                     withResultBlock:^(id returnedObject) {
                         if ( !returnedObject && completion)
                            completion( NULL );
                         
                         unconfirmedObject = [(NSData*)returnedObject toJsonDictionary];
                         if ( !unconfirmedObject && completion ) {
                             completion( NULL );
                             return;
                         }
                         
                         [_manifest setDictionary: [unconfirmedObject overriddenByDictionaryRecursively: _manifest ]];
                         mainfestHasBeenLoaded = TRUE;
                         
                         if ( completion )
                             completion( NULL );
                     }];
}

/**
 * Saves the cache manifest to the file system.
 * @param {IonCompletionBlock} the completion block to call.
 * @returns {void}
 */
- (void) saveManifest:(IonCompletionBlock) completion {
    [IonFileIOmanager saveData: [NSData dataFromJsonEncodedDictionary: _manifest makePretty: TRUE]
                        atPath: [self manifestPath]
                withCompletion: ^(NSError *error) {
                    if ( completion )
                        completion( error );
                }];
}

/**
 * Deletes the cache manifest from the file system.
 * @param {IonCompletionBlock} the completion block to call.
 * @returns {void}
 */
- (void) deleteManifest:(IonCompletionBlock) completion {
    [IonFileIOmanager deleteItem: [self manifestPath] withCompletion: ^(NSError *error) {
       if ( completion )
           completion( error );
    }];
}

#pragma mark Manifest Manipulation

/**
 * Gets the extra info for the specified item key.
 * @param {NSString*} the key to get the object for.
 * @returns {NSDictionary*} the current extra info object.
 */
- (NSDictionary*) extraInfoForItemWithKey:(NSString*) key {
    return [_manifest extraInfoForItemWithKey: [NSDictionary sanitizeKey: key]];
}

/**
 * Sets the extra info for the specified item key.
 * @param {NSString*} the key to get the object for.
 * @param {NSDictionary*} the extra info object to set.
 * @returns {void}
 */
- (void) setExtraInfo:(NSDictionary*) extraInfo ForItemWithKey:(NSString*) key {
    [_manifest setExtraInfo: extraInfo forItemWithKey: [NSDictionary sanitizeKey: key]];
}

#pragma mark Data Validation

/**
 * Checks if the inputed data matches the signature thats stored in the the manifest.
 * @param {NSData*} the data to check agents the key.
 * @param {NSString*} the key to check the manifest with.
 * @returns {BOOL}
 */
- (BOOL) dataObject:(NSData*) data matchesManifestItemWithKey:(NSString*) key {
    NSString *dataSignature, *itemManifestSignature;
    if ( !data || ![data isKindOfClass: [NSData class]] ||
         !key || ![key isKindOfClass: [NSString class] ] )
        return FALSE;
    
    dataSignature = [[data SHA512Hash] toBase64];
    itemManifestSignature = [_manifest fileSignatureForItemWithKey: key];
    if ( !itemManifestSignature )
        return FALSE;
    
    return [dataSignature isEqualToString: itemManifestSignature];
}


/**
 * This is the special generation block which will look for security exceptions, and inconsistencies.
 * @param {NSString*} the key for the item to check.
 * @returns {IonAsyncGenerationBlock} the special generation block.
 */
- (IonAsyncGenerationBlock) scanerBlockForKey:(NSString*) key {
    __block NSString* blockKey;
    
    // Set data
    blockKey = key;
    
    return ^( id data, IonResultBlock resultBlock ){
        // Validate that the data has not been minipulated by checking the signiture.
        if ( ![self dataObject: data matchesManifestItemWithKey: blockKey] ) {
            resultBlock( NULL ); // return null because the data appears to minipulated by an outside source.
            
            // Respond acording to our security policy
            NSLog(@"WARN: cache data changed between sessions!");
        }
        else
            resultBlock( data ); // the data is good, proceed
    };
}

#pragma mark Data Source Protocol Implementation

/**
 * Gets the object with the specified key, or returns NULL.
 * @param {NSString*} the key to get the object for.
 * @param {IonRawDataSourceResultBlock} the block where the result will be returned.
 * @returns {void}
 */

- (void) objectForKey:(NSString*) key withResultBlock:(IonRawDataSourceResultBlock) result {
    NSString* cleanString;
    
    
    cleanString = [NSDictionary sanitizeKey: key];
    // Update the manifest stats.
    [_manifest incrementSessionAccessCountForItemWithKey: cleanString];

    // Get the object
    [super objectForKey: key usingGenerationBlock: [self scanerBlockForKey: cleanString] withResultBlock: result];
}

/**
 * Sets the object for the specified key.
 * @param {NSString*} the key for the object to set.
 * @param {id} the object to put in the data system.
 * @param {IonRawDataSourceCompletion} the completion.
 * @returns {void} returns false if the operation isn't valid.
 */
- (void) setObject:(id) object forKey:(NSString*) key withCompletion:(IonRawDataSourceCompletion) completion {
    NSData* objectData = [NSData dataFromObject:object];
    // Set a new state object for the key.
    [_manifest createNewItemUsingPath: key
                         andSignature: [[objectData SHA512Hash] toBase64]
                               ForKey:[NSDictionary sanitizeKey: key]];
    
    // Do the action.
    [super setObject: objectData
              forKey: key
      withCompletion: completion];
}

/**
 * Removes an object for the specified key.
 * @param {NSString*} the key to remove the object for.
 * @param {IonRawDataSourceCompletion} the completion.
 * @returns {void}
 */
- (void) removeObjectForKey:(NSString*) key withCompletion:(IonRawDataSourceCompletion) completion {
    [_manifest removeObjectForKey: [NSDictionary sanitizeKey: key]];
    [super removeObjectForKey: key
               withCompletion: completion];
}


/**
 * The data sources options.
 * @returns {IonDataSourceLocation} the location of the data source.
 */
- (IonDataSourceLocation) location {
    return IonDataSourceLocationStorage;
}

/**
 * This will report if we should cache the data generated with the specified key.
 * @param {NSString*} the key to check.
 * @returns {BOOL} false if we should not add it, true if we should or Invalid.
 */
- (BOOL) shouldCacheDataWithKey:(NSString*) key {
    return [_manifest shouldCacheItemForKey: [NSDictionary sanitizeKey: key]];
}


@end

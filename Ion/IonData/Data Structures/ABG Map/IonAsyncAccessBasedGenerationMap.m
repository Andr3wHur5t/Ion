//
//  IonAsyncAccessBasedGenerationMap.m
//  Ion
//
//  Created by Andrew Hurst on 7/16/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonAsyncAccessBasedGenerationMap.h"
#import "NSDictionary+IonTypeExtension.h"
#import "IonMutableDictionary.h"

@interface IonAsyncAccessBasedGenerationMap () {
    @protected
    IonAsyncInternalGenerationBlock generationBlock;
}

/**
 * This is the cached data we will search from.
 */
@property (strong, nonatomic) NSMutableDictionary* cachedData;

/**
 * This is where we store the items we are currently generating.
 */
@property (strong, nonatomic) NSMutableDictionary* currentlyGenerating;

/**
 * This will report if we should remove the raw data with the specified key.
 * @param {NSString*} the key to search for.
 * @returns {BOOL} false if we should remove it, true if we should or Invalid.
 */
- (BOOL) shouldRemoveRawDataWithKey:(NSString*) key;

/**
* This will generate the item for the specified key if there is data to construct it.
* @returns {id} the class that was generated from the raw data.
*/
- (void) generateItemForKey:(NSString*) key
       usingGenerationBlock:(IonAsyncGenerationBlock) specialGenerationBlock
            withResultBlock:(IonResultBlock) resultBlock;

@end




@implementation IonAsyncAccessBasedGenerationMap

#pragma mark Constructors

/**
 * Default constructor
 * @returns {instancetype}
 */
- (instancetype) init {
    return [self initWithDataSource: [[IonMutableDictionary alloc] init]];
}


/**
 * Construct us with the inputted data in our raw data stash.
 * @param {id<IonKeyedDataSource>} the data we will use to generate objects.
 * @param {IonGenerationBlock} the block we will call to generate the real data.
 * @returns {instancetype}
 */
- (instancetype) initWithDataSource:(id<IonKeyedDataSource>) dataSource
                 andGenerationBlock:(IonAsyncInternalGenerationBlock) itemGenerationBlock  {
    self = [super init];
    if (self) {
        _cachedData = [[NSMutableDictionary alloc] init];
        _currentlyGenerating = [[NSMutableDictionary alloc] init];
        [self setGenerationBlock: itemGenerationBlock];
        [self setRawData: dataSource];
    }
    return self;
}

/**
 * Construct us with the inputted data in our raw data stash.
 * @param {id<IonKeyedDataSource>} the data we will use to generate objects.
 * @returns {instancetype}
 */
- (instancetype) initWithDataSource:(id<IonKeyedDataSource>) dataSource {
    return [self initWithDataSource: dataSource andGenerationBlock: NULL];
}

#pragma mark External Interface

/**
 * The Setter for the data source where we get our raw data.
 
 */
- (void) setRawData:(id<IonKeyedDataSource>) rawData {
    _rawData = rawData;
    _cachedData = [[NSMutableDictionary alloc] init];
}

/**
 * Sets the generation block that we will call with the raw data to create the object.
 * @param {IonGenerationBlock} the block we will call to generate the real data.
 * @return {void}
 */
- (void) setGenerationBlock:(IonAsyncInternalGenerationBlock) newGenerationBlock {
    generationBlock = newGenerationBlock;
}

/**
 * Reports if the generation block has been generated.
 * @returns {BOOL} true if it's not NULL, false if it is.
 */
- (BOOL) generationBlockIsSet {
    return (BOOL) generationBlock;
}

/**
 * Gets the object for the specified key using the specified Generation callback.
 * @param {id} the key to search for.
 * @param {generationBlock} the block to call to generate the data from when cache object is NULL.
 * @param {IonRawDataSourceResultBlock} the block where the result will be returned, or NULL if invalid.
 
 */
- (void) objectForKey:(id) key
 usingGenerationBlock:(IonAsyncGenerationBlock) specialGenerationBlock
      withResultBlock:(IonRawDataSourceResultBlock) result  {
    __block NSString *strKey, *cleanKey;
    __block IonAsyncGenerationBlock genBlock;
    if ( !key || ![key isKindOfClass: [NSString class]] || !result ) {
        result( NULL );
        return;
    }
    
    // Set Validated Data in block safe variables
    strKey = key;
    cleanKey = [NSDictionary sanitizeKey: key];
    genBlock = specialGenerationBlock;
    
    dispatch_async( ionStandardDispatchQueue(), ^{
        id returnedItem;
        returnedItem = [_cachedData objectForKey: cleanKey];
        
        if ( !returnedItem ) {
            // Generate using generation block
           [self generateItemForKey: strKey
               usingGenerationBlock: specialGenerationBlock
                    withResultBlock:^(id returnedObject) {
                        id resultObject, cacheObject;
                        
                        resultObject = returnedObject;
                        cacheObject = [_cachedData objectForKey: cleanKey];
                        
                        // if we don't have a result object, try our cached object.
                        if ( !resultObject )
                            resultObject = cacheObject;
                        
                        // Report our findings, if any.
                        result( resultObject );
                        
                        // if we don't have a result don't continue
                        if ( !resultObject )
                            return;
                        
                        if ( !cacheObject ) // make sure it's not in the cache
                            if ( [self shouldCacheDataWithKey: cleanKey] ) // should it be cached?
                                [_cachedData setValue: resultObject forKey: cleanKey]; // cache it
                        
                        // Remove raw data if applicable
                        if ( [self shouldRemoveRawDataWithKey: cleanKey] )
                            ;// [_localRawData removeObjectForKey: strKey];
            }];
            return;
        }
        // Return Result
        result( returnedItem );
    });
}


/**
 * This will write a description about the class in its current state.
 * @retuns {NSString*}
 */
- (NSString *)description {
    return [_rawData description];
}

/**
 * Clears the internial memory cache.
 
 */
- (void) clearMemoryCache {
    [_cachedData removeAllObjects];
}

#pragma mark Keyed Data Source Implmentation

/**
 * Gets the object with the specified key, or returns NULL.
 * @param {NSString*} the key to get the object for.
 * @param {IonRawDataSourceResultBlock} the block where the result will be returned.
 
 */
- (void) objectForKey:(NSString*) key withResultBlock:(IonRawDataSourceResultBlock) result {
    [self objectForKey: key usingGenerationBlock: NULL withResultBlock: result];
}


/**
 * Sets the object for the specified key.
 * @param {NSString*} the key for the object to set.
 * @param {id} the object to put in the data system.
 * @param {IonRawDataSourceCompletion} the completion.
  returns false if the operation isn't valid.
 */
- (void) setObject:(id) object forKey:(NSString*) key withCompletion:(IonRawDataSourceCompletion) completion {
    __block NSString *strKey, *cleanString;
    __block id obj;
    __block IonRawDataSourceCompletion comp;
    if ( !key || ![key isKindOfClass:[NSString class]] || !object )
        return;
    
    // Set block safe vars
    strKey = key;
    cleanString = [NSDictionary sanitizeKey: key];;
    obj = object;
    comp = completion;
    
    // Call async
    dispatch_async( ionStandardDispatchQueue(), ^{
        if ( [self shouldCacheDataWithKey: cleanString] )
            [_cachedData setObject: obj forKey: cleanString];
        [_rawData setObject: obj forKey: strKey withCompletion: ^(NSError *error) {
            if ( comp )
                comp( error );
        }];
    });
}

/**
 * Removes an object for the specified key.
 * @param {NSString*} the key to remove the object for.
 * @param {IonRawDataSourceCompletion} the completion.
 
 */
- (void) removeObjectForKey:(NSString*) key withCompletion:(IonRawDataSourceCompletion) completion {
    __block NSString *strKey;
    __block IonRawDataSourceCompletion comp;
    if ( !key || ![key isKindOfClass:[NSString class]] )
        return;

    // Set block safe vars
    strKey = key;
    comp = completion;
    
    // Call async
    dispatch_async( ionStandardDispatchQueue(), ^{
        if ( [self shouldCacheSetDataWithKey: strKey] )
            [_cachedData removeObjectForKey: [NSDictionary sanitizeKey: strKey]];
        
        [_rawData removeObjectForKey: strKey withCompletion: ^(NSError *error) {
            if ( comp )
                comp( error );
        }];
    });
}

/**
 * Removes all objects for data source.
 * @param {IonRawDataSourceCompletion} the completion.
 
 */
- (void) removeAllObjects:(IonRawDataSourceCompletion) completion {
    __block IonRawDataSourceCompletion comp;
    comp = completion;
    
    // Call async
    dispatch_async( ionStandardDispatchQueue(), ^{
        [self clearMemoryCache];
        [_rawData removeAllObjects: ^(NSError *error) {
            if ( comp )
                comp( error );
        }];
    });
}

/**
 * The data sources options.
 * @returns {IonDataSourceLocation} the location of the data source.
 */
- (IonDataSourceLocation) location {
    return [_rawData location];
}


#pragma mark Internal Interface

/**
 * Generates the default generation block.
 * @returns {IonInternialGenerationBlock}
 */
- (IonAsyncInternalGenerationBlock) defaultGenerationBlock {
    return ^( id data, IonAsyncGenerationBlock genBlock, IonResultBlock result ) {
        if ( genBlock )
            genBlock( data, result );
    };
}

/**
 * This will generate the item for the specified key if there is data to construct it.
 * @returns {id} the class that was generated from the raw data.
 */
- (void) generateItemForKey:(NSString*) key
       usingGenerationBlock:(IonAsyncGenerationBlock) specialGenerationBlock
            withResultBlock:(IonResultBlock) resultBlock {
    __block IonResultBlock resBlock;
    __block NSString* strKey;
    if ( !key || !resultBlock )
        return;
    
    // Save block safe ite,s
    resBlock = resultBlock;
    strKey = key;
    
    // Get the generation block if it dosnt exist
    if ( !generationBlock )
        generationBlock = [self defaultGenerationBlock];
    
    // Create the default "specialGenerationBlock" generation block, so we always can return data.
    if ( !specialGenerationBlock )
        specialGenerationBlock = ^( id data, IonResultBlock resultBlock){
            resultBlock ( data );
        };
    
    
    // Get the item from our raw data source
    [_rawData objectForKey: strKey withResultBlock:^(id rawItem) {
        // Only run if we are not currently generating the item
        if ( [_currentlyGenerating objectForKey: strKey] )
            return;
            
        // Put us on the currently generating list
        [_currentlyGenerating setObject:@1 forKey:  strKey];
        
        // Run the generation block if we have one.
        if ( generationBlock )
            generationBlock( rawItem, specialGenerationBlock , ^( id result ) {
                
                // Return the result
                if ( resultBlock )
                    resultBlock ( result );
        
                // Take our self off of the currently generating list
                [_currentlyGenerating removeObjectForKey: key];
            });
        
    }];
    
}

/**
 * This will report if we should remove the raw data with the specified key.
 * @param {NSString*} the key to search for.
 * @returns {BOOL} false if we should remove it, true if we should or Invalid.
 */
- (BOOL) shouldRemoveRawDataWithKey:(NSString*) key {
    return false;
}

/**
 * This will report if we should cache the data generated with the specified key.
 * @param {NSString*} the key to check.
 * @returns {BOOL} false if we should not cache it, true if we should or Invalid.
 */
- (BOOL) shouldCacheDataWithKey:(NSString*) key {
    return TRUE;
}

/**
 * This will report if we should cache the data set with the specified key.
 * @param {NSString*} the key to check.
 * @returns {BOOL} false if we should not cache it, true if we should or Invalid.
 */
- (BOOL) shouldCacheSetDataWithKey:(NSString*) key {
    return TRUE;
}

@end

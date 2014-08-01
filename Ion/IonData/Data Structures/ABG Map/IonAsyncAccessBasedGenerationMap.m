//
//  IonAsyncAccessBasedGenerationMap.m
//  Ion
//
//  Created by Andrew Hurst on 7/16/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonAsyncAccessBasedGenerationMap.h"
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
 * @returns {void}
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
 * @returns {void}
 */
- (void) objectForKey:(id) key
 usingGenerationBlock:(IonAsyncGenerationBlock) specialGenerationBlock
      withResultBlock:(IonRawDataSourceResultBlock) result  {
    
    __block NSString* strKey;
    __block IonAsyncGenerationBlock genBlock;
    if ( !key || ![key isKindOfClass: [NSString class]] || !result ) {
        result( NULL );
        return;
    }
    
    // Set Validated Data in block safe variables
    strKey = key;
    genBlock = specialGenerationBlock;
    
    dispatch_async( ionStandardDispatchQueue(), ^{
        id returnedItem;
        returnedItem = [_cachedData objectForKey: strKey];
        
        if ( !returnedItem ) {
            // Generate using generation block
           [self generateItemForKey: key
               usingGenerationBlock: specialGenerationBlock
                    withResultBlock:^(id returnedObject) {
                        // Cache generated data
                        [_cachedData setValue: returnedObject forKey: strKey];
                        
                        result( returnedObject );
                        
                        // Remove raw data if applicable
                        if ( [self shouldRemoveRawDataWithKey: strKey] && returnedObject )
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

#pragma mark Keyed Data Source Implmentation

/**
 * Gets the object with the specified key, or returns NULL.
 * @param {NSString*} the key to get the object for.
 * @param {IonRawDataSourceResultBlock} the block where the result will be returned.
 * @returns {void}
 */
- (void) objectForKey:(NSString*) key withResultBlock:(IonRawDataSourceResultBlock) result {
    [self objectForKey: key usingGenerationBlock: NULL withResultBlock: result];
}


/**
 * Sets the object for the specified key.
 * @param {NSString*} the key for the object to set.
 * @param {id} the object to put in the data system.
 * @param {IonRawDataSourceCompletion} the completion.
 * @returns {void} returns false if the operation isn't valid.
 */
- (void) setObject:(id) object forKey:(NSString*) key withCompletion:(IonRawDataSourceCompletion) completion {
    __block NSString* strKey;
    __block id obj;
    __block IonRawDataSourceCompletion comp;
    if ( !key || ![key isKindOfClass:[NSString class]] || !object )
        return;
    
    // Set block safe vars
    strKey = key;
    obj = object;
    comp = completion;
    
    // Call async
    dispatch_async( ionStandardDispatchQueue(), ^{
        [_cachedData setObject: obj forKey: strKey];
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
 * @returns {void}
 */
- (void) removeObjectForKey:(NSString*) key withCompletion:(IonRawDataSourceCompletion) completion {
    __block NSString* strKey;
    __block IonRawDataSourceCompletion comp;
    if ( !key || ![key isKindOfClass:[NSString class]] )
        return;

    // Set block safe vars
    strKey = key;
    comp = completion;
    
    // Call async
    dispatch_async( ionStandardDispatchQueue(), ^{
        [_cachedData removeObjectForKey: strKey];
        [_rawData removeObjectForKey: strKey withCompletion: ^(NSError *error) {
            if ( comp )
                comp( error );
        }];
    });
}

/**
 * Removes all objects for data source.
 * @param {IonRawDataSourceCompletion} the completion.
 * @returns {void}
 */
- (void) removeAllObjects:(IonRawDataSourceCompletion) completion {
    __block IonRawDataSourceCompletion comp;
    comp = completion;
    
    // Call async
    dispatch_async( ionStandardDispatchQueue(), ^{
        [_cachedData removeAllObjects];
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
        if ( !genBlock || !result || !data )
            return;
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
    
    resBlock = resultBlock;
    strKey = key;
    
    // Get the generation block if it dosnt exist
    if ( !generationBlock )
        generationBlock = [self defaultGenerationBlock];
    
    // Create the default "specialGenerationBlock" generation
    if ( !specialGenerationBlock )
        specialGenerationBlock = ^( id data, IonResultBlock resultBlock){
            resultBlock ( data );
        };
    
    // Check if it exsists in raw
    [_rawData objectForKey:key withResultBlock:^(id rawItem) {
        if ( rawItem  && generationBlock && ![_currentlyGenerating objectForKey: key] ) {
            
            //Generate
            [_currentlyGenerating setObject:@1 forKey: key];
            generationBlock( rawItem, specialGenerationBlock , ^( id result ) {
                if ( !resultBlock || !result )
                    return;
                resultBlock ( result );
                
                [_currentlyGenerating removeObjectForKey: key];
            });
        }
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


@end

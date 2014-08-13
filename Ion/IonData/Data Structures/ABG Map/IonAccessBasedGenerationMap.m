//
//  IonAccessBasedGenerationMap.m
//  Ion
//
//  Created by Andrew Hurst on 7/16/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonAccessBasedGenerationMap.h"

@interface IonAccessBasedGenerationMap () {
    @protected
    IonInternialGenerationBlock generationBlock;
}
/**
 * This is the raw data that we will generate from.
 */
@property (strong, nonatomic) NSMutableDictionary* localRawData;

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
 * @returns {BOOL} false if we shoulnd remove it, true if we should or Invalid.
 */
- (BOOL) shouldRemoveRawDataWithKey:(NSString*) key;



@end




@implementation IonAccessBasedGenerationMap

#pragma mark Constructors

/**
 * This is our default constructor
 * @returns {instancetype}
 */
- (instancetype) init {
    self = [super init];
    
    if ( self ) {
        _localRawData = [[NSMutableDictionary alloc] init];
        _cachedData = [[NSMutableDictionary alloc] init];
        _currentlyGenerating = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

/**
 * This will construct us with the inputted data in our raw data stach.
 * @param {NSDictionary*} the data we will set our raw data stach with
 * @param {IonGenerationBlock} the block we will call to generate the real data.
 * @returns {instancetype}
 */
- (instancetype) initWithRawData:(NSDictionary*) data
             andGenerationBlock:(IonInternialGenerationBlock) itemGenerationBlock  {
    self = [self init];
    if (self) {
        [self setGenerationBlock: itemGenerationBlock];
        [self setRawData: data];
    }
    return self;
}

/**
 * This will construct us with the inputted data in our raw data stach.
 * @param {NSDictionary*} the data we will set our raw data stach with
 * @returns {instancetype}
 */
- (instancetype) initWithRawData:(NSDictionary*) data {
    return [self initWithRawData:data andGenerationBlock:NULL];
}

#pragma mark External Interface

/**
 * This sets our internal raw data, and deletes all curently cached data.
 * @param {NSDictionary*} the new raw data
 * @returns {void}
 */
- (void) setRawData:(NSDictionary*) data {
    [_localRawData setDictionary: data];
    _cachedData = [[NSMutableDictionary alloc] init];
}

/**
 * This sets the generation block that we will call with the raw data to create the object.
 * @param {IonGenerationBlock} the block we will call to generate the real data.
 * @return {void}
 */
- (void) setGenerationBlock:(IonInternialGenerationBlock) newGenerationBlock {
    generationBlock = newGenerationBlock;
}

/**
 * This reports if the generation block has been generated.
 * @returns {BOOL} true if it's not NULL, false if it is.
 */
- (BOOL) generationBlockIsSet {
    return (BOOL) generationBlock;
}

/**
 * Gets the generation block
 */
- (IonInternialGenerationBlock) getGenerationBlock {
    IonInternialGenerationBlock genBlock;
    
    if ( !generationBlock )
        genBlock = ^id( id data, IonGenerationBlock specialBlock ){
            return specialBlock( data );
        };
    else
        genBlock = generationBlock;
    return genBlock;
}

#pragma mark Data Management
/**
 * This gets the object for the specified key using the specified Generation callback.
 * @param {id} the key to search for.
 * @param {generationBlock} the block to call to generate the data from the raw object if NULL.
 * @returns {id} the generated class, or NULL if invalid.
 */
- (id) objectForKey:(id) key usingGenerationBlock: (IonGenerationBlock) specialGenerationBlock {
    id returnedItem;
    if ( !key )
        return NULL;
    
    returnedItem = [_cachedData objectForKey: key];
    
    if ( !returnedItem ) {
        returnedItem = [self generateItemForKey: key usingGenerationBlock: specialGenerationBlock];
        // Cache generated data
        [_cachedData setValue: returnedItem forKey: key];
        
        // Remove raw data if aplicable
        if ( [self shouldRemoveRawDataWithKey: key] && returnedItem )
            ;// [_localRawData removeObjectForKey:key];
    }
    return returnedItem;
}

/**
 * This gets an object with the specified key from the cache,
 * if it dosnt exsist we will generate it from raw data if avalable.
 * @param {id} the key to search for.
 * @returns {id} the generated class, or NULL if invalid.
 */
- (id) objectForKey:(id) key {
    return [self objectForKey: key usingGenerationBlock: NULL];
}



/**
 * This will generate the item for the specified key if there is data to construct it.
 * @returns {id} the class that was generated from the raw data.
 */
- (id) generateItemForKey:(NSString*) key usingGenerationBlock:(IonGenerationBlock) specialGenerationBlock {
    id rawItem, result;
    if ( !key )
        return NULL;
    
   
    rawItem = [_localRawData objectForKey:key];
    if ( rawItem && ![_currentlyGenerating objectForKey: key] ) {
        [_currentlyGenerating setObject:@1 forKey: key];
        result = [self getGenerationBlock]( rawItem, specialGenerationBlock );
        [_currentlyGenerating removeObjectForKey: key];
        return result;
    }
    
    return NULL;
}

/**
 * This will remove all data from the cache.
 * @returns {BOOL} true if sucsess, false if invalid or failure.
 */
- (BOOL) pergeCache {
    if ( !_cachedData )
        return false;
    
    [_cachedData removeAllObjects];
    
    return true;
}



/**
 * This will write a description about the class in its current state.
 * @retuns {NSString*}
 */
- (NSString *)description {
    return [_localRawData description];
}

#pragma mark Internal Interface



/**
 * This will report if we should remove the raw data with the specified key.
 * @param {NSString*} the key to search for.
 * @returns {BOOL} false if we shoulnd remove it, true if we should or Invalid.
 */
- (BOOL) shouldRemoveRawDataWithKey:(NSString*) key {
    return false;
}


@end

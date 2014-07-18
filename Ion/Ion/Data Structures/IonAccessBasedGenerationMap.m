//
//  IonAccessBasedGenerationMap.m
//  Ion
//
//  Created by Andrew Hurst on 7/16/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonAccessBasedGenerationMap.h"

@interface IonAccessBasedGenerationMap () {
    IonGenerationBlock generationBlock;
}
/**
 * This is the raw data that we will generate from.
 */
@property (strong, nonatomic) NSMutableDictionary* localRawData;

@property (strong, nonatomic) NSMutableDictionary* cachedData;

/**
 * This will generate the item for the specified key and return it.
 */
- (id) generateItemForKey:(NSString*) key;

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
             andGenerationBlock:(IonGenerationBlock) itemGenerationBlock  {
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
- (void) setGenerationBlock:(IonGenerationBlock) newGenerationBlock {
    generationBlock = newGenerationBlock;
}

#pragma mark Data Management

/**
 * This gets an object with the specified key from the cache,
 * if it dosnt exsist we will generate it from raw data if avalable.
 * @param {id} the key to search for.
 * @returns {id} the generated class, or NULL if invalid.
 */
- (id) objectForKey:(id) key {
    id returnedItem;
    if ( !key )
        return NULL;
    
    returnedItem = [_cachedData objectForKey: key];
    
    if ( !returnedItem ) {
        returnedItem = [self generateItemForKey: key];
        
        // Cache generated data
        [_cachedData setValue: returnedItem forKey: key];
    }
    
    // Idea Remove the raw data once generated in balanced Mode.
    
    return returnedItem;
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
 * This will generate the item for the specified key if there is data to construct it.
 * @returns {id} the class that was generated from the raw data.
 */
- (id) generateItemForKey:(NSString*) key {
    id rawItem;
    if ( !key )
        return NULL;
    
    rawItem = [_localRawData objectForKey:key];
    if ( rawItem  && generationBlock ) {
        return generationBlock(rawItem);
    }
    
    return NULL;
}



@end
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

@property (strong, nonatomic) NSMutableDictionary* generatedData;

/**
 * This will generate the item for the specified key and return it.
 */
- (id) generateItemForKey:(NSString*) key;

@end




@implementation IonAccessBasedGenerationMap

- (instancetype) init {
    self = [super init];
    
    if ( self ) {
        _localRawData = [[NSMutableDictionary alloc] init];
        _generatedData = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (void) setRawData:(NSDictionary *)data {
    [_localRawData setDictionary: data];
}

- (instancetype) initWithRawData:(NSDictionary*) data
             andGenerationBlock:(IonGenerationBlock) itemGenerationBlock  {
    self = [self init];
    if (self) {
        [self setGenerationBlock: itemGenerationBlock];
        [self setRawData: data];
    }
    return self;
}

- (instancetype) initWithRawData:(NSDictionary*) data {
    return [self initWithRawData:data andGenerationBlock:NULL];
}

/**
 * This sets of the generation block.
 */
- (void) setGenerationBlock:(IonGenerationBlock) newGenerationBlock {
    generationBlock = newGenerationBlock;
}

/**
 * Intercept all requests for items
 */
- (id) objectForKey:(id) key {
    id returnedItem = [_generatedData objectForKey:key];
    
    if ( !returnedItem ) {
        returnedItem = [self generateItemForKey:key];
        
        // save the item
        [_generatedData setValue:returnedItem forKey:key];
    }
    
    // Idea Remove the raw data once generated
    
    return returnedItem;
}

/**
 * This will generate the item for the specified key and return it.
 */
- (id) generateItemForKey:(NSString*) key {
    id returnedItem, rawItem;
    rawItem = [_localRawData objectForKey:key];
    
    if ( rawItem  && generationBlock )
        returnedItem = generationBlock(rawItem);
    
    return returnedItem;
}

- (NSString *)description {
    return [_localRawData description];
}

@end

//
//  IonAsyncAccessBasedGenerationMap.h
//  Ion
//
//  Created by Andrew Hurst on 7/16/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IonKeyedDataSource.h"
#import "IonDataTypes.h"


/**
 * The block type which will be used to generate real data from raw data.
 * @param {id} this is the raw data which should be processed to return the real object.
 * @param {IonGenerationResultBlock} the block which will be called with the result data.
 * @returns {void}
 */
typedef void(^IonAsyncGenerationBlock)( id data, IonResultBlock resultBlock );

/**
 * The block type which will be used to generate real data from raw data Internally.
 * @param {id} this is the raw data which should be processed to return the real object.
 * @patam {IonGenerationBlock*} the block which will be used to generate the real data.
 * @param {IonGenerationResultBlock} the block which will be called with the result data.
 * @returns {void}
 */
typedef void(^IonAsyncInternalGenerationBlock)( id data,
                                           IonAsyncGenerationBlock specialGenerationBlock,
                                           IonResultBlock resultBlock);

/**
 * This class is intended to allow for easy, generate when you need it dictionary.
 * Set the generation block, and raw data then invoke the objectForId: method with a key.
 * this will search for the item in the cache, if the object isn't in the cache it will invoke
 * the generation block with raw data with the same inputted key. After this the generation should
 * return the resulting object, or NULL then this will cache the result.
 */
@interface IonAsyncAccessBasedGenerationMap : NSObject <IonKeyedDataSource>

#pragma mark Constructors

/**
 * This will construct us with the inputted data in our raw data stash.
 * @param {id<IonKeyedDataSource>} the data we will use to generate objects.
 * @returns {instancetype}
 */
- (instancetype) initWithDataSource:(id<IonKeyedDataSource>) dataSource;

/**
 * This will construct us with the inputted data in our raw data stash.
 * @param {id<IonKeyedDataSource>} the data we will use to generate objects.
 * @param {IonGenerationBlock} the block we will call to generate the real data.
 * @returns {instancetype}
 */
- (instancetype) initWithDataSource:(id<IonKeyedDataSource>) dataSource
              andGenerationBlock:(IonAsyncInternalGenerationBlock) itemGenerationBlock;

#pragma mark Proprieties

/**
 * The Data source, where we will get the raw data from.
 */
@property (strong, nonatomic) id<IonKeyedDataSource> rawData;

#pragma mark External Interface

/**
 * This sets the generation block that we will call with the raw data to create the object.
 * @param {IonGenerationBlock} the block we will call to generate the real data.
 * @return {void}
 */
- (void) setGenerationBlock:(IonAsyncInternalGenerationBlock) newGenerationBlock;

/**
 * This reports if the generation block has been generated.
 * @returns {BOOL} true if it's not NULL, false if it is.
 */
- (BOOL) generationBlockIsSet;

#pragma mark Data Management

/**
 * Gets the object for the specified key using the specified Generation callback.
 * @param {id} the key to search for.
 * @param {generationBlock} the block to call to generate the data from when cache object is NULL.
 * @param {IonRawDataSourceResultBlock} the block where the result will be returned, or NULL if invalid.
 * @returns {void}
 */
- (void) objectForKey:(id) key
 usingGenerationBlock:(IonAsyncGenerationBlock) specialGenerationBlock
      withResultBlock:(IonRawDataSourceResultBlock) result;



@end

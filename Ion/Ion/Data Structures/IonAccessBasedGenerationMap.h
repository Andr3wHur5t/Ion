//
//  IonAccessBasedGenerationMap.h
//  Ion
//
//  Created by Andrew Hurst on 7/16/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * This is the block type which will be used to generate real data from raw data.
 * @param {id} this is the raw data wich should be processed to return the real object.
 * @returns {id} the resulting object, or NULL if invalid.
 */
typedef id(^IonGenerationBlock)( id data );



/**
 * This class is intended to allow for easy, generate when you need it dictionary.
 * Set the generation block, and raw data then invoke the objectForId: method with a key.
 * this will search for the item in the cache, if the object isn't in the chache it will invoke
 * the generation block with raw data with the same inputted key. After this the generation should
 * retun the resulting object, or NULL then this will chache the result.
 */
@interface IonAccessBasedGenerationMap : NSObject

#pragma mark Constructors

/**
 * This will construct us with the inputted data in our raw data stach.
 * @param {NSDictionary*} the data we will set our raw data stach with
 * @returns {instancetype}
 */
- (instancetype) initWithRawData:(NSDictionary*) data;

/**
 * This will construct us with the inputted data in our raw data stach.
 * @param {NSDictionary*} the data we will set our raw data stach with
 * @param {IonGenerationBlock} the block we will call to generate the real data.
 * @returns {instancetype}
 */
- (instancetype) initWithRawData:(NSDictionary*) data
              andGenerationBlock:(IonGenerationBlock) itemGenerationBlock;


#pragma mark Externial Interface

/**
 * This sets our internal raw data, and deletes all curently cached data.
 * @param {NSDictionary*} the new raw data
 * @returns {void}
 */
- (void) setRawData:(NSDictionary*) data;

/**
 * This sets the generation block that we will call with the raw data to create the object.
 * @param {IonGenerationBlock} the block we will call to generate the real data.
 * @return {void}
 */
- (void) setGenerationBlock:(IonGenerationBlock) newGenerationBlock;

/**
 * This reports if the generation block has been generated.
 * @returns {BOOL} true if it's not NULL, false if it is.
 */
- (BOOL) generationBlockIsSet;

#pragma mark Data Management

/**
 * This gets an object with the specified key from the cache,
 * if it dosnt exsist we will generate it from raw data if avalable.
 * @param {id} the key to search for.
 * @returns {id} the generated class, or NULL if invalid.
 */
- (id) objectForKey:(id) key;


/**
 * This will generate the item for the specified key and return it.
 * @param {NSString*} the key to search for.
 * @returns {id} the restulting object.
 */
- (id) generateItemForKey:(NSString*) key;

/**
 * This will remove all data from the cache.
 * @returns {BOOL} true if sucsess, false if invalid or failure.
 */
- (BOOL) pergeCache;

@end

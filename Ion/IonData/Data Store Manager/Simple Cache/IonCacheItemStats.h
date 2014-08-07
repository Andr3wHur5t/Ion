//
//  IonCacheItemStats.h
//  Ion
//
//  Created by Andrew Hurst on 7/26/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IonFile;

/**
 * Constants
 */
static const NSInteger sIonMinAverageNeededForCaching = 2;


/**
 * The Interface that holds all of the cache data.
 */
@interface NSMutableDictionary (IonCacheItemStats)
#pragma mark Construct

/**
 * Creates a new item with the specified key, and using the raw path.
 * @param {NSString*} the relative path of the item.
 * @param {NSString*} the signature of the items' file.
 * @param {NSString*} the key of the item.
 * @retrns {void}
 */
- (void) createNewItemUsingPath:(NSString*)rawPath andSignature:(NSString*) fileSignature ForKey:(NSString*) key;


#pragma mark Item Management

/**
 * gets an item for the specified key.
 * @param {NSString*} the key of the item to get.
 * @returns {NSDictionary*} the item
 */
- (NSDictionary*) itemForKey:(NSString*) key;

#pragma mark Stats Management
/**
 * Gets the stats object for the item with the specified key.
 * @param {NSString*} the items' key
 * @returns {NSMutableDictionary*}
 */
- (NSMutableDictionary*)statsForItemWithKey:(NSString *)key;

/**
 * Sets the stats object for the item with the specified key.
 * @param {NSString*} the items' key
 * @returns {NSMutableDictionary*}
 */
- (void)setStats:(NSDictionary*) stats toItemWithKey:(NSString*) key;

/**
 * Increment Session Access Count for the state object with the specified Key.
 * @param {NSString*} the relative path of the item, and Key.
 * @returns {void}
 */
- (void) incrementSessionAccessCountForItemWithKey:(NSString*) key;

#pragma mark Signature Retrieval

/**
 * Gets an Items File Signature.
 * @param {NSString*} the items key to get the file signature from.
 * @returns {NSSting*} the file signature string.
 */
- (NSString*) fileSignatureForItemWithKey:(NSString*) key;

#pragma mark Expiration Management

/**
 * Sets the expiration on the item with the inputted key.
 * 
 */



#pragma mark Extra Info
/**
 * Gets the extra info for the specified item key.
 * @param {NSString*} the key to get the object for.
 * @returns {NSDictionary*} the current extra info object.
 */
- (NSDictionary*) extraInfoForItemWithKey:(NSString*) key;

/**
 * Sets the extra info for the specified item key.
 * @param {NSString*} the key to get the object for.
 * @param {NSDictionary*} the extra info object to set.
 * @returns {void}
 */
- (void) setExtraInfo:(NSDictionary*) extraInfo forItemWithKey:(NSString*) key;

#pragma mark Reporting

/**
 * Reports if we should cache the item for the specified key.
 * @param {NSString*} the relative path of the item, and Key.
 * @returns {BOOL} true if we should cache it, otherwise false.
 */
- (BOOL) shouldCacheItemForKey:(NSString*) key;

@end

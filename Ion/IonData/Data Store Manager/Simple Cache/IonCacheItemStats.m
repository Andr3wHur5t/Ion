//
//  IonCacheItemStats.m
//  Ion
//
//  Created by Andrew Hurst on 7/26/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonCacheItemStats.h"
#import "NSDictionary+IonTypeExtension.h"


/**
 * ItemKeys Keys
 */
static NSString* sIonStats_RawPathKey = @"relativePath";
static NSString* sIonStats_FileSignatureKey = @"file Signature";
static NSString* sIonStats_ExtraInfoKey = @"extraInfo";
static NSString* sIonStats_ExpirationKey = @"expiration";
static NSString* sIonStats_Avarage = @"avarage";
static NSString* sIonStats_StatsKey = @"stats";
static NSString* sIonStats_Stats_RequestCountKey = @"requestCount";
static NSString* sIonStats_Stats_SessionCountKey = @"sessionCount";

@implementation NSMutableDictionary (IonCacheItemStats)
#pragma mark Construct
/**
 * Creates a new item with the specified key, and using the raw path.
 * @param {NSString*} the relative path of the item.
 * @param {NSString*} the signature of the items' file.
 * @param {NSString*} the key of the item.
 * @retrns {void}
 */
- (void) createNewItemUsingPath:(NSString*)rawPath andSignature:(NSString*) fileSignature ForKey:(NSString*) key; {
    if ( !rawPath || ![rawPath isKindOfClass: [NSString class]] ||
         !fileSignature || ![fileSignature isKindOfClass: [NSString class]] ||
         !key || ![key isKindOfClass: [NSString class]] )
        return;
    
    [self setObject: @{
                       sIonStats_RawPathKey: rawPath,
                       sIonStats_FileSignatureKey: fileSignature,
                       sIonStats_StatsKey: @{
                               sIonStats_Stats_RequestCountKey: @0,
                               sIonStats_Stats_SessionCountKey: @0
                               }
                       
                       } forKey: key];
}

#pragma mark Item Management

/**
 * gets an item for the specified key.
 * @param {NSString*} the key of the item to get.
 * @returns {NSDictionary*} the item
 */
- (NSDictionary*) itemForKey:(NSString*) key {
    return [self dictionaryForKey: key];
}


/**
 * Sets the item object for the item with the specified key.
 * @param {NSString*} the items' key
 * @returns {NSMutableDictionary*}
 */
- (void)setItem:(NSDictionary*) item forKey:(NSString*) key {
    if ( !key || ![key isKindOfClass: [NSString class]] )
        return;
    [self setObject: item  forKey: key];
}

#pragma mark Signature Retrieval

/**
 * Gets an Items File Signature.
 * @param {NSString*} the items key to get the file signature from.
 * @returns {NSSting*} the file signature string.
 */
- (NSString*) fileSignatureForItemWithKey:(NSString*) key {
    NSDictionary* item;
    
    item = [self itemForKey: key];
    if ( !item )
        return NULL;
    
    return [item stringForKey: sIonStats_FileSignatureKey];
}

#pragma mark Path Retrevial

/**
 * Get the path of the file that the item with the inputted key represents.
 * @param {NSString*} the items' key
 * @param {NSString*} the path
 */
- (NSString*) pathForItemWithKey:(NSString*) key {
    NSDictionary *item;
    if ( !key || ![key isKindOfClass: [NSString class]] )
        return NULL;
    
    item = [self itemForKey: key];
    if ( !item )
        return NULL;
    
    return [item stringForKey: sIonStats_RawPathKey];
}

#pragma mark Stats Management

/**
 * Gets the stats object for the item with the specified key.
 * @param {NSString*} the items' key
 * @returns {NSMutableDictionary*}
 */
- (NSMutableDictionary*)statsForItemWithKey:(NSString *)key {
    NSDictionary *item, *stats;
    if ( !key || ![key isKindOfClass: [NSString class]] )
        return NULL;
    
    item = [self itemForKey: key];
    if ( !item )
        return NULL;
    
    stats = [item dictionaryForKey: sIonStats_StatsKey];
    if ( ![stats isKindOfClass: [NSDictionary class]])
        return NULL;
    
    return [stats mutableCopy];
}

/**
 * Sets the stats object for the item with the specified key.
 * @param {NSString*} the items' key
 * @returns {NSMutableDictionary*}
 */
- (void)setStats:(NSDictionary*) stats toItemWithKey:(NSString*) key {
    NSMutableDictionary *item;
    if ( !key || ![key isKindOfClass: [NSString class]] )
        return;
    
    item = [[self dictionaryForKey: key] mutableCopy];
    if ( !item )
        return;
    
    // Update
    [item setObject: stats forKey: sIonStats_StatsKey];
    [self setItem: item forKey: key];
}


/**
 * Increment Session Access Count for the state object with the specified Key.
 * @param {NSString*} the relative path of the item, and Key.
 * @returns {void}
 */
- (void)incrementSessionAccessCountForItemWithKey:(NSString *)key {
    [self incrementValueForKey: sIonStats_Stats_RequestCountKey ItemWithKey: key];
}


/**
 * Increment Session Count for the state object with the specified Key.
 * @param {NSString*} the relative path of the item, and Key.
 * @returns {void}
 */
- (void) incrementSessionCountForItemWithKey:(NSString*) key {
     [self incrementValueForKey: sIonStats_Stats_SessionCountKey ItemWithKey: key];
}

/**
 * Increment value for the state object with the specified Key.
 * @param {NSString*} the values' key to increment.
 * @param {NSString*} the relative path of the item, and Key.
 * @returns {void}
 */
- (void) incrementValueForKey:(NSString*) valKey ItemWithKey:(NSString*) key {
    NSNumber *itemCount;
    NSMutableDictionary *stats;
    stats = [self statsForItemWithKey: key];
    if ( !stats )
        return;
    
    itemCount = [stats numberForKey: valKey];
    if ( !itemCount )
        return;
    
    // Update
    itemCount = [NSNumber numberWithInt: [itemCount integerValue] + 1 ];
    [stats setObject: itemCount forKey: valKey];
    [self setStats: stats toItemWithKey: key];
}

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
- (NSDictionary*) extraInfoForItemWithKey:(NSString*) key {
    NSDictionary* item;
    if ( !key || ![key isKindOfClass: [NSString class]] )
        return NULL;
    
    item = [self itemForKey: key];
    if ( !item )
        return NULL;
    
    return [item dictionaryForKey: sIonStats_ExtraInfoKey];
}

/**
 * Sets the extra info for the specified item key.
 * @param {NSString*} the key to get the object for.
 * @param {NSDictionary*} the extra info object to set.
 * @returns {void}
 */
- (void) setExtraInfo:(NSDictionary*) extraInfo forItemWithKey:(NSString*) key {
    NSMutableDictionary *item;
    if ( !key || ![key isKindOfClass: [NSString class]] )
        return;
    
    item = [[self itemForKey: key] mutableCopy];
    if ( !item )
        return;
    
    // Update
    [item setObject: extraInfo forKey: sIonStats_ExtraInfoKey];
    [self setItem: item forKey: key];
}

/**
 * Updates the session stats.
 * @param {NSString*} the key to update the stats for.
 * @returns {void}
 */
- (void) updateSessionStatsForItemWithKey:(NSString*) key {
    NSNumber *sesionCount, *accessCount;
    NSMutableDictionary* stats;
    if ( !key || ![key isKindOfClass: [NSString class]] )
        return;
   
    stats = [self statsForItemWithKey: key];
    if ( !stats )
        return;
    
    accessCount =  [stats numberForKey: sIonStats_Stats_RequestCountKey];
    sesionCount = [stats numberForKey: sIonStats_Stats_SessionCountKey];
    if ( !accessCount || !sesionCount )
        return;
    
    if ( [sesionCount integerValue] >= sIonMinSessionForAverageCalc ) {
        [stats setObject: [NSNumber numberWithFloat: [accessCount floatValue] / [sesionCount floatValue]]
                  forKey: sIonStats_Avarage];
        [stats setObject: @0
                  forKey: sIonStats_Stats_RequestCountKey];
        [stats setObject: @0
                  forKey: sIonStats_Stats_SessionCountKey];
        
        [self setStats: stats toItemWithKey: key];
    }
        
    
}
#pragma mark Reporting

/**
 * Reports if we should cache the item for the specified key.
 * @param {NSString*} the relative path of the item, and Key.
 * @returns {BOOL} true if we should cache it, otherwise false.
 */
- (BOOL) shouldCacheItemForKey:(NSString*) key {
    BOOL shouldBeCached;
    NSNumber *totalLoads, *totalSessions, *currentAvarage;
    CGFloat sessionCount, accessCount;
    NSDictionary* stats;
    
    // Gets Stats Object
    shouldBeCached = false;
    stats = [self statsForItemWithKey: key];
    if ( !stats )
        return false;
    
    // Get Data
    totalLoads =    [stats numberForKey: sIonStats_Stats_RequestCountKey];
    totalSessions = [stats numberForKey: sIonStats_Stats_SessionCountKey];
    currentAvarage = [stats numberForKey: sIonStats_Avarage];
    if ( !totalLoads || !totalSessions )
        return false;
    
    // Convert Data
    accessCount = [totalLoads floatValue];
    sessionCount = [totalSessions floatValue];
    
    // Normilize Normilize Data so we dont devide by zero!
    accessCount = accessCount != 0 ? accessCount : 0.1;
    sessionCount = sessionCount != 0 ? sessionCount : 1;
    
    // check if we pass requirements
    if ( !currentAvarage )
        shouldBeCached = (accessCount / sessionCount) > sIonMinAverageNeededForCaching;
    else
        shouldBeCached = [currentAvarage floatValue] > sIonMinAverageNeededForCaching;
    
    // Debug reporting
    if ( shouldBeCached )
        NSLog(@"Cache File");
    else
        NSLog(@"Dont cache!");
    
    return  shouldBeCached;
}



@end

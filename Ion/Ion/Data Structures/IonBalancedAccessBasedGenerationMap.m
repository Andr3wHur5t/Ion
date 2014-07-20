//
//  IonBalancedAccessBasedGenerationMap.m
//  Ion
//
//  Created by Andrew Hurst on 7/18/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonBalancedAccessBasedGenerationMap.h"

@implementation IonBalancedAccessBasedGenerationMap

#pragma mark Data Management
/**
 * This will remove all data from the cache.
 * @returns {BOOL} true if sucsess, false if invalid or failure.
 */
- (BOOL) pergeCache {
    return false; // Don't allow pergeing of the cache, because the data cant be regenerated.
}

    

#pragma mark Internal Interface

/**
 * This will report if we should remove the raw data with the specified key.
 * @param {NSString*} the key to search for.
 * @returns {BOOL} false if we shoulnd remove it, true if we should or Invalid.
 */
- (BOOL) shouldRemoveRawDataWithKey:(NSString*) key {
    return true; // return true to balance the memory usage.
}

@end

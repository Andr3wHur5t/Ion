//
//  IonMutableDictionary.h
//  Ion
//
//  Created by Andrew Hurst on 7/29/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IonKeyedDataSource.h"

@interface IonMutableDictionary : NSObject <IonKeyedDataSource>

#pragma mark Constructors

/**
 * The normal constructor, to setup with raw data.
 * @param {NSDictionary*} the raw data to set up with.
 * @returns {instancetype}
 */
- (instancetype) initWithDictionary:(NSDictionary*) dict;

#pragma mark Utilities
/**
 * Sets the data in the map.
 * @param {NSDictionary*} the dictionary to set up with.
 * @returns {void}
 */
- (void) setDictionary:(NSDictionary*) dict;

/**
 * Gets the key count.
 * @returns {NSInteger} the count of keys.
 */
- (NSInteger) keyCount;
@end

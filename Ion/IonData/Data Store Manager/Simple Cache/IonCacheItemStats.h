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



@interface IonCacheItemStats : NSObject
#pragma mark Construct

/**
 * Constructs using an encoded dictionary.
 * @param {NSDictionary*} the encoded dictionary to use.
 * @returns {instancetype}
 */
- (instancetype) initWithEncodedDictionary:(NSDictionary*) dict;

/**
 * Constructs using the file as The Basis
 * @param {IonFile*} the file to use in creation.
 * @returns {instancetype}
 */
- (instancetype) initWithFile:(IonFile*) file;

#pragma mark Proprieties

/**
 * The name of the Item in the file system.
 */
@property (strong, nonatomic, readonly) NSString* name;

/**
 * The number of requests for the data in our current session.
 */
@property (strong, nonatomic, readonly) NSNumber* sessionRequestCount;

/**
 * The average number of requests for the data in prior sessions.
 */
@property (strong, nonatomic, readonly) NSNumber* priorSessionRequestCountAverage;

/**
 * The experation date of said file.
 */
@property (strong, nonatomic) NSDate* experationDate;

#pragma mark Queries

/**
 * Increments the request count
 * @retuns {void}
 */
- (void) incrementsRequestCount;

/**
 * Reports if the data should be cached.
 * @returns {BOOL}
 */
- (BOOL) dataShouldBeCached;


#pragma mark Encoding & Decoding

/**
 * Encodes our current state into a dictionary.
 * @returns {NSDictionary*} the encoded dictionary.
 */
- (NSDictionary*) encode;

/**
 * Decodes a state dictionary, and updates our state to match.
 * @param {NSDictionary*} the encoded dictionary.
 * @returns {void}
 */
- (void) decode:(NSDictionary*) dict;

@end

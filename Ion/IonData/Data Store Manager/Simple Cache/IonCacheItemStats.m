//
//  IonCacheItemStats.m
//  Ion
//
//  Created by Andrew Hurst on 7/26/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonCacheItemStats.h"
#import "IonFile.h"


/**
 * Encoding & Decoding Keys
 */
static NSString* sIonStatsPathEncodingKey = @"name";
static NSString* sIonStatsAverageRequestCountEncodingKey = @"averageRequestCount";

@implementation IonCacheItemStats

#pragma mark Construct

/**
 * Standard constructor.
 * @returns {instancetype}
 */
- (instancetype) init {
    self = [super init];
    if ( self ) {
        _name = @"untitled";
        _sessionRequestCount = @0;
    }
    return self;
}

/**
 * Constructs using an encoded dictionary.
 * @param {NSDictionary*} the encoded dictionary to use.
 * @returns {instancetype}
 */
- (instancetype) initWithEncodedDictionary:(NSDictionary*) dict {
    self = [self init];
    if ( self )
       [self decode: dict];
    return self;
}

/**
 * Constructs using the file as The Basis
 * @param {IonFile*} the file to use in creation.
 * @returns {instancetype}
 */
- (instancetype) initWithFile:(IonFile*) file {
    self = [self init];
    if ( self ) {
        _name = file.name;
    }
    return self;
}

#pragma mark Queries

/**
 * Increments the request count
 * @retuns {void}
 */
- (void) incrementsRequestCount {
    _sessionRequestCount = [NSNumber numberWithInteger:[_sessionRequestCount integerValue] + 1];
}

/**
 * Reports if the data should be cached.
 * @returns {BOOL}
 */
- (BOOL) dataShouldBeCached {
    return _priorSessionRequestCountAverage ? sIonMinAverageNeededForCaching > [_priorSessionRequestCountAverage doubleValue] : sIonMinAverageNeededForCaching > [_sessionRequestCount doubleValue];
}


#pragma mark Encoding & Decoding

/**
 * Encodes our current state into a dictionary.
 * @returns {NSDictionary*} the encoded dictionary.
 */
- (NSDictionary*) encode {
    NSMutableDictionary* encodedDict;
    double averageRequestCount;
    NSNumber* newAverageRequestCount;
    NSString* filePath;
    
    // calculate
    averageRequestCount = [_sessionRequestCount doubleValue];
    if ( _priorSessionRequestCountAverage )
        averageRequestCount = ([_priorSessionRequestCountAverage doubleValue] + averageRequestCount)/2;
    
    //Construct
    encodedDict = [[NSMutableDictionary alloc] init];
    newAverageRequestCount = [[NSNumber alloc] initWithDouble: averageRequestCount];
    filePath = [[NSString alloc] initWithString: _name];
    
    [encodedDict setObject:newAverageRequestCount forKey: sIonStatsAverageRequestCountEncodingKey];
    [encodedDict setObject: filePath forKey: sIonStatsPathEncodingKey];
    
    
    return encodedDict;
}

/**
 * Decodes a state dictionary, and updates our state to match.
 * @param {NSDictionary*} the encoded dictionary.
 * @returns {void}
 */
- (void) decode:(NSDictionary*) dict {
    NSString* name;
    NSNumber* priorSessionAverageRequestCount;
    if ( !dict || ![dict isKindOfClass: [NSDictionary class]] )
        return;
    
    priorSessionAverageRequestCount = [dict objectForKey: sIonStatsAverageRequestCountEncodingKey];
    if ( priorSessionAverageRequestCount && [priorSessionAverageRequestCount isKindOfClass: [NSNumber class]] )
        _priorSessionRequestCountAverage = priorSessionAverageRequestCount;
    
    name = [dict objectForKey: sIonStatsPathEncodingKey];
    if ( name && [name isKindOfClass: [NSString class]] )
        _name = name;
}

@end

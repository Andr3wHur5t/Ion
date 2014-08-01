//
//  IonMutableDictionary.m
//  Ion
//
//  Created by Andrew Hurst on 7/29/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonMutableDictionary.h"

@interface IonMutableDictionary () {
    NSMutableDictionary* _map;
}

@end

@implementation IonMutableDictionary

#pragma mark Constructors

/**
 * The standard constructor.
 * @returns {instancetype}
 */
- (instancetype) init {
    self = [super init];
    if ( self )
        _map = [[NSMutableDictionary alloc] init];
    
    return self;
}

/**
 * The normal constructor, to setup with raw data.
 * @param {NSDictionary*} the dictionary to set up with.
 * @returns {instancetype}
 */
- (instancetype) initWithDictionary:(NSDictionary*) dict {
    self = [self init];
    if ( self )
        [self setDictionary: dict];
    return self;
}

#pragma mark Utilities
/**
 * Sets the data in the map.
 * @param {NSDictionary*} the dictionary to set up with.
 * @returns {void}
 */
- (void) setDictionary:(NSDictionary*) dict {
    [_map setDictionary: dict];
}

/**
 * The description showed in the log.
 * @returns {NSString*}
 */
- (NSString*) description {
    return [_map description];
}

/**
 * Gets the key count.
 * @returns {NSInteger} the count of keys.
 */
- (NSInteger) keyCount {
    return [[_map allKeys] count];
}
#pragma mark Data Source Interface

/**
 * Gets the object with the specified key, or returns NULL.
 * @param {NSString*} the key to get the object for.
 * @param {IonRawDataSourceResultBlock} the block where the result will be returned.
 * @returns {void}
 */
- (void) objectForKey:(NSString*) key withResultBlock:(IonRawDataSourceResultBlock) result {
    __block NSString* str;
    if ( !key || ![key isKindOfClass: [NSString class]] || !result || !_map ) {
        if ( result )
            result ( NULL );
        return;
    }
    
    str = key;
    dispatch_async( ionStandardDispatchQueue(), ^{
        __block id obj;
        obj = [_map objectForKey: str ];
        
        
        dispatch_async( dispatch_get_main_queue(), ^{
            if ( result )
                result ( obj );
        });
    });
}

/**
 * Sets the object for the specified key.
 * @param {NSString*} the key for the object to set.
 * @param {id} the object to put in the data system.
 * @param {IonRawDataSourceCompletion} the completion.
 * @returns {void} returns false if the operation isn't valid.
 */
- (void) setObject:(id) object forKey:(NSString*) key withCompletion:(IonRawDataSourceCompletion) completion {
    if ( !key || ![key isKindOfClass: [NSString class]] || !object || !_map ) {
        if ( completion )
            completion ( NULL );
        return;
    }
    
    dispatch_async( ionStandardDispatchQueue(), ^{
        [_map setObject: object forKey: key];
        
        if ( completion )
            dispatch_async( dispatch_get_main_queue(), ^{
                completion ( NULL );
            });
    });
    return;
}

/**
 * Removes an object for the specified key.
 * @param {NSString*} the key to remove the object for.
 * @param {IonRawDataSourceCompletion} the completion.
 * @returns {void}
 */
- (void) removeObjectForKey:(NSString*) key withCompletion:(IonRawDataSourceCompletion) completion  {
    if ( !key || ![key isKindOfClass: [NSString class]] || !_map ) {
        if ( completion )
            completion ( NULL );
        return;
    }
    dispatch_async( ionStandardDispatchQueue(), ^{
        [_map removeObjectForKey: key];
        
        if ( completion )
            dispatch_async( dispatch_get_main_queue(), ^{
                completion ( NULL );
            });
    });
}


/**
 * Removes all objects for data source.
 * @param {IonRawDataSourceCompletion} the completion.
 * @returns {void}
 */
- (void) removeAllObjects:(IonRawDataSourceCompletion) completion {
    if ( !_map ) {
        if ( completion )
            completion ( NULL );
        return;
    }
    dispatch_async( ionStandardDispatchQueue(), ^{
        [_map removeAllObjects];
        
        if ( completion )
            dispatch_async( dispatch_get_main_queue(), ^{
                completion ( NULL );
            });
    });
}


/**
 * The data sources options.
 * @returns {IonDataSourceLocation} the location of the data source.
 */
- (IonDataSourceLocation) location {
    return IonDataSourceLocationRam;
}

@end

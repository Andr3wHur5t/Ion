//
//  IonKVPAccessBasedGenerationMap.m
//  Ion
//
//  Created by Andrew Hurst on 7/18/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonKVPAccessBasedGenerationMap.h"
#import "IonKeyValuePair.h"

@implementation IonKVPAccessBasedGenerationMap

/**
 * This sets the generation block to generate kvp values.
 * @returns {void}
 */
- (void) setGenerationBlock {
    __weak typeof( self ) weakSelf = self;
    [self setGenerationBlock: ^id( id data ) {
        return [weakSelf resolveData: data];
    }];
}

/**
 * This is where we resolve our data.
 * @param {id} the data to generate from.
 * @returns {id} the resulting object.
 */
- (id) resolveData:(id) data {
    IonKeyValuePair* kvp = [IonKeyValuePair resolveWithValue: data andAttrubutes: self];
    
    return kvp;
}

/**
 * This gets values from the map in KVP format.
 * @param {id} the key to look for.
 * @returns {IonKeyValuePair*} the resulting object, or NULL if invalid.
 */
- (IonKeyValuePair*) KVPForKey:(id) key {
    if ( !key )
        return NULL;
    
    IonKeyValuePair* result = [self objectForKey: key];
    return result;
}

/**
 * This will generate an item for the specified key, and set the generation block if it hasn't already.
 * @param {NSString} the key to look for.
 * @retunrs {id} the resulting object to be set.
 */
- (id) generateItemForKey:(NSString*) key {
    if ( ![self generationBlockIsSet] )
        [self setGenerationBlock];
    return [super generateItemForKey: key];
}

@end

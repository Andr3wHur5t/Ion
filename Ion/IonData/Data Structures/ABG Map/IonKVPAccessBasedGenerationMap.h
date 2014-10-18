//
//  IonKVPAccessBasedGenerationMap.h
//  Ion
//
//  Created by Andrew Hurst on 7/18/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonAccessBasedGenerationMap.h"

@class IonKeyValuePair;

@interface IonKVPAccessBasedGenerationMap : IonAccessBasedGenerationMap


/**
 * This gets values from the map in KVP format.
 * @param key - the key to look for.
 * @returns {IonKeyValuePair*} the resulting object, or NULL if invalid.
 */
- (IonKeyValuePair*) KVPForKey:(id) key;

@end

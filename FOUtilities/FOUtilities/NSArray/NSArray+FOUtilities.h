//
//  NSArray+FOUtilities.h
//  FOUtilities
//
//  Created by Andrew Hurst on 10/9/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (FOUtilities)
#pragma mark Random Getters
/**
 * Retrieves a random object from the array.
 */
- (id) randomObject;

#pragma mark Overwriting
/**
 * Recursivly overwrites objects in an array, with objects from another array.
 * @param array - the array to do the overwrite with.
 * @returns the overwritten array.
 */
- (NSArray *)overwriteRecursivelyWithArray:(NSArray *)array;

@end

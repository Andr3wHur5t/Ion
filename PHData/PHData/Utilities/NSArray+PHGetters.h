//
//  NSArray+PHGetters.h
//  PHData
//
//  Created by Andrew Hurst on 10/7/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <Foundation/Foundation.h>

#define RandWithin( min, max ) ((min) + ( arc4random() % ((max) - (min)) ))

@interface NSArray (PHGetters)
#pragma mark Random Getters
/**
 * Gets a random object from the array.
 */
- (id) randomObject;

/**
 * Gets a random pretty string from the array.
 */
- (NSString *)randomPrettyString;

#pragma mark Generators
/**
 * Generats an array of lengths within the set of bounds that will be equal to the length of the goal.
 * @param min - the minimum length a value can be.
 * @param max - the maxumum length a value can be.
 * @param goal - the objective that the sum of lengths must be.
 */
+ (NSArray *)generateLengthsArrayWithIdealMin:(NSUInteger) min
                                     idealMax:(NSUInteger) max
                                      andGoal:(NSUInteger) goal;
@end

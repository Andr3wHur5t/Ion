//
//  NSArray+PHGetters.m
//  PHData
//
//  Created by Andrew Hurst on 10/7/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "NSArray+PHGetters.h"

@implementation NSArray (PHGetters)
#pragma mark Random Getters

- (id) randomObject {
    if ( self.count <= 0 )
        return NULL;
    return [self objectAtIndex: arc4random_uniform( (int)self.count )];
}

- (NSString *)randomPrettyString {
     return [((NSString *) [self randomObject]).lowercaseString capitalizedString];
}

#pragma mark Generators

+ (NSArray *)generateLengthsArrayWithIdealMin:(NSUInteger) min
                                     idealMax:(NSUInteger) max
                                      andGoal:(NSUInteger) goal {
    NSMutableArray *results;
    NSUInteger currentProgress, instanceProgress;
    results = [[NSMutableArray alloc] init];
    
    // if the goal is already below our may we have already achieved our goal.
    if ( goal <= max )
        [results addObject: @(goal)]; // We are already within ideal length.
    else {
        // We need to break into sentences of ideal length
        currentProgress = 0;
        while ( goal - currentProgress > max ) {
            instanceProgress = RandWithin( min, max);
            [results addObject: @(instanceProgress)];
            currentProgress += instanceProgress;
        }
        [results addObject: @(goal - currentProgress)]; // Finish off goal.
    }
    return results;
}

@end

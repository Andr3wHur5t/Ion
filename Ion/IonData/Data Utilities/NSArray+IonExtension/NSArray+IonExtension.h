//
//  NSArray+IonIonExtension.h
//  Ion
//
//  Created by Andrew Hurst on 8/3/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (IonExtension)

#pragma mark Overwriting

/**
 * Dose a recursive overwrite
 * @param {NSArray*} the array to do the shallow overwrite with.
 * @returns {NSArray*} the resulting array of the overwrite.
 */
- (NSArray*) overwriteRecursivelyWithArray:(NSArray*) array;
@end

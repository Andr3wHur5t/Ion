//
//  IonPath.h
//  Ion
//
//  Created by Andrew Hurst on 7/24/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IonPath : NSObject
#pragma mark Constructors

/**
 * Creates a path with the inputed path appended by the array of items
 */
- (instancetype) initPath:(IonPath*) rootPath appendedByElements:(NSArray*) pathElements;

#pragma mark conversions

/**
 * Converts to a string representation.
 * @returns {NSString*}
 */
- (NSString*) toString;

@end

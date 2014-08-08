//
//  NSDictionary+IonFile.h
//  Ion
//
//  Created by Andrew Hurst on 8/7/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IonDataTypes.h"

@class IonPath;

@interface NSDictionary (IonFile)
#pragma mark Loading Procedures

/**
 * This returns the JSON manifest loaded at the specified path.
 * @param {IonPath*} the path.
 * @param {IonCompletionBlock} the completion where the dictionary will be returned.
 * @returns {void}
 */
+ (void) dictionaryAtPath:(IonPath*) path usingCompletionBlock:(IonResultBlock) result;

#pragma mark Proprieties

#pragma mark Managment


@end

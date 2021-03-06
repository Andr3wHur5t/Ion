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
#pragma mark Opening As JSON

/**
 * This returns the JSON dictionary loaded at the specified path.
 * @param path - the path.
 * @param result - the result block where the dictionary will be returned.
 
 */
+ (void) dictionaryAtPath:(IonPath *)path usingResultBlock:(IonResultBlock) result;

+ (NSDictionary *)dictionaryWithFileName:(NSString *)name;

+ (NSDictionary *)dictionaryAtPath:(IonPath *)path;

#pragma mark Saving As JSON

/**
 * Saves the dictionary as json at the specified path.
 * @param path - path
 */
- (void) saveAsJSONAtPath:(IonPath *)path;

/**
 * Saves the dictionary as json at the specified path.
 * @param {IonPath*} path
 * @param {IonCompletionBloc} the completion block
 */
- (void) saveAsJSONAtPath:(IonPath*) path withCompletion:(IonCompletionBlock) completion;

/**
 * Saves the dictionary as minified json at the specified path.
 * @param {IonPath*} path
 * @return {void}
 */
- (void) saveAsMinifiedJSONAtPath:(IonPath*) path;

/**
 * Saves the dictionary as json at the specified path.
 * @param {IonPath*} path
 * @param {IonCompletionBloc} the completion block
 * @return {void}
 */
- (void) saveAsMinifiedJSONAtPath:(IonPath*) path withCompletion:(IonCompletionBlock) completion;



@end

//
//  NSDictionary+IonFile.m
//  Ion
//
//  Created by Andrew Hurst on 8/7/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "NSDictionary+IonFile.h"
#import "NSData+IonTypeExtension.h"
#import "IonFileIOmanager.h"
#import "IonPath.h"


@implementation NSDictionary (IonFile)
#pragma mark Opening As JSON

/**
 * This returns the JSON dictionary loaded at the specified path.
 * @param {IonPath*} the path.
 * @param {IonResultBlock} the result block where the dictionary will be returned.
 * @returns {void}
 */
+ (void) dictionaryAtPath:(IonPath*) path usingResultBlock:(IonResultBlock) result {
    __block NSDictionary* unconfirmedObject;
    __block IonResultBlock blockCompletion;
    if ( ! result )
        return;
    
    blockCompletion = result;
    [IonFileIOmanager openDataAtPath: path
                     withResultBlock: ^(id returnedObject) {
                         if ( !returnedObject) {
                             blockCompletion( NULL );
                             return;
                         }
                         
                         // Convert returned Data
                         unconfirmedObject = [(NSData*)returnedObject toJsonDictionary];
                         if ( !unconfirmedObject ) {
                             blockCompletion( NULL );
                             return;
                         }
                         
                        // Return the result
                        blockCompletion( unconfirmedObject );
                     }];
}


#pragma mark Saving As JSON
/**
 * Saves the dictionary as JSON to the specified path.
 * @param {IonPath*} the path
 * @param {IonCompletionBloc} the completion block
 * @param {BOOL} states if the json is minified.
 * @returns {void}
 */
- (void) saveAtPath:(IonPath*) path minified:(BOOL) isMinified withCompletion:(IonCompletionBlock) completion {
    [IonFileIOmanager saveData: [NSData dataFromJsonEncodedDictionary: self makePretty: !isMinified]
                        atPath: path
                withCompletion: ^(NSError *error) {
                    if ( completion )
                        completion( error );
                }];
}

/**
 * Saves the dictionary as json at the specified path.
 * @param {IonPath*} path
 * @return {void}
 */
- (void) saveAsJSONAtPath:(IonPath*) path {
    [self saveAtPath: path minified: FALSE withCompletion: NULL];
}

/**
 * Saves the dictionary as json at the specified path.
 * @param {IonPath*} path
 * @param {IonCompletionBloc} the completion block
 * @return {void}
 */
- (void) saveAsJSONAtPath:(IonPath*) path withCompletion:(IonCompletionBlock) completion {
    [self saveAtPath: path minified: FALSE withCompletion: completion];
}

/**
 * Saves the dictionary as minified json at the specified path.
 * @param {IonPath*} path
 * @return {void}
 */
- (void) saveAsMinifiedJSONAtPath:(IonPath*) path {
    [self saveAtPath: path minified: TRUE withCompletion: NULL];
}

/**
 * Saves the dictionary as json at the specified path.
 * @param {IonPath*} path
 * @param {IonCompletionBloc} the completion block
 * @return {void}
 */
- (void) saveAsMinifiedJSONAtPath:(IonPath*) path withCompletion:(IonCompletionBlock) completion {
    [self saveAtPath: path minified: TRUE withCompletion: completion];
}


@end

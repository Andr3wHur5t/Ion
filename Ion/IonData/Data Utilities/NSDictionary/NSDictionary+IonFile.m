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
#pragma mark Construction


/**
 * This returns the JSON dictionary loaded at the specified path.
 * @param {IonPath*} the path.
 * @param {IonCompletionBlock} the completion where the dictionary will be returned.
 * @returns {void}
 */
+ (void) dictionaryAtPath:(IonPath*) path usingCompletionBlock:(IonResultBlock) result {
    __block NSDictionary* unconfirmedObject;
    __block IonResultBlock blockCompletion;
    if ( ! blockCompletion )
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

#pragma mark Proprieties

#pragma mark Managment



@end

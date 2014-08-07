//
//  IonFileIOmanager.h
//  Ion
//
//  Created by Andrew Hurst on 7/24/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IonDataTypes.h"

@class IonPath;

@interface IonFileIOmanager : NSObject
#pragma mark General Calls
/**
 * The standerd method for invoking methods on the shared Manager.
 * @param {void(^)( NSFileManager* fileManager )} the block to do your work on the file manager.
 * @returns {void}
 */
+ (void) preformBlockOnManager:(void(^)( NSFileManager* fileManager )) block;

#pragma mark File IO Actions

/**
 * Saves the file in the directory.
 * @param {IonFile*} the file to add.
 * @param {IonPath*} the path to save the file to.
 * @param {void(^)( NSError* error )} the completion callback.
 * @returns {void}
 */
+ (void) saveFile:(IonFile*) file atPath:(IonPath*) path withCompletion:(IonCompletionBlock) completion;

/**
 * Saves the specified data at the literal path with the inputted compleation.
 * @param {NSData*} the data to save.
 * @param {IonPath*} the path to save the data to.
 * @param {IonCompletionBlock} the completion to call.
 */
+ (void) saveData:(NSData*) data atPath:(IonPath*) path withCompletion:(IonCompletionBlock) completion;

/**
 * Opens a file within the directory, and returns it in the callback.
 * @param {IonPath*} the path to retrive the data from.
 * @param { void(^)( IonFile* file ) } the return block.
 * @returns {void}
 */
+ (void) openFileAtPath:(IonPath*) path withResultBlock:(void(^)( IonFile* file )) resultBlock;

/**
 * Opens a data with at the path, and returns it in the callback.
 * @param {IonPath*} the path of the data to open.
 * @param {IonResultBlock} the result block to use.
 * @returns {void}
 */
+ (void) openDataAtPath:(IonPath*) path withResultBlock:(IonResultBlock) resultBlock;

/**
 * Deletes the file, or directory at the specified path.
 * @param {IonPath*} the path of the irem to delete.
 * @param {IonCompletionBlock} the completion callback.
 * @returns {void}
 */
+ (void) deleteItem:(IonPath*) path withCompletion:(IonCompletionBlock) completion;

/**
 * Lists files, and directories in the specified path.
 * @param {IonPath*} the path for us to look into.
 * @param {void(^)( NSArray* items )} the result callback where we will provide a array of item strings.
 * @returns {void}
 */
+ (void) listItemsAtPath:(IonPath*) path withResultBlock:(IonResultBlock) resultBlock;

/**
 * Creates a directory at the specified path.
 * @param {IonPath*} the path to create the directory at.
 * @param {IonCompletionCallback} the completion to call.
 * @returns {void}
 */
+ (void) creaateDirectoryAtPath:(IonPath*) path withCompletion:(IonCompletionBlock) completion;

/**
 * Checks if a file exsists the the specified path on the current thread.
 * @param {IonPath*} the target path.
 * @returns {BOOL}
 */
+ (BOOL) fileExsistsAtPath:(IonPath*) path;

/**
 * Checks if a directory exsists the the specified path on the current thread.
 * @param {IonPath*} the target path.
 * @returns {BOOL}
 */
+ (BOOL) directoryExsistsAtPath:(IonPath*) path;

#pragma mark Singletons

/**
 * The file IO dispatch queue singleton.
 * @returns {dispatch_queue_t}
 */
+ (dispatch_queue_t) fileIOdispatchQueue;

/**
 * The File manager singleton.
 * @returns {NSFileManager*}
 */
+ (NSFileManager*) sharedManager;

@end

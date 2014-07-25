//
//  IonDirectory.h
//  Ion
//
//  Created by Andrew Hurst on 7/24/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IonPath.h"

@class IonFile;

@interface IonDirectory : NSObject
#pragma mark Constructors

/**
 * Constructs a IonDirectory using the inputted URL.
 * @param {IonPath*} the path of the directory.
 * @returns {instancetype}
 */
- (instancetype) initWithPath:(IonPath*) path;


#pragma mark Proprieties 

/** A copy of our url path
 */
@property (strong, nonatomic, readonly) IonPath* path;

#pragma mark File Manipulation

/**
 * Opens a file within the directory, and returns it in the callback.
 * @param {NSString*} the file name to open.
 * @param { void(^)( IonFile* file ) } the return block.
 * @returns {void}
 */
- (void) openFile:(NSString*) fileName withResultBlock:(void(^)( IonFile* file )) resultBlock;

/**
 * Saves the file in the directory.
 * @param {IonFile*} the file to add.
 * @param {void(^)( NSError* error )} the completion callback.
 * @returns {void}
 */
- (void) saveFile:(IonFile*) file withCompletion:(void(^)( NSError* error )) completion;


#pragma mark Directory Manipulation

/**
 * Opens a directory by name, which already exists in the current directory.
 * @param {NSString*} the directory name.
 * @param { void(^)( IonDirectory* directory ) } the return block.
 * @returns {void}
 */
- (void) openDirectory:(NSString*) directoryName
       withResultBlock:(void(^)( IonDirectory* directory )) resultBlock;

/**
 * Creates a directory in the current directory with the specified name.
 * @param {NSString*} the directory name for the new directory.
 * @param {void(^)( IonDirectory* directory, NSError* error )} the completion callback.
 * @returns {void}
 */
- (void) createDirectory:(NSString*) directoryName
          withCompletion:(void(^)( IonDirectory* directory )) completion;

#pragma mark Directory Utilities

/**
 * Deletes the file, or directory at the specified path.
 * @param {NSString*} the name of the item within the directory to delete.
 * @param {void(^)( NSError* error )} the completion callback.
 * @returns {void}
 */
- (void) deleteItem:(NSString*) item withCompletion:(void(^)( NSError* error )) completion;

/**
 * Lists files, and directories in the current directory.
 * @param {void(^)( NSArray* items )} the result callback where we will provide a array of
 *    strings.
 * @returns {void}
 */
- (void) listItems:(void(^)( NSArray* items )) resultBlock;

@end

//
//  IonDirectory.h
//  Ion
//
//  Created by Andrew Hurst on 7/24/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IonKeyedDataSource.h"
#import "IonPath.h"

@class IonFile;

@interface IonDirectory : NSObject <IonKeyedDataSource>
#pragma mark Constructors

/**
 * Constructs a IonDirectory using the inputted URL.
 * @param {IonPath*} the path of the directory.
 * @returns {instancetype}
 */
- (instancetype) initWithPath:(IonPath*) path;

/**
 * Constructs a IonDirectory using the inputted URL.
 * @param {IonPath*} the path of the directory.
 * @returns {IonDirectory*}
 */
+ (IonDirectory*) directoryWithPath:(IonPath*) path;

#pragma mark Proprieties 

/** A copy of our url path
 */
@property (strong, nonatomic, readonly) IonPath* path;

#pragma mark File Manipulation

/**
 * Opens a file within the directory, and returns it in the callback.
 * @param {NSString*} the file name to open.
 * @param { void(^)( IonFile* file ) } the return block.
 
 */
- (void) openFile:(NSString*) fileName withResultBlock:(void(^)( IonFile* file )) resultBlock;

/**
 * Saves the file in the directory.
 * @param {IonFile*} the file to add.
 * @param {void(^)( NSError* error )} the completion callback.
 
 */
- (void) saveFile:(IonFile*) file withCompletion:(void(^)( NSError* error )) completion;


#pragma mark Directory Manipulation

/**
 * Opens a directory by name, which already exists in the current directory.
 * @param {NSString*} the directory name.
 * @param { void(^)( IonDirectory* directory ) } the return block.
 
 */
- (void) openDirectory:(NSString*) directoryName
       withResultBlock:(void(^)( IonDirectory* directory )) resultBlock;

#pragma mark Directory Utilities

/**
 * Deletes the file, or directory at the specified path.
 * @param {NSString*} the name of the item within the directory to delete.
 * @param {void(^)( NSError* error )} the completion callback.
 
 */
- (void) deleteItem:(NSString*) item withCompletion:(void(^)( NSError* error )) completion;

/**
 * Lists files, and directories in the current directory.
 * @param {void(^)( NSArray* items )} the result callback where we will provide a array of
 *    strings.
 
 */
- (void) listItems:(void(^)( NSArray* items )) resultBlock;

@end

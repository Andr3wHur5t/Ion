//
//  IonDirectory.m
//  Ion
//
//  Created by Andrew Hurst on 7/24/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonDirectory.h"
#import "IonFileIOmanager.h"
#import "IonFile.h"


@implementation IonDirectory

/**
 * Constructs a IonDirectory using the inputted URL.
 * @param {IonPath*} the path of the directory.
 * @returns {instancetype}
 */
- (instancetype) initWithPath:(IonPath*) path {
    self = [self init];
    if ( self )
        _path = path;
    
    return self;
}


#pragma mark File Manipulation

/**
 * Opens a file within the directory, and returns it in the callback.
 * @param {NSString*} the file name to open.
 * @param { void(^)( IonFile* file ) } the return block.
 * @returns {void}
 */
- (void) openFile:(NSString*) fileName withResultBlock:(void(^)( IonFile* file )) resultBlock {
    __block IonPath* path;
    __block IonDirectory* currentDirectory;
    __block IonFile* resultingFile;
    __block NSData* localData;
    if ( !fileName || ! resultBlock )
        return;
    
    // Construct
    path = [[IonPath alloc] initPath: _path appendedByElements: @[fileName]];
    currentDirectory = self;
    localData = NULL;
    
    // Get Data
    [IonFileIOmanager preformBlockOnManager: ^( NSFileManager *fileManager ) {
        if ( [fileManager fileExistsAtPath: [path toString]] )
            localData =[fileManager contentsAtPath: [path toString]];
        
        resultingFile = [[IonFile alloc] initWithContent: localData
                                                fileName: fileName
                                      andParentDirectory: currentDirectory];
        
        // Return on main thread
        dispatch_async( dispatch_get_main_queue(), ^{
            resultBlock( resultingFile );
        });
    }];
}

/**
 * Saves the file in the directory.
 * @param {IonFile*} the file to add.
 * @param {void(^)( NSError* error )} the completion callback.
 * @returns {void}
 */
- (void) saveFile:(IonFile*) file withCompletion:(void(^)( NSError* error )) completion {
    __block IonFile* fileToSave;
    __block IonPath* filePath;
    __block NSError* error;
    if ( !file || !completion )
        return;
    
    //Construct
    fileToSave = [[IonFile alloc] initWithFile: file];
    filePath = [[IonPath alloc] initPath: _path appendedByElements:@[ fileToSave.name ]];
    
    // Get
    [IonFileIOmanager preformBlockOnManager: ^( NSFileManager *fileManager ) {
        if ( ![fileManager createFileAtPath: [_path toString]
                             contents: fileToSave.content
                           attributes: NULL] )
            error = [NSError errorWithDomain:@"Failed To save!." code:0 userInfo:NULL];
        
        // Return
        dispatch_async( dispatch_get_main_queue(), ^{
            completion ( error );
        });
    }];
    
    
}


#pragma mark Directory Manipulation

/**
 * Opens a directory by name, which already exists in the current directory.
 * @param {NSString*} the directory name.
 * @param { void(^)( IonDirectory* directory ) } the return block.
 * @returns {void}
 */
- (void) openDirectory:(NSString*) directoryName
       withResultBlock:(void(^)( IonDirectory* directory )) resultBlock {
    IonPath* path;
    IonDirectory* newDirectory;
    if ( !resultBlock || !directoryName)
        return;
    // Construct
    path = [[IonPath alloc] initPath: _path appendedByElements: @[directoryName]];
    newDirectory = [[IonDirectory alloc] initWithPath: path];
    
    // Return
    resultBlock ( newDirectory );
}

/**
 * Creates a directory in the current directory with the specified name.
 * @param {NSString*} the directory name for the new directory.
 * @param {void(^)( IonDirectory* directory, NSError* error )} the completion callback.
 * @returns {void}
 */
- (void) createDirectory:(NSString*) directoryName
          withCompletion:(void(^)( IonDirectory* directory )) completion; {
    __block IonPath* path;
    __block NSError* error;
    __block IonDirectory* newDirectory;
    if ( !completion || !directoryName )
        return;
    
    // Construct
    path = [[IonPath alloc] initPath: _path appendedByElements: @[directoryName]];
    
    // Get
    [IonFileIOmanager preformBlockOnManager: ^( NSFileManager *fileManager ) {
        [fileManager createDirectoryAtPath: [path toString]
               withIntermediateDirectories: TRUE
                                attributes: NULL
                                     error: &error];
        
        // Return results on main thread
        newDirectory = [[IonDirectory alloc] initWithPath: path];
        dispatch_async( dispatch_get_main_queue() , ^{
            completion ( newDirectory );
        });
    }];
}

#pragma mark Directory Utilities

/**
 * Deletes the file, or directory at the specified path.
 * @param {NSString*} the name of the item within the directory to delete.
 * @param {void(^)( NSError* error )} the completion callback.
 * @returns {void}
 */
- (void) deleteItem:(NSString*) item withCompletion:(void(^)( NSError* error )) completion {
    __block NSString* path = [[_path toString] stringByAppendingString: item];
    __block NSError* error;
    if ( !completion )
        return;
    
    // Commit
    [IonFileIOmanager preformBlockOnManager: ^( NSFileManager *fileManager ) {
        [fileManager removeItemAtPath: path error: &error];
        
        // Return results on main thread
        dispatch_async( dispatch_get_main_queue() , ^{
            completion ( error );
        });
    }];
}

/**
 * Lists files, and directories in the current directory.
 * @param {void(^)( NSArray* items )} the result callback where we will provide a array of
 *    strings.
 * @returns {void}
 */
- (void) listItems:(void(^)( NSArray* items )) resultBlock {
    __block NSString* path = [_path toString];
    __block NSError* error;
    __block NSArray* itemList;
    if ( !resultBlock )
        return;
    
    // Get
    [IonFileIOmanager preformBlockOnManager: ^( NSFileManager *fileManager ) {
        itemList = [fileManager contentsOfDirectoryAtPath: path
                                                    error: &error];
        
        // Record results on main thread
        dispatch_async( dispatch_get_main_queue() , ^{
            resultBlock ( itemList );
        });
    }];
}
@end

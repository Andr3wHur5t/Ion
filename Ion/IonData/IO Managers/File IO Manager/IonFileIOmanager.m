//
//  IonFileIOmanager.m
//  Ion
//
//  Created by Andrew Hurst on 7/24/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonFileIOmanager.h"
#import "IonFile.h"
#import "IonPath.h"
#import "IonDirectory.h"


static const char* IonFileIOqueueLabel = "com.ion.fileManager";

@interface IonFileIOmanager ()


#pragma mark Singletons

/**
 * The File manager singleton.
 * @returns {NSFileManager*}
 */
+ (NSFileManager*) sharedManager;

@end


@implementation IonFileIOmanager

#pragma mark General Calls
/**
 * The standerd method for invoking methods on the shared Manager.
 * @param {void(^)( NSFileManager* fileManager )} the block to do your work on the file manager.
 * @returns {void}
 */
+ (void) preformBlockOnManager:(void(^)( NSFileManager* fileManager )) block {
    __block NSFileManager* manager;
    if ( !block )
        return;
    
    dispatch_async([IonFileIOmanager fileIOdispatchQueue], ^{
        manager = [IonFileIOmanager sharedManager];
        if ( !manager )
            return;
        
        // Do work
        block( manager );
    });
    
    
}

#pragma mark IO Actions

/**
 * Saves the file in the directory.
 * @param {IonFile*} the file to add.
 * @param {IonPath*} the path to save the file to.
 * @param {void(^)( NSError* error )} the completion callback.
 * @returns {void}
 */
+ (void) saveFile:(IonFile*) file atPath:(IonPath*) path withCompletion:(IonCompletionBlock) completion {
    if ( !completion || !file || ![file isKindOfClass:[IonFile class]] )
        return;
    [IonFileIOmanager saveData: file.content
                        atPath: [path pathAppendedByElement: file.name]
                withCompletion: completion];
}

/**
 * Saves the specified data at the literal path with the inputted compleation.
 * @param {NSData*} the data to save.
 * @param {IonPath*} the path to save the data to.
 * @param {IonCompletionBlock} the completion to call.
 */
+ (void) saveData:(NSData*) data atPath:(IonPath*) path withCompletion:(IonCompletionBlock) completion {
    __block NSData* dataToSave;
    __block IonPath* savePath;
    __block NSError* error;
    if ( !data || ![data isKindOfClass:[NSData class]] )
        return;
    
    // Construct
    dataToSave = [NSData dataWithData: data];
    savePath = [[IonPath alloc] initFromPath: path];
    if ( !dataToSave || ![dataToSave isKindOfClass: [NSData class]] ||
        !savePath || ![savePath isKindOfClass: [IonPath class]] ) {
        if ( completion )
            completion( [NSError errorWithDomain:@"Failed to convert." code:0 userInfo:NULL] );
        return;
    }
    
    // Save (For Some reason it (completion) is being set to null....)
    [IonFileIOmanager preformBlockOnManager: ^( NSFileManager *fileManager ) {
        if ( ![fileManager createFileAtPath: [savePath toString]
                                   contents: dataToSave
                                 attributes: NULL] )
            error = [NSError errorWithDomain:@"Failed To save Data." code:0 userInfo:NULL];
        
        // Return
        if ( completion )
            dispatch_async( dispatch_get_main_queue(), ^{
                completion( error );
            });
    }];
}

/**
 * Opens a file within the directory, and returns it in the callback.
 * @param {IonPath*} the path to retrive the data from.
 * @param { void(^)( IonFile* file ) } the return block.
 * @returns {void}
 */
+ (void) openFileAtPath:(IonPath*) path withResultBlock:(void(^)( IonFile* file )) resultBlock {
    __block IonFile* file;
    __block IonPath* blockPath;
    if ( resultBlock ) {
        blockPath = path;
        [IonFileIOmanager openDataAtPath: blockPath withResultBlock: ^(id returnedObject) {
            file = [[IonFile alloc] initWithContent: returnedObject
                                           fileName: [blockPath itemName]
                                 andParentDirectory: [[IonDirectory alloc] initWithPath: [blockPath parentPath]]];
            resultBlock ( file );
        }];
    }
    
}


/**
 * Opens a data with at the path, and returns it in the callback.
 * @param {IonPath*} the path of the data to open.
 * @param {IonResultBlock} the result block to use.
 * @returns {void}
 */
+ (void) openDataAtPath:(IonPath*) path withResultBlock:(IonResultBlock) resultBlock {
    __block IonPath* targetPath;
    __block NSData* localData;
    if ( !resultBlock || !path || ![path isKindOfClass: [IonPath class]] ){
        resultBlock( NULL );
        return;
    }
    
    // Construct
    targetPath = [[IonPath alloc] initFromPath: path];
    localData = NULL;
    if ( !targetPath || ![targetPath isKindOfClass: [IonPath class]] ) {
        resultBlock( NULL );
        return;
    }
    
    // Get Data
    [IonFileIOmanager preformBlockOnManager: ^( NSFileManager *fileManager ) {
        localData = [fileManager contentsAtPath: [targetPath toString]];
        if ( ![localData isKindOfClass: [NSData class]] )
            localData = NULL;
        
        // Return on main thread
        dispatch_async( dispatch_get_main_queue(), ^{
            resultBlock( localData );
        });
    }];
}

/**
 * Deletes the file, or directory at the specified path.
 * @param {IonPath*} the path of the irem to delete.
 * @param {IonCompletionBlock} the completion callback.
 * @returns {void}
 */
+ (void) deleteItem:(IonPath*) path withCompletion:(IonCompletionBlock) completion {
    __block IonPath* blockPath = [IonPath pathFromPath: path];
    __block NSError* error;
    if ( !path || ![path isKindOfClass: [IonPath class]] ) {
        if ( completion )
            completion ( [NSError errorWithDomain:@"Invalid argument." code:0 userInfo:NULL] );
        return;
    }
    
    // Commit
    [IonFileIOmanager preformBlockOnManager: ^( NSFileManager *fileManager ) {
        if ( [fileManager fileExistsAtPath: [blockPath toString] isDirectory: NULL])
            [fileManager removeItemAtPath: [blockPath toString] error: &error];
        else
            error = [NSError errorWithDomain:@"Item dosen't exsist." code:0 userInfo:NULL];
        
        // Return results on main thread
        if ( completion )
            dispatch_async( dispatch_get_main_queue() , ^{
                completion ( error );
            });
    }];
}


/**
 * Lists files, and directories in the specified path.
 * @param {IonPath*} the path for us to look into.
 * @param {void(^)( NSArray* items )} the result callback where we will provide a array of item strings.
 * @returns {void}
 */
+ (void) listItemsAtPath:(IonPath*) path withResultBlock:(IonResultBlock) resultBlock {
    __block IonPath* targetPath;
    __block NSArray* items;
    if ( !resultBlock )
        return;
    
    // Set constants
    targetPath = path;
    
    // Get
    [IonFileIOmanager preformBlockOnManager: ^( NSFileManager *fileManager ) {
        items = [fileManager contentsOfDirectoryAtPath: [targetPath toString] error: NULL];
        
        // Record results on main thread
        dispatch_async( dispatch_get_main_queue() , ^{
            resultBlock ( items );
        });
    }];
}

/**
 * Creates a directory at the specified path.
 * @param {IonPath*} the path to create the directory at.
 * @param {IonCompletionCallback} the completion to call.
 * @returns {void}
 */
+ (void) creaateDirectoryAtPath:(IonPath*) path withCompletion:(IonCompletionBlock) completion {
    __block NSError* error;
    
    // Get
    [IonFileIOmanager preformBlockOnManager: ^( NSFileManager *fileManager ) {
        [fileManager createDirectoryAtPath: [path toString]
                withIntermediateDirectories: TRUE
                                 attributes: NULL
                                      error: &error];
        // Record results on main thread
        dispatch_async( dispatch_get_main_queue() , ^{
            if ( completion )
                completion ( error );
        });
    }];
}

/**
 * Checks if a file exsists the the specified path on the current thread.
 * @param {IonPath*} the target path.
 * @returns {BOOL}
 */
+ (BOOL) fileExsistsAtPath:(IonPath*) path {
    BOOL isDirectory, result;
    result = [[NSFileManager defaultManager] fileExistsAtPath: [path toString] isDirectory: &isDirectory];
    return result && !isDirectory;
}

/**
 * Checks if a directory exsists the the specified path on the current thread.
 * @param {IonPath*} the target path.
 * @returns {BOOL}
 */
+ (BOOL) directoryExsistsAtPath:(IonPath*) path {
    BOOL isDirectory, result;
    result = [[NSFileManager defaultManager] fileExistsAtPath: [path toString] isDirectory: &isDirectory];
    return result && isDirectory;
}


#pragma mark Singletons

/**
 * The File manager singleton.
 * @returns {NSFileManager*}
 */
+ (NSFileManager*) sharedManager {
    static NSFileManager* sharedManager = NULL;
    static dispatch_once_t fileManager_OnceToken;
    
    dispatch_once(&fileManager_OnceToken, ^{
        sharedManager = [[NSFileManager alloc] init];
    });
    
    return sharedManager;
}

/**
 * The file IO dispatch queue singleton.
 * @returns {dispatch_queue_t}
 */
+ (dispatch_queue_t) fileIOdispatchQueue {
    static dispatch_queue_t fileIOdispatchQueue = NULL;
    static dispatch_once_t fileIOdispatchQueue_OnceToken;
    
    dispatch_once(&fileIOdispatchQueue_OnceToken, ^{
        fileIOdispatchQueue = dispatch_queue_create( IonFileIOqueueLabel, NULL );
    });
    
    return fileIOdispatchQueue;
}

@end

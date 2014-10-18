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
#import <FOUtilities/FOUtilities.h>

@implementation IonDirectory

/**
 * Constructs a IonDirectory using the inputted URL.
 * @param {IonPath*} the path of the directory.
 * @returns {instancetype}
 */
- (instancetype) initWithPath:(IonPath*) path {
    self = [self init];
    if ( self ) {
        _path = path;
        if ( ![IonFileIOmanager directoryExsistsAtPath: _path] )
            [[NSFileManager defaultManager] createDirectoryAtPath: [_path toString]
                                      withIntermediateDirectories: TRUE
                                                       attributes: NULL
                                                            error: NULL];
    }
    
    return self;
}

/**
 * Constructs a IonDirectory using the inputted URL.
 * @param {IonPath*} the path of the directory.
 * @returns {IonDirectory*}
 */
+ (IonDirectory*) directoryWithPath:(IonPath*) path {
    return [[IonDirectory alloc] initWithPath: path];
}

#pragma mark File Manipulation

/**
 * Opens a file within the directory, and returns it in the callback.
 * @param {NSString*} the file name to open.
 * @param { void(^)( IonFile* file ) } the return block.
 
 */
- (void) openFile:(NSString*) fileName withResultBlock:(void(^)( IonFile* file )) resultBlock {
    [IonFileIOmanager openFileAtPath: [_path pathAppendedByElement: fileName]
                     withResultBlock: resultBlock];
}

/**
 * Saves the file in the directory.
 * @param {IonFile*} the file to add.
 * @param {void(^)( NSError* error )} the completion callback.
 
 */
- (void) saveFile:(IonFile*) file withCompletion:(void(^)( NSError* error )) completion {
    [IonFileIOmanager saveFile: file
                        atPath: _path
                withCompletion: completion];
}


#pragma mark Directory Manipulation

/**
 * Opens / Creates a directory by name.
 * @param {NSString*} the directory name.
 * @param { void(^)( IonDirectory* directory ) } the return block.
 
 */
- (void) openDirectory:(NSString*) directoryName
       withResultBlock:(void(^)( IonDirectory* directory )) resultBlock {
    IonPath* path;
    IonDirectory* newDirectory;
    if ( !resultBlock || !directoryName || ![directoryName isKindOfClass: [NSString class]] ) {
        resultBlock( NULL );
        return;
    }
    // Construct
    path = [_path pathAppendedByElement: directoryName];
    newDirectory = [[IonDirectory alloc] initWithPath: path];
    
    // Return
    resultBlock ( newDirectory );
}

#pragma mark Directory Utilities

/**
 * Deletes the file, or directory at the specified path.
 * @param {NSString*} the name of the item within the directory to delete.
 * @param {void(^)( NSError* error )} the completion callback.
 
 */
- (void) deleteItem:(NSString*) item withCompletion:(IonCompletionBlock) completion {
    [IonFileIOmanager deleteItem: [_path pathAppendedByElement: item] withCompletion: completion];
}

/**
 * Lists files, and directories in the current directory.
 * @param {void(^)( NSArray* items )} the result callback where we will provide a array of
 *    strings.
 
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

#pragma mark Data Source Implmentation

/**
 * Gets the object with the specified key, or returns NULL.
 * @param {NSString*} the key to get the object for.
 * @param {IonRawDataSourceResultBlock} the block where the result will be returned.
 
 */
- (void) objectForKey:(NSString*) key withResultBlock:(IonRawDataSourceResultBlock) result {
    IonPath *resultingPath;
    if ( !key || ![key isKindOfClass: [NSString class]] || !result )
        return;
    
    resultingPath = [_path pathAppendedByElements: [IonPath componentsFromString: key]];
    if ( !resultingPath ) {
        result( NULL );
        return;
    }
    
    [IonFileIOmanager openDataAtPath: resultingPath withResultBlock: ^(id returnedObject) {
        if ( !returnedObject || ![returnedObject isKindOfClass: [NSData class]] ) {
            result( NULL );
            return;
        }
        // Return it!
        result( returnedObject );
    }];
}

/**
 * Sets the object for the specified key.
 * @param {NSString*} the key for the object to set.
 * @param {id} the object to put in the data system.
 * @param {IonRawDataSourceCompletion} the completion.
  returns false if the operation isn't valid.
 */
- (void) setObject:(id) object forKey:(NSString*) key withCompletion:(IonRawDataSourceCompletion) completion {
    IonPath* resultingPath;
    NSData* dataToSave;
    if ( !key || ![key isKindOfClass: [NSString class]] || !object )
        return;
    
    // Get a path for the key...
    resultingPath = [_path pathAppendedByElements: [IonPath componentsFromString: key]];
    if ( !resultingPath ) {
        if ( completion )
            completion( [NSError errorWithDomain: @"Failed to create path." code: 0 userInfo: NULL] );
        return;
    } else if ( ![IonFileIOmanager directoryExsistsAtPath: [resultingPath parentPath]] )
        [[NSFileManager defaultManager] createDirectoryAtPath: [[resultingPath parentPath] toString]
                                  withIntermediateDirectories: TRUE
                                                   attributes: NULL
                                                        error: NULL];
    
    
    
    dataToSave = [NSData dataFromObject: object];
    if ( !dataToSave )  {
        // Well shit, looks like someone forgot to implment any known converion methods...
        if ( completion )
            completion( [NSError errorWithDomain: @"Failed to convert format!" code: 0 userInfo: NULL] );
        return;
    }
    
    // Save the data!
    [IonFileIOmanager saveData: dataToSave atPath: resultingPath withCompletion: ^( NSError *error ) {
        //NSLog(@"Atmpted to make File at '%@'", resultingPath);
        if ( !error )
            ;//NSLog(@"Wrote File at '%@'", resultingPath);
        if ( completion )
            completion ( error );
    }];
}

/**
 * Removes an object for the specified key.
 * @param {NSString*} the key to remove the object for.
 * @param {IonRawDataSourceCompletion} the completion.
 
 */
- (void) removeObjectForKey:(NSString*) key withCompletion:(IonRawDataSourceCompletion) completion {
    IonPath* resultingPath;
    if ( !key || ![key isKindOfClass: [NSString class]] )
        return;
    
    // Get a path for the key...
    resultingPath = [_path pathAppendedByElements: [IonPath componentsFromString: key]];
    if ( !resultingPath ) {
        if ( completion )
            completion( [NSError errorWithDomain: @"Failed to create path." code: 0 userInfo: NULL] );
        return;
    }
    
    [IonFileIOmanager deleteItem: resultingPath withCompletion: ^( NSError *error ) {
       if ( completion )
           completion( error );
    }];
}

/**
 * Removes all objects for data source.
 * @param {IonRawDataSourceCompletion} the completion.
 
 */
- (void) removeAllObjects:(IonRawDataSourceCompletion) completion {
    __block NSString* item;
    __block IonRawDataSourceCompletion blockCompletion;
    
    blockCompletion = completion;
    // Get a list of items at our current path...
    [IonFileIOmanager listItemsAtPath: _path  withResultBlock: ^(id returnedObject) {
        if ( !returnedObject || ![returnedObject isKindOfClass: [NSArray class]] ) {
            if ( blockCompletion )
                blockCompletion( [NSError errorWithDomain: @"Could not get the directory contents manifest."
                                                code: 0
                                            userInfo: NULL]);
            return;
        }
        
        // Go through the items and delete all of them
        for ( NSInteger i = [(NSArray*)returnedObject count] - 1; i >= 0; --i ) {
            item = [(NSArray*)returnedObject objectAtIndex: i];
            if ( item && [item isKindOfClass: [NSString class]] )
                [IonFileIOmanager deleteItem: [_path pathAppendedByElement: item]
                              withCompletion: i == 0 && blockCompletion ? // only call completion on last
                                ^(NSError *error) {  blockCompletion( NULL ); } : NULL];
        }
    }];
}

/**
 * The data sources options.
 * @returns {IonDataSourceLocation} the location of the data source.
 */
- (IonDataSourceLocation) location {
    return IonDataSourceLocationStorage;
}

#pragma mark Debug Description

/**
 * The debug description.
 * @retuns {NSString*}
 */
- (NSString*) description {
    return [NSString stringWithFormat: @"Derectory Path: %@", [_path toString]];
}
@end

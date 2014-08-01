//
//  IonFileIOmanager.m
//  Ion
//
//  Created by Andrew Hurst on 7/24/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonFileIOmanager.h"

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

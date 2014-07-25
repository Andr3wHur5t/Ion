//
//  IonFileIOmanager.h
//  Ion
//
//  Created by Andrew Hurst on 7/24/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IonFileIOmanager : NSObject
#pragma mark General Calls
/**
 * The standerd method for invoking methods on the shared Manager.
 * @param {void(^)( NSFileManager* fileManager )} the block to do your work on the file manager.
 * @returns {void}
 */
+ (void) preformBlockOnManager:(void(^)( NSFileManager* fileManager )) block;

#pragma mark Singletons

/**
 * The file IO dispatch queue singleton.
 * @returns {dispatch_queue_t}
 */
+ (dispatch_queue_t) fileIOdispatchQueue;

@end

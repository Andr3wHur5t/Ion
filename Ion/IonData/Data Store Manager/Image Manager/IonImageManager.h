//
//  IonImageManager.h
//  Ion
//
//  Created by Andrew Hurst on 7/25/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IonImageRef;

/** The return callback.
 */
typedef void(^IonImageReturn)( UIImage* image );

@interface IonImageManager : NSObject

#pragma mark Construction


#pragma mark Data Management

// Add Image and key to Store


// Remove Image with key from store

// Key pair list.

// Expression date


#pragma mark Interfacing

/**
 * Gets the raw image from the file system with the specified key.
 * @param {NSString*} the key for the image to get.
 * @param {IonImageReturn} the callback we will call with the resulting Image.
 * @returns {void}
 */
- (void) getRawImageFromKey:(NSString*) key withReturnCallback:(IonImageReturn) returnCallback;

/**
 * Gets the raw image from the file system using the provided imageRef object.
 * @param {IonImageRef*} the image reference to use for obtaining the image.
 * @param {IonImageReturn} the callback we will call with the resulting Image.
 * @returns {void}
 */
- (void) getRawImageFromReference:(IonImageRef*) reference withReturnCallback:(IonImageReturn) returnCallback;

/**
 * Gets a resized image using the key to retrieve it from the file system, or the cache.
 * @param {NSString*} the key for the raw image.
 * @param {CGSize} the size to resize the image to.
 * @param {IonImageReturn} the callback we will call with the resulting Image.
 * @returns {void}
 */
- (void) getRawImageFromKey:(NSString*) key
                   withSize:(CGSize) size
          andReturnCallback:(IonImageReturn) returnCallback;

/**
 * Gets a resized image using the key to retrieve it from the file system, or the cache.
 * @param {NSString*} the key for the raw image.
 * @param {CGSize} the size to resize the image to.
 * @param {IonImageReturn} the callback we will call with the resulting Image.
 * @returns {void}
 */
- (void) getRawImageFromReference:(IonImageRef*) reference
                         withSize:(CGSize) size
                andReturnCallback:(IonImageReturn) returnCallback;

#pragma mark Cache Management

/**
 * Clears all cache data.
 * @returns {void}
 */
- (void) clearCache;

#pragma mark Singletons

/**
 * The image manager singleton.
 * @returns {IonImageManager} Singleton, or NULL if invalid.
 */
+ (IonImageManager*) sharedManager;

/**
 * The image managers' dispatch queue.
 * @returns {dispatch_queue_attr_t} the queue which we will dispatch all requests.
 */
+ (dispatch_queue_attr_t) imageManagerDispatchQueue;

@end

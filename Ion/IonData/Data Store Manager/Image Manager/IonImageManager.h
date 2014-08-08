//
//  IonImageManager.h
//  Ion
//
//  Created by Andrew Hurst on 7/25/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IonSimpleCache.h"

@class IonImageRef;

@interface IonImageManager : IonSimpleCache
#pragma mark Construction

/**
 * Constructs the default Interface Images Manifest.
 */
+ (IonImageManager*) interfaceManager;

#pragma mark Data Management

// Add Image and key to Store

// Remove Image with key from store

// Key pair list.

// Expression date


#pragma mark Interface

/**
 * Gets the image from the file system with the specified key.
 * @param {NSString*} the key for the image to get.
 * @param {IonImageReturn} the callback we will call with the resulting Image.
 * @returns {void}
 */
- (void) getImageForKey:(NSString*) key withReturnCallback:(IonImageReturn) returnCallback;

/**
 * Gets a resized image using the key to retrieve it from the file system, or the cache.
 * @param {NSString*} the key for the raw image.
 * @param {CGSize} the size to resize the image to.
 * @param {IonImageReturn} the callback we will call with the resulting Image.
 * @returns {void}
 */
- (void) getImageForKey:(NSString*) key
               withSize:(CGSize) size
      andReturnCallback:(IonImageReturn) returnCallback;

/**
 * Resizes an image, and stores it in the cache.
 *
 */

#pragma mark Singletons

/**
 * The image manager singleton.
 * @returns {IonImageManager}
 */
+ (IonImageManager*) sharedInterfaceManager;

@end

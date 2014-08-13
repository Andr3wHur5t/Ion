//
//  IonImageManager.h
//  Ion
//
//  Created by Andrew Hurst on 7/25/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IonSimpleCache.h"


static NSString* sIonImageMaagerPlaceholderImageKey = @"placeholder";
@class IonImageRef;

@interface IonImageManager : IonSimpleCache
#pragma mark Construction


#pragma mark Data Management

/**
 * Adds an image to the data store.
 * @param {UIImage*} the image to add.
 * @param {NSString*} the key to add the image with.
 * @param {IonCompletionBlock} the completion block to call once we are finised
 */
- (void) addImage:(UIImage*) image forKey:(NSString*) key usingCompletionBlock:(IonCompletionBlock) completion;

/**
 * Removes an image from the cache using the specified key.
 */

// Expression date


#pragma mark Interface

/**
 * Gets the image from the file system with the specified key.
 * @param {NSString*} the key for the image to get.
 * @param {IonImageReturn} the callback we will call with the resulting Image.
 * @returns {void}
 */
- (void) imageForKey:(NSString*) key withReturnCallback:(IonImageReturn) returnCallback;

/**
 * Gets a resized image using the key to retrieve it from the file system, or the cache.
 * @param {NSString*} the key for the raw image.
 * @param {CGSize} the size to resize the image to.
 * @param {IonImageReturn} the callback we will call with the resulting Image.
 * @returns {void}
 */
- (void) imageForKey:(NSString*) key
            withSize:(CGSize) size
   andReturnCallback:(IonImageReturn) returnCallback;

/**
 * Gets a resized image using the key to retrieve it from the file system, or the cache.
 * @param {NSString*} the key for the raw image.
 * @param {CGSize} the size to resize the image to.
 * @param {BOOL} stateing weither the image is contained.
 * @param {IonImageReturn} the callback we will call with the resulting Image.
 * @returns {void}
 */
- (void) imageForKey:(NSString*) key
            withSize:(CGSize) size
            contined:(BOOL) isContained
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
+ (IonImageManager*) interfaceManager;

@end

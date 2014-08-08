//
//  IonImageManager.m
//  Ion
//
//  Created by Andrew Hurst on 7/25/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonImageManager.h"

static NSString *sIonInterfaceImageManagerCacheGroupName = @"interfaceImages";

@interface IonImageManager ()

/**
 * Our Manifest of images and options in the bundle
 */
@property (strong, nonatomic) NSMutableDictionary* bundleManifest;

@end


/* ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== =====
 *                                      Interface
 * ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== */
@implementation IonImageManager
#pragma mark Construction

/**
 * Default constructor.
 * @returns {instancetype}
 */
- (instancetype) init {
    self = [super init];
    if ( self )
        _bundleManifest = [@{} mutableCopy];
    return self;
}

/**
 * Constructs a cache in the caches directory with the specified name.
 * @param {NSString*} the cache directory name.
 * @param {IonCompletionBlock} the completion thats called once the manifest is loaded.
 * @returns {instancetype}
 */
- (instancetype) initWithName:(NSString*) name withLoadCompletion:(IonCompletionBlock) manifestLoadCompletion {
    self = [super initWithName: name withLoadCompletion: manifestLoadCompletion];
    if ( self )
        ;
    return self;
}

/**
 * Constructs an image manager using the inputed name as the bundle manifest, and cache directory.
 * @param {NSString*} name
 * @returns {IonImageManager*}
 */
+ (IonImageManager*) imageManagerWithName:(NSString*) name {
    return [[IonImageManager alloc] initWithName:name];
    
}

/**
 * Constructs the default Interface Images Manifest.
 */
+ (IonImageManager*) interfaceManager {
    return [IonImageManager imageManagerWithName: sIonInterfaceImageManagerCacheGroupName];
}

#pragma mark Manifest Management 



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
- (void) getImageForKey:(NSString*) key withReturnCallback:(IonImageReturn) returnCallback {
    
}

/**
 * Gets a resized image using the key to retrieve it from the file system, or the cache.
 * @param {NSString*} the key for the raw image.
 * @param {CGSize} the size to resize the image to.
 * @param {IonImageReturn} the callback we will call with the resulting Image.
 * @returns {void}
 */
- (void) getImageForKey:(NSString*) key
               withSize:(CGSize) size
      andReturnCallback:(IonImageReturn) returnCallback {
}

/**
 * Resizes an image, and stores it in the cache.
 *
 */

#pragma mark Singletons

/**
 * The image manager singleton.
 * @returns {IonImageManager}
 */
+ (IonImageManager*) sharedInterfaceManager {
    return NULL;
}

@end





/* ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== =====
 *                                      Ion Size
 * ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== */

@interface IonSize : NSObject
#pragma mark Constructors
/**
 * Constructs a Ion Size.
 * @returns {IonSize}
 */
+ (IonSize*) sizeWithSize:(CGSize) size;

/**
 * Constructs a Ion Size.
 * @returns {instancetype}
 */
- (instancetype) initIonSize:(CGSize) size;

#pragma mark Size
/** The size object
 */
@property (assign, nonatomic) CGSize size;

@end


@implementation IonSize

#pragma mark Constructors
/**
 * Constructs a Ion Size.
 * @returns {IonSize}
 */
+ (IonSize*) sizeWithSize:(CGSize) size {
    return [[IonSize alloc] initIonSize: size];
}

/**
 * Constructs a Ion Size.
 * @returns {instancetype}
 */
- (instancetype) initIonSize:(CGSize) size {
    self = [self init];
    if ( self )
        self.size = size;
    return self;
}

@end



//
//  IonImageManager.m
//  Ion
//
//  Created by Andrew Hurst on 7/25/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonImageManager.h"


#import "IonFileIOmanager.h"
#import "UIImage+IonImage.h"
#import "ImageManifest.h"
#import "IonRenderUtilities.h"
#import "IonPath.h"

#import <SimpleMath/SimpleMath.h>
#import <FOUtilities/FOUtilities.h>
#import <IonData/IonData.h>


static NSString *sIonInterfaceImageManagerCacheGroupName = @"interfaceImages";
static NSString *sIonImageManagerBundleManifestExtension = @".manifest";
static NSString *sIonImageManagerStandardFileExtension = @".png";

@interface IonImageManager ()
/**
 * Our Manifest of images and options in the bundle
 */
@property (strong, nonatomic) NSMutableDictionary* bundleManifest;

/**
 * States the bundle manifest has loaded. // TODO: Replace with an event chain
 */
@property (assign, nonatomic) BOOL bundleManifestHasLoaded;

/**
 * The name of the group.
 */
@property (strong, nonatomic) NSString* groupName;
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
    __block BOOL otherDidLoad = FALSE;
    __block NSError* err;
    __block IonCompletionBlock completion = ^( NSError* error ) {
        if ( error )
            err = error;
        
        if ( manifestLoadCompletion && otherDidLoad ) {
            manifestLoadCompletion( err );
        }
        otherDidLoad = TRUE;
    };
    self = [super initWithName: name withLoadCompletion: completion];
    if ( self ) {
        _groupName = name;
        [self loadBundleManifest:completion];
    }
    return self;
}

/**
 * Constructs an image manager using the inputed name as the bundle manifest, and cache directory.
 * @param {NSString*} name
 * @returns {IonImageManager*}
 */
+ (IonImageManager*) imageManagerWithName:(NSString*) name {
    return [[IonImageManager alloc] initWithName:name withLoadCompletion: NULL];
    
}

/**
 * Constructs an image manager using the inputed name as the bundle manifest, and cache directory.
 * @param {NSString*} name
 * @returns {IonImageManager*}
 */
+ (IonImageManager*) imageManagerWithName:(NSString*) name andCompletion:(IonCompletionBlock) completion {
    return [[IonImageManager alloc] initWithName:name withLoadCompletion: completion];
    
}

#pragma mark Generation Blocks

/**
 * Gets the generation block for image.
 * @returns {IonAsyncGenerationBlock}
 */
- (IonAsyncGenerationBlock) imageGenBlock {
    return ^( id data, IonResultBlock resultBlock ) {
        if ( !data || ![data isKindOfClass:[NSData class]] ) {
            resultBlock( NULL );
            return;
        }
        
        resultBlock( [(NSData*)data toImage] );
    };
}

#pragma mark Manifest Management 

/**
 * Gets the bundle path of the group.
 * @returns {NSString*}
 */
- (IonPath*) bundleManifestPath {
    return [[IonPath bundleDirectory] pathAppendedByElement: [_groupName stringByAppendingString:sIonImageManagerBundleManifestExtension]];
}

/**
 * Respond to state change in bundle has loaded.
 * @param {BOOL} the new value
 * @return {void}
 */
- (void) setBundleManifestHasLoaded:(BOOL)bundleManifestHasLoaded {
    _bundleManifestHasLoaded = bundleManifestHasLoaded;
    
    // Go through the queue of pending items.
    // TODO: ADD
}

/**
 * Loads the bundle manifest.
 */
- (void) loadBundleManifest:(IonCompletionBlock)completion {
    [NSDictionary dictionaryAtPath: [self bundleManifestPath]
                  usingResultBlock: ^(id returnedObject) {
                      NSMutableDictionary* dict = [(NSDictionary*)returnedObject mutableCopy];
                      
                      // Add the placeholder
                      [dict setObject: [IonImageManager placeholderItem] forKey:sIonImageMaagerPlaceholderImageKey];
                      
                      // Set the dictionary
                      _bundleManifest = dict;
                      self.bundleManifestHasLoaded = TRUE;
                      
                      if( completion )
                          completion( NULL );
                  }];
}

/**
 * Creates the placeholder element dictionary.
 * @returns {NSDictionary*}
 */
+ (NSDictionary*) placeholderItem {
    return @{
             sIonImageManifestItem_FileName: @"placeholder.png",
             sIonImageManifestItem_InfoObject: @{ @"IsMask": @1}
             };
}

#pragma mark Data Management
/**
 * Adds an image to the data store.
 * @param {UIImage*} the image to add.
 * @param {NSString*} the key to add the image with.
 * @param {IonCompletionBlock} the completion block to call once we are finised
 */
- (void) addImage:(UIImage*) image forKey:(NSString*) key usingCompletionBlock:(IonCompletionBlock) completion {
    NSString* cleanKey = [NSDictionary sanitizeKey: key];
    [self setObject: [NSData dataFromImage: image]
             forKey: [cleanKey stringByAppendingString: sIonImageManagerStandardFileExtension]
     withCompletion:  completion];
}

// Remove Image with key from store


#pragma mark Interface

/**
 * ***** FOR INTERNAL USE ONLY *****
 * Gets the image from the file system with the specified key.
 * @param {NSString*} the key for the image to get.
 * @param {IonImageReturn} the callback we will call with the resulting Image.
 */
- (void) imageForKey:(NSString*) key withReturnCallback:(IonImageReturn) returnCallback {
    __block UIImage* resultingImage;
    __block NSString *fileName, *cleanKey;
    __block NSDictionary *imageInfo;
    __block IonImageReturn resultBlock;
    // Validate
    if ( !key || ![key isKindOfClass: [NSString class]] ||  !returnCallback )
        return;
    
    // Make the data safe
    cleanKey = [NSDictionary sanitizeKey: key];
    fileName = [_bundleManifest fileNameForKey: cleanKey];
    imageInfo = [_bundleManifest infoForKey: cleanKey];
    resultBlock = returnCallback;
    
    //Check Cache
    [self objectForKey: key usingGenerationBlock: [self imageGenBlock] withResultBlock:^(id object) {
        // Return it if we got it!
        resultingImage = object;
        if ( resultingImage ) {
            [resultingImage setInfo: imageInfo];
            resultBlock( resultingImage );
            return;
        }
        
        // Ok, now we need to check the Bundle
        [self imageFromBundleUsingName: fileName andResultBlock: ^(UIImage *image) {
            resultingImage = image;
            [resultingImage setInfo: imageInfo];
            resultBlock( resultingImage );
        }];
    }];
}

/**
 * Gets an Image from the bundle asynchronously.
 * @param {NSString*} the file name to load.
 * @param {IonImageReturn} the callback we will call with the resulting Image.
 
 */
- (void) imageFromBundleUsingName:(NSString*) name andResultBlock:(IonImageReturn) resultBlock {
    __block IonImageReturn safeResult;
    __block NSString* safeName;
    __block UIImage* resultingImage;
    if ( !name || ![name isKindOfClass: [NSString class]] || !resultBlock ) {
        resultBlock( NULL );
        return;
    }
    safeResult = resultBlock;
    safeName = name;
    
    // Ok, now we need to check the Bundle
    dispatch_async( ionStandardDispatchQueue(), ^{
        resultingImage = [UIImage imageNamed: safeName];
        resultBlock( resultingImage );
    });
}

/**
 * Gets a resized image using the key to retrieve it from the file system, or the cache.
 * @param {NSString*} the key for the raw image.
 * @param {CGSize} the size to resize the image to.
 * @param {IonImageReturn} the callback we will call with the resulting Image.
 
 */
- (void) imageForKey:(NSString*) key
            withSize:(CGSize) size
   andReturnCallback:(IonImageReturn) returnCallback {
    [self imageForKey: key withSize: size contined: TRUE andReturnCallback: returnCallback];
}

/**
 * Gets a resized image using the key to retrieve it from the file system, or the cache.
 * @param {NSString*} the key for the raw image.
 * @param {CGSize} the size to resize the image to.
 * @param {BOOL} stateing weither the image is contained.
 * @param {IonImageReturn} the callback we will call with the resulting Image.
 
 */
- (void) imageForKey:(NSString*) key
            withSize:(CGSize) size
            contined:(BOOL) isContained
   andReturnCallback:(IonImageReturn) returnCallback {
    __block NSString *cleanKey ,*sizedKeyString, *typeString;
    __block CGSize normilizedSize;
    
    NSParameterAssert( key && [key isKindOfClass:[NSString class]] );
    NSParameterAssert( returnCallback );
    // Validate
    if ( CGSizeEqualToSize( size, CGSizeUndefined) || CGSizeEqualToSize( size, CGSizeZero) || !returnCallback ||
         !key || ![key isKindOfClass:[NSString class]] )
        return;
    
    // Get the type
    typeString = @"C";
    if ( !isContained )
        typeString = @"F";
    
    // Get the string
    cleanKey = [NSDictionary sanitizeKey: key];
    normilizedSize = [SMUtilities normilizeSizeToScreen: size];
    sizedKeyString = [cleanKey stringByAppendingFormat:@"[%ix%i]-%@", (int)normilizedSize.width, (int)normilizedSize.height, typeString];
    
    // Get the Image
    [self imageForKey: [sizedKeyString stringByAppendingString:  sIonImageManagerStandardFileExtension]
      withReturnCallback: ^(UIImage *image) {
          // See if we got our result.
            if ( CGSizeEqualToSize( normilizedSize, image.size) ) {
                returnCallback ( image );
                return;
            }
          
          // Get the bundle Image now.
          [self imageForKey: cleanKey withReturnCallback:^(UIImage *image) {
              // Generate the resized image
              [self resizeImage: image
                        withKey: sizedKeyString
                           size: size
                       contined: isContained
                 andResultBlock: returnCallback];
          }];
    }];
    
  
}

/**
 * ** Internal Call Only **
 * Resizes an image, and stores it in the cache.
 * @param {UIImage*} the image to resize.
 * @param {NSString*} the key to save the image as in the cache.
 * @param {CGSize} the size to resize the image to.
 * @param {BOOL} stateing weither the image is contained.
 * @param {IonImageResultBlock} the result block to call with the image.
 * @return {void}
 */
- (void) resizeImage:(UIImage*) image
             withKey:(NSString*) key
                size:(CGSize) size
            contined:(BOOL) isContained
      andResultBlock:(IonImageReturn) resultBlock {
    __block IonImageReturn ret, cacheBlock;
    __block NSString* blockKey;
    
    // Validate
    if ( !image || ![image isKindOfClass:[UIImage class]] ||
         !key || ![key isKindOfClass:[NSString class]] ||
        CGSizeEqualToSize(size, CGSizeUndefined) || CGSizeEqualToSize(size, CGSizeZero)) {
        if ( resultBlock )
            resultBlock( NULL );
        return;
    }
    if ( !resultBlock )
        return;
    // Get the block key
    blockKey = key;
    ret = resultBlock;
    
    
    // Set the cache block
    cacheBlock = ^(UIImage *image) {
        ret ( image );
        if ( !image )
            return;
        
        // Save the data to the cache.
            [self addImage: image
                    forKey: blockKey
      usingCompletionBlock: NULL];
    };
    
    // Switch To Mode Based
    if ( isContained )
        [IonRenderUtilities renderImage: image
                             withinSize: size
                         andReturnBlock: cacheBlock];
    else
        [IonRenderUtilities renderImage: image
                               withSize: size
                         andReturnBlock: cacheBlock];
    
    
}


/**
 * Finished Current Tasks Callback.
 * @peram {void(^)( )} the callback.
 
 */
- (void) tasksDidComplete:(void(^)( )) completion {
    if ( !completion )
        return;
    
    dispatch_async([IonRenderUtilities renderDispatchQueue], ^{
        dispatch_async( dispatch_get_main_queue(), ^{
            completion( );
        });
    });
}


#pragma mark Singletons


/**
 * The image manager singleton.
 * @returns {IonImageManager}
 */
+ (IonImageManager*) interfaceManager {
    static dispatch_once_t interfaceManager_OnceToken;
    static IonImageManager* interfaceImageManeger;
    
    dispatch_once( &interfaceManager_OnceToken, ^{
        interfaceImageManeger = [IonImageManager imageManagerWithName: sIonInterfaceImageManagerCacheGroupName];
    });
    
    return interfaceImageManeger;
}

@end



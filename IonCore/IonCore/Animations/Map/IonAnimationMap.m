//
//  IonAnimationMap.m
//  Ion
//
//  Created by Andrew Hurst on 9/20/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonAnimationMap.h"
#import "IonAnimationFrame.h"

#import <IonData/IonData.h>

@interface IonAnimationMap ()

/**
 * Raw Configuration.
 */
@property (strong, nonatomic, readwrite) NSDictionary* rawConfig;

/**
 * Frames cache.
 */
@property (strong, nonatomic, readonly) IonAccessBasedGenerationMap *frames;

@end

@implementation IonAnimationMap

@synthesize frames = _frames;

#pragma mark Construction
/**
 * Constructs the map with the inputted dictionary.
 * @param {NSDictionary*} the configuration dictionary  
 */
- (instancetype) initWithDictionary:(NSDictionary *)dict {
    NSParameterAssert( dict && [dict isKindOfClass: [NSDictionary class]] );
    if ( !dict || ![dict isKindOfClass: [NSDictionary class]] )
        return NULL;
    
    self = [self init];
    if ( self )
        self.rawConfig = dict;
    return self;
}

/**
 * Constructs witht the inputted name as the file name in the bundel.
 * @param {NSString*} the key for the name in the bundel.  
 */
- (instancetype) initWithName:(NSString *)name {
    return [self initWithPath: [[IonPath bundleDirectory]
                                pathAppendedByElement: [name stringByAppendingString: sIonAnimationFileExtension]]];
}

/**
 * Constructs the the inputted path.
 * @param {IonPath*} the path of the animation configuration file.  
 */
- (instancetype) initWithPath:(IonPath *)path {
    NSData* file;
    NSDictionary* animationConfig;
    
    NSParameterAssert( path && [path isKindOfClass: [IonPath class]] );
    if ( !path || ![path isKindOfClass: [IonPath class]] )
        return NULL;
    
    file = [[NSFileManager defaultManager] contentsAtPath: [path toString]];
    if ( !file || ![file isKindOfClass:[NSData class]] ) {
        NSLog( @"%s - File does not exsist! %@", __PRETTY_FUNCTION__, path );
        return NULL;
    }
    
    animationConfig = [file toJsonDictionary];
    if ( !animationConfig || ![animationConfig isKindOfClass: [NSDictionary class]] ) {
        NSLog( @"%s - Failed to parse JSON.", __PRETTY_FUNCTION__ );
        return NULL;
    }
    
    return [self initWithDictionary: animationConfig];
}

#pragma mark Raw Configuration
/**
 * Sets the raw configuration.
 * @param {NSDictionary*} the new configuration.
 */
- (void) setRawConfig:(NSDictionary *)rawConfig {
    NSParameterAssert( rawConfig && [rawConfig isKindOfClass: [NSDictionary class]] );
    if ( !rawConfig || ![rawConfig isKindOfClass: [NSDictionary class]] )
        return;
    
    _rawConfig = rawConfig;
    
    // Update our internal states
    [self.frames setRawData: [_rawConfig dictionaryForKey: sIonAnimationMap_FramesKey]];
}

#pragma mark Frames
/**
 * Gets the frame for the inputted key.
 * @param {NSString*} the key for the frame.
 * @return {IonAnimationFrame}
 */
- (IonAnimationFrame *)frameForKey:(NSString *)key {
    return [self.frames objectForKey: key
                usingGenerationBlock: [self frameGenerationBlock]];
}

/**
 * Gets, or constructs the frames' ABGM.
 * @return {IonAccessBasedGenerationMap*}
 */
- (IonAccessBasedGenerationMap *)frames {
    if ( !_frames )
        _frames = [[IonAccessBasedGenerationMap alloc] init];
    return _frames;
}

/**
 * The frames generation block.
 * @return {id(^)( id data )}
 */
- (id(^)( id data )) frameGenerationBlock {
    return ^id( id data ){
        if ( !data || ![data isKindOfClass: [NSDictionary class]] )
            return NULL;
        return [[IonAnimationFrame alloc] initWithDictionary: data];
    };
}

#pragma mark Cache Methods
/**
 * Cache of all loaded maps.
 * @param {NSString*} the name for the specified cache.
 * @return {IonAnimationMap*}
 */
+ (IonAnimationMap *)mapForName:(NSString *)name {
    IonAnimationMap *animationMap;
    NSParameterAssert( name && [name isKindOfClass: [NSString class]] );
    if ( !name || ![name isKindOfClass: [NSString class]] )
        return NULL;
    
    // Check Cache
    animationMap = [[[self class] cache] objectForKey: name];
    if ( !animationMap ) {
        // Not in Cache Try File system
        animationMap = [[IonAnimationMap alloc] initWithName: name];
        
        if ( animationMap ) // Add the constructed map to the cache.
            [[self class] addMapToCache: animationMap withName: name];
        
    }
    return animationMap;
}

/**
 * Adds an animation map to the cache.
 * @param {NSString*} the name to add the map for.
 * @param {IonAnimationMap*} the map to add to the cache.
 */
+ (void) addMapToCache:(IonAnimationMap *)map withName:(NSString *)name {
    NSParameterAssert( map && [map isKindOfClass: [IonAnimationMap class]] );
    NSParameterAssert( name && [name isKindOfClass: [NSString class]] );
    if ( !map || ![map isKindOfClass: [IonAnimationMap class]] ||
         !name || ![name isKindOfClass: [NSString class]] )
        return;
    
    [[[self class] cache] setObject: map forKey: name];
}

/**
 * Removes the map for the specified name.
 * @param {NSString*} the name to remove.
 */
+ (void) removeMapFromCacheWithName:(NSString *)name {
    [[[self class] cache] removeObjectForKey: name];
}

/**
 * The cache object.
 * @return {NSMutableDictionary*}
 */
+ (NSMutableDictionary *)cache {
    static NSMutableDictionary *cacheMap;
    static dispatch_once_t cacheMap_dispatchOnceToken;
    
    dispatch_once( &cacheMap_dispatchOnceToken, ^{
        cacheMap = [[NSMutableDictionary alloc] init];
    });
    
    return cacheMap;
}

@end

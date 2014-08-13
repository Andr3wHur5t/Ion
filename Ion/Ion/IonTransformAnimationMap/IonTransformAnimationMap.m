//
//  IonTransformAnimationMap.m
//  Ion
//
//  Created by Andrew Hurst on 8/12/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonTransformAnimationMap.h"
#import "IonTransformAnimation.h"
#import <IonData/IonData.h>

static NSString* sIonAnimationFileExtension = @".animation";

@interface IonTransformAnimationMap () {
    /**
     * The map where we will hold all transformation data
     */
    IonAccessBasedGenerationMap* transformations;
    
}
/**
 * Our Raw Configuration.
 */
@property (strong, nonatomic) NSDictionary* rawConfig;

@end

@implementation IonTransformAnimationMap
#pragma mark Constructors

/**
 * Default constructor
 */
- (instancetype) init {
    self = [super init];
    if ( self ) {
        transformations = [[IonAccessBasedGenerationMap alloc] init];
    }
    return self;
}

#pragma mark Interface

/**
 * Configures the animation map transformations at the bundle with the specified key.
 * @param {NSString*} the key for the animation.
 * @returns {void}
 */
- (void) configureWithBundleAnimationKey:(NSString*) key {
    [self configureWithAnimationAtPath: [[IonPath bundleDirectory]
                                         pathAppendedByElement: [key stringByAppendingString:sIonAnimationFileExtension]]];
}

/**
 * Configures the animation map with the transformations at the specified path.
 * @param {IonPath*} the path to get the animation from
 * @returns {void}
 */
- (void) configureWithAnimationAtPath:(IonPath*) path {
    NSData* file;
    NSDictionary* animationConfig;
    if ( !path || ![path isKindOfClass: [IonPath class]] )
        return;
    
    file = [[NSFileManager defaultManager] contentsAtPath: [path toString]];
    if ( !file || ![file isKindOfClass:[NSData class]] )
        return;
    
    animationConfig = [file toJsonDictionary];
    if ( !animationConfig || ![animationConfig isKindOfClass: [NSDictionary class]] )
        return;
    
    self.rawConfig = animationConfig;
}

/**
 * Sets the data to be used for transfomations.
 */
- (void) setRawData:(NSDictionary*) rawData {
    [transformations setRawData: rawData];
}

/**
 * Responds to seting of the raw config.
 */
- (void) setRawConfig:(NSDictionary *)rawConfig {
    if ( !rawConfig || ![rawConfig isKindOfClass:[NSDictionary class]] )
        return;
    _rawConfig = rawConfig;
    
    // Get Data from the config
    [self setRawData: [_rawConfig dictionaryForKey: sIonTransformAnimationMap_TransformationsKey]];
}

/**
 * Will execute the chain of transformations acociated with the key.
 */
- (void) executeChainForKey:(NSString*) key onView:(UIView*) view withCompletionBlock:( void(^)( )) completion {
    IonTransformAnimation* rootTransform;
    if ( !view || ![view isKindOfClass: [UIView class]] ||
        !key || ![key isKindOfClass: [NSString class]] ) {
        if ( completion )
            completion ();
        return;
    }

    rootTransform = [transformations objectForKey: key usingGenerationBlock: [self specialGenerationBlock]];
    if ( !rootTransform || ![rootTransform isKindOfClass:[IonTransformAnimation class]] )
        return;
    
    // Execute
    [rootTransform executeTransformAnimationOn: view
                                withCompletion:^(NSString *nextTarget) {
                                    // Call the completion if we are at the end of the line
                                    if ( !nextTarget || ![nextTarget isKindOfClass:[NSString class]] ) {
                                        if ( completion )
                                            completion( );
                                        return;
                                    }
                                    
                                    // Call Next
                                    [self executeChainForKey: nextTarget onView: view withCompletionBlock:completion];
                                }];
}

#pragma mark Generation Block

/**
 * The generation block to call.
 */
- (id(^)( id data )) specialGenerationBlock {
    return ^id( id data ){
        if ( !data || ![data isKindOfClass: [NSDictionary class]] )
            return NULL;
        // Convert
        return [[IonTransformAnimation alloc] initWithDictionary: data];
    };
}

@end

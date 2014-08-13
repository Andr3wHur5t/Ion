//
//  IonTransformAnimationMap.h
//  Ion
//
//  Created by Andrew Hurst on 8/12/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString* sIonTransformAnimationMap_TransformationsKey = @"tranformations";

@class IonPath;

@interface IonTransformAnimationMap : NSObject

/**
 * Configures the animation map transformations at the bundle with the specified key.
 * @param {NSString*} the key for the animation.
 * @returns {void}
 */
- (void) configureWithBundleAnimationKey:(NSString*) key;

/**
 * Configures the animation map with the transformations at the specified path.
 * @param {IonPath*} the path to get the animation from
 * @returns {void}
 */
- (void) configureWithAnimationAtPath:(IonPath*) path;

/**
 * Sets the data to be used for transfomations.
 */
- (void) setRawData:(NSDictionary*) rawData;

/**
 * Will execute the chain of transformations acociated with the key.
 */
- (void) executeChainForKey:(NSString*) key onView:(UIView*) view withCompletionBlock:( void(^)( )) completion;

@end

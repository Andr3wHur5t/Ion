//
//  IonTransformAnimation.h
//  Ion
//
//  Created by Andrew Hurst on 8/12/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 * Keys
 */
// Meta
static NSString* sIonTransformAnimation_DelayKey = @"delay";
static NSString* sIonTransformAnimation_DurationKey = @"duration";
static NSString* sIonTransformAnimation_TargetTransformKey = @"next";

// Vectors
static NSString* sIonTransformAnimation_RotationKey = @"rotation";
static NSString* sIonTransformAnimation_PositionKey = @"position";
static NSString* sIonTransformAnimation_ScaleKey = @"scale";

// Appearance
static NSString* sIonTransformAnimation_AlphaKey = @"alpha";
static NSString* sIonTransformAnimation_ColorKey = @"color";

// Debuging
static NSString* sIonTransformAnimation_LogKey = @"log";



@interface IonTransformAnimation : NSObject
#pragma mark Constructors

/**
 * Constructs the transform using the inputted dictionary.
 * @param {NSDictionary*} config
 * @returns {instancetype}
 */
- (instancetype) initWithDictionary:(NSDictionary*) config;


/**
 * Executes the transform frame on the inputted view.
 * @param {UIView*} targetView
 * @param {void(^)( NSString* nextTarget )} The Completion.
 */
- (void) executeTransformAnimationOn:(UIView*) view withCompletion:(void(^)( NSString* nextTarget )) completion;
@end

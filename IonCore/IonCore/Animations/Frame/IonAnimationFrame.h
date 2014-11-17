//
//  IonTransformAnimation.h
//  Ion
//
//  Created by Andrew Hurst on 8/12/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SMVec3;

/**
 * The completion called when an animation completes.
 * @param nextTarget - the next frame to be called according to our metadata.
 */
typedef void(^FrameAnimationCompletion)( NSString *nextTarget );


/**
 * A set of states representing a frame within a keyframe animation.
 */
@interface IonAnimationFrame : NSObject
#pragma mark Constructors
/**
 * Constructs the frame using the provided dictionary.
 * @param config - the dictionary to use for configuration.  
 */
- (instancetype) initWithDictionary:(NSDictionary *)config;

/**
 * Constructs the frame using the provided dictionary, and name.
 * @param config - the dictionary to use for configuration.
 * @param name - the name of the frame, used in debugging.  
 */
- (instancetype) initWithDictionary:(NSDictionary *)config andName:(NSString *)name;

/**
 * Constructs a frame using the provided dictionary.
 * @param config - the dictionary to use for configuration.
 */
+ (instancetype) frameWithDictionary:(NSDictionary *)config;

/**
 * Constructs a frame using the provided dictionary, and name.
 * @param config - the dictionary to use for configuration.
 * @param name - the name of the frame, used in debugging.
 */
+ (instancetype) frameWithDictionary:(NSDictionary *)config andName:(NSString *)name;

#pragma mark Execution
/**
 * Animates the target view without state, using the current frames configuration.
 * @param view - The view to animate to match the current configuration
 * @param completion - The completion to be called when the animation completes.
 */
- (void) executeTransformationOn:(UIView *)view withCompletion:(FrameAnimationCompletion) completion;

/**
 * Applies the current configuration to the view without state preservation.
 * @param view - the view to apply the frames configuration to.
 */
- (void) applyToView:(UIView *)view;

#pragma mark Meta
/**
 * A dictionary representing all transformations.
 * @warning Setting this values will set all frame properties.
 */
@property (weak, nonatomic, readwrite) NSDictionary* configuration;

/**
 * The name target frame that should be invoked after this frame executes.
 */
@property (strong, nonatomic, readwrite) NSString *targetFrameName;

/**
 * The number of used transformations in this frame.
 */
@property (assign, nonatomic, readonly) NSInteger transformationCount;

/**
 * The animations keyframe options.
 */
@property (assign, nonatomic, readwrite) UIViewAnimationOptions options;

#pragma mark Timing
/**
 * The delay before transformation occur when the frame executes.
 */
@property (assign, nonatomic, readwrite) NSTimeInterval executionDelay;

/**
 * The duration of time it takes for a frame execution to complete.
 * AKA: the time it takes for a frame to get from point A to point B.
 */
@property (assign, nonatomic, readwrite) NSTimeInterval executionDuration;

#pragma mark Perspective Transform Vectors
/**
 * The rotation value to set to the perspective when the frame executes.
 */
@property (strong, nonatomic, readwrite) SMVec3 *rotation;

/**
 * The scale value to set to the perspective when the frame executes.
 */
@property (strong, nonatomic, readwrite) SMVec3 *scale;

/**
 * The position value to set to the perspective when the frame executes.
 */
@property (strong, nonatomic, readwrite) SMVec3 *position;

#pragma mark Configuration
/**
 * The color to set to the view when the transformation executes.
 */
@property (strong, nonatomic, readwrite) UIColor *color;

/**
 * The alpha to set to the view when the transformation executes.
 */
@property (assign, nonatomic, readwrite) CGFloat alpha;

#pragma mark Debugging Tools
/**
 * Text to be displayed when the frame begins to execute.
 */
@property (strong, nonatomic, readwrite) NSString *debugText;

/**
 * The name of the frame used in log messages.
 */
@property (strong, nonatomic, readwrite) NSString *name;

#pragma mark Defaults
/**
 * Our constant default configuration.
 * @return {NSDictionary*}
 */
+ (NSDictionary*) defaultConfiguration;

@end

/**
 * The Frames configuration keys.
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

// Debugging
static NSString* sIonTransformAnimation_LogKey = @"log";

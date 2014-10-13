//
//  IonAnimation.h
//  Ion
//
//  Created by Andrew Hurst on 7/13/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * Animation Pointer Keys
 */
static NSString* sIonAnimation_AnimationKey = @"animation";
static NSString* sIonAnimation_EntryPointKey = @"entryPoint";


@class IonAnimationSession;

@interface UIView (IonAnimation)
#pragma mark Polyphase animations
/**
 * Does a dual phase animation using the inputted duration, and option.
 * @param phaseOne - phaseOne animation
 * @param phaseTwo - phaseOne animation
 * @param duration - the duration of the animation.
 * @param options - the options to execute the animation with.
 */
+ (void) animationWithPhaseOne:(void(^)( )) phaseOne
                      phaseTwo:(void(^)( )) phaseTwo
                 usingDuration:(CGFloat) duration
                 startingDelay:(CGFloat) startDelay
             intermediateDelay:(CGFloat) intermediateDelay
                       options:(UIViewAnimationOptions) options
                 andCompletion:(void(^)( )) completion;

#pragma mark Session Animations
/**
 * The current animation session.
 */
@property (weak, nonatomic, readonly) IonAnimationSession *animationSession;

/**
 * Starts the animation session with the inputted map key, and entry point.
 * @param animationName - the key for the session map. Cannot Be NULL.
 * @param entryPoint - the entry point for the animation.
 * @param completion - the completion to call.
 */
- (void) startAnimationWithName:(NSString *)animationName
                   atEntryPoint:(NSString *)entryPoint
                usingCompletion:(void(^)( )) completion;

/**
 * Starts the animation session with the inputted map key, and entry point.
 * @param animationName - the key for the animation.
 */
- (void) startAnimationWithName:(NSString *)animationName;

/**
 * Starts the animation session with the inputted map key, and entry point.
 * @param animationName - the key for the session map.
 * @param entryPoint - the entry point for the animation.
 */
- (void) startAnimationWithName:(NSString *)animationName atEntryPoint:(NSString *)entryPoint;

/**
 * Starts the animation session with the inputted animation pointer.
 * @param animationPointer - the session pointer.
 * @param completion - the completion to call.
 */
- (void) startAnimationWithPointerMap:(NSDictionary *)animationPointer andCompletion:(void(^)( )) completion;

/**
 * Starts the animation session with the inputted animation pointer.
 * @param animationPointer the session pointer.
 */
- (void) startAnimationWithPointerMap:(NSDictionary *)animationPointer;

@end

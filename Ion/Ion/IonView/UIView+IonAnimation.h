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
 * @param {void(^)( )} phaseOne animation
 * @param {void(^)( )} phaseOne animation
 * @param {CGFloat} durration
 * @param {UIAnimationOptions} options
 
 */
+ (void) animationWithPhaseOne:(void(^)( )) phaseOne
                      phaseTwo:(void(^)( )) phaseTwo
                 usingDuration:(CGFloat) durration
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
 * @param {NSString*} the key for the session map. Cannot Be NULL.
 * @param (NSString*) the entry point for the animation.
 * @param {void(^)( )} the completion to call.
 */
- (void) startAnimationWithName:(NSString *)animationName
                   atEntryPoint:(NSString *)entryPoint
                usingCompletion:(void(^)( )) completion;

/**
 * Starts the animation session with the inputted map key, and entry point.
 * @param {NSString*} the key for the animation.
 */
- (void) startAnimationWithName:(NSString *)animationName;

/**
 * Starts the animation session with the inputted map key, and entry point.
 * @param {NSString*} the key for the session map.
 * @param (NSString*) the entry point for the animation.
 */
- (void) startAnimationWithName:(NSString *)animationName atEntryPoint:(NSString *)entryPoint;

/**
 * Starts the animation session with the inputted animation pointer.
 * @param {NSString*} the session pointer.
 */
- (void) startAnimationWithPointerMap:(NSDictionary *)animationPointer andCompletion:(void(^)( )) completion;

/**
 * Starts the animation session with the inputted animation pointer.
 * @param {NSString*} the session pointer.
 */
- (void) startAnimationWithPointerMap:(NSDictionary *)animationPointer;

@end

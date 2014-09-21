//
//  IonAnimation.m
//  Ion
//
//  Created by Andrew Hurst on 7/13/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "UIView+IonAnimation.h"
#import "IonAnimationSession.h"
#import "IonAnimationMap.h"
#import <IonData/IonData.h>

@implementation UIView (IonAnimation)
#pragma mark Animations
/**
 * Does a dual phase animation using the inputted duration, and option.
 * @param {void(^)( )} phaseOne animation
 * @param {void(^)( )} phaseOne animation
 * @param {CGFloat} durration
 * @param {UIAnimationOptions} options
 * @returns {void}
 */
+ (void) animationWithPhaseOne:(void(^)( )) phaseOne
                      phaseTwo:(void(^)( )) phaseTwo
                 usingDuration:(CGFloat) durration
                 startingDelay:(CGFloat) startDelay
             intermediateDelay:(CGFloat) intermediateDelay
                       options:(UIViewAnimationOptions) options
                 andCompletion:(void(^)( )) completion {
    // Verify
    if ( !phaseOne || !phaseTwo )
        return;
    
    // Do Phase one
    [UIView animateWithDuration: durration
                          delay: startDelay
                        options: options
                     animations: phaseOne
                     completion: ^(BOOL finished) {
                         
                         // DO the phase two animation
                         [UIView animateWithDuration: durration
                                               delay: intermediateDelay
                                             options: options
                                          animations: phaseTwo
                                          completion: ^(BOOL finished) {
                                              // Invoke the phase two animation if
                                              if ( completion )
                                                  completion( );
                                          }];
                     }];
}

#pragma mark Animation Session
/**
 * Gets, or constructs the views animation session.
 * @returns {IonAnimationSession*}
 */
- (IonAnimationSession *)animationSession {
    IonAnimationSession *_animationSession = [self.catagoryVariables objectForKey: @"animationSession"];
    if ( !_animationSession ) {
        _animationSession = [[IonAnimationSession alloc] initWithView: self];
        [self.catagoryVariables setObject:_animationSession forKey: @"animationSession"];
    }
    return _animationSession;
}

#pragma mark Animation Session Ececution
/**
 * Starts the animation session with the inputted map key, and entry point.
 * @param {NSString*} the key for the session map. Cannot Be NULL.
 * @param (NSString*) the entry point for the animation.
 * @param {void(^)( )} the completion to call.
 */
- (void) startAnimationWithName:(NSString *)animationName
                   atEntryPoint:(NSString *)entryPoint
                usingCompletion:(void(^)( )) completion {
    
    NSParameterAssert( animationName && [animationName isKindOfClass: [NSString class]] );
    if ( !animationName || ![animationName isKindOfClass: [NSString class]] )
        return;

    // Configure the sesion with the correct animation map.
    self.animationSession.animationMap = [IonAnimationMap mapForName: animationName];
    
    // Start the animation at the inputted entry point, using the inputted completion.
    [self.animationSession startAtEntryPoint: entryPoint usingCompletion: completion];
}

/**
 * Starts the animation session with the inputted map key, and entry point.
 * @param {NSString*} the key for the session map.
 * @param (NSString*) the entry point for the animation.
 */
- (void) startAnimationWithName:(NSString *)animationName atEntryPoint:(NSString *)entryPoint {
    [self startAnimationWithName: animationName atEntryPoint: entryPoint usingCompletion: NULL];
}

/**
 * Starts the animation session with the inputted map key, and entry point.
 * @param {NSString*} the key for the animation.
 */
- (void) startAnimationWithName:(NSString *)animationName {
    [self startAnimationWithName: animationName atEntryPoint: NULL];
}

/**
 * Starts the animation session with the inputted session pointer.
 * @param {NSString*} the session pointer.
 */
- (void) startAnimationWithPointerMap:(NSDictionary *)animationPointer andCompletion:(void(^)( )) completion {
    NSString *entryPoint, *animationName;
    NSParameterAssert( animationPointer && [animationPointer isKindOfClass: [NSDictionary class]] );
    if ( !animationPointer || ![animationPointer isKindOfClass: [NSDictionary class]] )
        return;
    
    // Process the animation Pointer
    animationName = [animationPointer stringForKey: sIonAnimation_AnimationKey];
    if ( !animationName ) {
        NSLog( @"%s -  No animation name was provided!", __PRETTY_FUNCTION__ );
        return;
    }
    entryPoint = [animationPointer stringForKey: sIonAnimation_EntryPointKey];
    
    // Apply the animation Pointer
    [self startAnimationWithName: animationName atEntryPoint: entryPoint usingCompletion: completion];
}

/**
 * Starts the animation session with the inputted session pointer.
 * @param {NSString*} the session pointer.
 */
- (void) startAnimationWithPointerMap:(NSDictionary *)animationPointer {
    [self startAnimationWithPointerMap: animationPointer andCompletion: NULL];
}

@end

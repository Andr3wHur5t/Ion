//
//  IonTransformAnimationMap.h
//  Ion
//
//  Created by Andrew Hurst on 8/12/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IonAnimationMap;

@interface IonAnimationSession : NSObject
#pragma mark Construction
/**
 * Constructs the session with the specified view.
 * @param {UIView*} the view to construct with.
 * @returns {instancetype}
 */
- (instancetype) initWithView:(UIView *)view;

#pragma mark Configurations
/**
 * The view for the session.
 */
@property (strong, nonatomic, readonly) UIView *view;

/**
 * The animation map used in the session.
 */
@property (strong, nonatomic, readwrite) IonAnimationMap *animationMap;

#pragma mark Execution
/**
 * Starts the animation at the entry points frame.
 * @param {NSString*} the name of the entry point frame.
 * @param {void(^)( )} the completion to be called at the end of the animation.
 */
- (void) startAtEntryPoint:(NSString *)entryPoint usingCompletion:(void(^)( )) completion;

/**
 * Starts the session at the inputted entry point.
 * @param {NSString*} the frames' name which to start the animation at.
 */
- (void) startAtEntryPoint:(NSString *)entryPoint;

#pragma mark Hook Management

@end

//
//  IonViewGestureManager.h
//  Ion
//
//  Created by Andrew Hurst on 8/25/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IonViewMotionGestureDelegate <NSObject>
#pragma mark UIKit Motion Interface.
@optional

/**
 * Will be called when a motion began.
 * @param {UIEventSubtype} the motion type that began
 * @param {UIEvent*} the event object associated with the motion.
 * @returns {void}
 */
- (void) motionBegan:(UIEventSubtype) motion withEvent:(UIEvent*) event;

/**
 * Will be called when a motion canceled.
 * @param {UIEventSubtype} the motion type that canceled
 * @param {UIEvent*} the event object associated with the motion.
 * @returns {void}
 */
- (void) motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event;

/**
 * Will be called when a motion ended.
 * @param {UIEventSubtype} the motion type that ended
 * @param {UIEvent*} the event object associated with the motion.
 * @returns {void}
 */
- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event;

@end

/**
 * Manages a set of gestures
 */
@interface IonViewMotionGestureManager : NSObject <IonViewMotionGestureDelegate>


#pragma mark Deligate Management

/**
 * Adds a gesture deligate.
 * @param {id<IonViewGestureDelegate>} the gesture deligate to add.
 * @returns {void}
 */
- (void) addGestureDelegate:(id<IonViewMotionGestureDelegate>) delegate;

/**
 * Removes gesture deligates matching.
 * @param {id<IonViewGestureDelegate>} the gesture deligate to remove.
 * @returns {void}
 */
- (void) removeGestureDelegate:(id<IonViewMotionGestureDelegate>) delegate;


#pragma mark Gesture Protocol Interface
/**
 * Will be called when a motion began.
 * @param {UIEventSubtype} the motion type that began
 * @param {UIEvent*} the event object associated with the motion.
 * @returns {void}
 */
- (void) motionBegan:(UIEventSubtype) motion withEvent:(UIEvent*) event;

/**
 * Will be called when a motion canceled.
 * @param {UIEventSubtype} the motion type that canceled
 * @param {UIEvent*} the event object associated with the motion.
 * @returns {void}
 */
- (void) motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event;

/**
 * Will be called when a motion ended.
 * @param {UIEventSubtype} the motion type that ended
 * @param {UIEvent*} the event object associated with the motion.
 * @returns {void}
 */
- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event;

@end

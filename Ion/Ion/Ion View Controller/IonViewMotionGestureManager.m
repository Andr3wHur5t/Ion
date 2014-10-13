//
//  IonViewGestureManager.m
//  Ion
//
//  Created by Andrew Hurst on 8/25/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonViewMotionGestureManager.h"

@interface IonViewMotionGestureManager () {
    NSMutableArray *_beganMotionStack, *_canceledMotionStack, *_endedMotionStack;
}

/**
 * Stacks
 */
@property (strong, nonatomic, readonly) NSMutableArray* beganMotionStack;
@property (strong, nonatomic, readonly) NSMutableArray* canceledMotionStack;
@property (strong, nonatomic, readonly) NSMutableArray* endedMotionStack;

@end

@implementation IonViewMotionGestureManager

#pragma mark Stacks

/**
 * Gets or constructs the began motion stack.
 * @returns {NSMutableArray*} the motion stack
 */
- (NSMutableArray*) beganMotionStack {
    if ( !_beganMotionStack )
        _beganMotionStack = [[NSMutableArray alloc] init];
    return _beganMotionStack;
}

/**
 * Gets or constructs the cancled motion stack.
 * @returns {NSMutableArray*} the motion stack
 */
- (NSMutableArray*) canceledMotionStack {
    if ( !_canceledMotionStack )
        _canceledMotionStack = [[NSMutableArray alloc] init];
    return _canceledMotionStack;
}

/**
 * Gets or constructs the ended motion stack.
 * @returns {NSMutableArray*} the motion stack
 */
- (NSMutableArray*) endedMotionStack {
    if ( !_endedMotionStack )
        _endedMotionStack = [[NSMutableArray alloc] init];
    return _endedMotionStack;
}
#pragma mark Deligate Management

/**
 * Adds a gesture deligate.
 * @param {id<IonViewGestureDelegate>} the gesture deligate to add.
 
 */
- (void) addGestureDelegate:(id<IonViewMotionGestureDelegate>) delegate {
    NSParameterAssert( delegate && [delegate conformsToProtocol:@protocol(IonViewMotionGestureDelegate)] );
    if ( !delegate || ![delegate conformsToProtocol:@protocol(IonViewMotionGestureDelegate)] )
        return;
    [self putDelegateInCorrectStacks: delegate];
}

/**
 * Removes gesture deligates matching.
 * @param {id<IonViewGestureDelegate>} the gesture deligate to remove.
 
 */
- (void) removeGestureDelegate:(id<IonViewMotionGestureDelegate>) delegate {
    [self removeDelegateFromStacks: delegate];
}

/**
 * Puts the delegate in the correct interface maps.
 * @param {id<IonViewGestureDelegate>} the gesture deligate to add.
 
 */
- (void) putDelegateInCorrectStacks:(id<IonViewMotionGestureDelegate>) delegate {
    NSParameterAssert( delegate && [delegate conformsToProtocol:@protocol(IonViewMotionGestureDelegate)] );
    if ( !delegate || ![delegate conformsToProtocol:@protocol(IonViewMotionGestureDelegate)] )
        return;
    
    if ( [delegate respondsToSelector: @selector(motionBegan:withEvent:)] )
        [self.beganMotionStack addObject: delegate];
    if ( [delegate respondsToSelector: @selector(motionCancelled:withEvent:)] )
        [self.canceledMotionStack addObject: delegate];
    if ( [delegate respondsToSelector: @selector(motionEnded:withEvent:)] )
        [self.endedMotionStack addObject: delegate];
    
}

/**
 * Removes the delegate from all interface maps.
 * @param {id<IonViewGestureDelegate>} the gesture deligate to add.
 
 */
- (void) removeDelegateFromStacks:(id<IonViewMotionGestureDelegate>) delegate {
    NSParameterAssert( delegate && [delegate conformsToProtocol:@protocol(IonViewMotionGestureDelegate)] );
    if ( !delegate || ![delegate conformsToProtocol:@protocol(IonViewMotionGestureDelegate)] )
        return;
    
    [self.beganMotionStack removeObject: delegate];
    [self.canceledMotionStack removeObject: delegate];
    [self.endedMotionStack removeObject: delegate];
}


#pragma mark Gesture Protocol Interface

/**
 * Will be called when a motion began.
 * @param {UIEventSubtype} the motion type that began
 * @param {UIEvent*} the event object associated with the motion.
 
 */
- (void) motionBegan:(UIEventSubtype) motion withEvent:(UIEvent*) event {
    // Call all in began stack
    for ( id<IonViewMotionGestureDelegate> obj in self.beganMotionStack )
         [obj motionBegan: motion withEvent: event];
}

/**
 * Will be called when a motion canceled.
 * @param {UIEventSubtype} the motion type that canceled
 * @param {UIEvent*} the event object associated with the motion.
 
 */
- (void) motionCancelled:(UIEventSubtype) motion withEvent:(UIEvent*) event {
    // Call all in cancelled stack
    for ( id<IonViewMotionGestureDelegate> obj in self.canceledMotionStack )
        [obj motionCancelled: motion withEvent: event];
}

/**
 * Will be called when a motion ended.
 * @param {UIEventSubtype} the motion type that ended
 * @param {UIEvent*} the event object associated with the motion.
 
 */
- (void) motionEnded:(UIEventSubtype) motion withEvent:(UIEvent*) event {
    // Call all in ended stack
    for ( id<IonViewMotionGestureDelegate> obj in self.endedMotionStack )
        [obj motionEnded: motion withEvent: event];
}
@end

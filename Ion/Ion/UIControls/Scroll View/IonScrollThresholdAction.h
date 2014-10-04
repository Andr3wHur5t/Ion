//
//  IonScrollThresholdAction.h
//  Ion
//
//  Created by Andrew Hurst on 10/2/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <Ion/Ion.h>

#pragma mark Enums
// TODO: These should be standardized through out Ion
typedef enum : NSUInteger {
    IonScrollActionType_GreaterThan = 0,
    IonScrollActionType_GreaterThanOrEqualTo = 1,
    IonScrollActionType_LessThan = 2,
    IonScrollActionType_LessThanOrEqualTo = 3
} IonScrollActionType;

typedef enum : NSUInteger {
    IonScrollActionAxis_Horizontal = 0,
    IonScrollActionAxis_Vertical = 1
} IonScrollActionAxis;

@interface IonScrollThresholdAction : IonScrollAction
#pragma mark Construction

/**
 * Constructs the threshold action using the inputted type, axis, and position.
 * @param position - the position of the threshold that the scroll view must pass.
 * @param axis - the axis that the position lies on.
 * @param type - the type of check we need to perform.
 */
- (instancetype) initWithPosition:(CGFloat) position
                           onAxis:(IonScrollActionAxis) axis
                       usingCheck:(IonScrollActionType) type;


/**
 * Constructs the threshold action using the inputted type, axis, and position.
 * @param position - the position of the threshold that the scroll view must pass.
 * @param axis - the axis that the position lies on.
 * @param type - the type of check we need to perform.
 */
+ (instancetype) thresholdWithPosition:(CGFloat) position
                                onAxis:(IonScrollActionAxis) axis
                            usingCheck:(IonScrollActionType) type;

#pragma mark Specification
/**
 * The position of the threshold that the scroll view must pass.
 */
@property (assign, nonatomic, readwrite) CGFloat position;

/**
 * The axis that the position lies on.
 */
@property (assign, nonatomic, readwrite) IonScrollActionAxis axis;

/**
 * Type of check we need to perform.
 */
@property (assign, nonatomic, readwrite) IonScrollActionType type;

/**
 * States if we are required to be tracking the users finger to invoke.
 */
@property (assign, nonatomic, readwrite) BOOL trackingRequired;

/**
 * States if we are required to be observing a drag to invoke.
 */
@property (assign, nonatomic, readwrite) BOOL draggingRequired;

/**
 * States if we are required to be zooming invoke.
 */
@property (assign, nonatomic, readwrite) BOOL zoomingRequired;

/**
 * States if we are required to be decelerating invoke.
 */
@property (assign, nonatomic, readwrite) BOOL decelerationRequired;

@end

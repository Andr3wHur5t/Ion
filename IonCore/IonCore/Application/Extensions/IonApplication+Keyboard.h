//
//  IonApplication+Keyboard.h
//  Ion
//
//  Created by Andrew Hurst on 9/14/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonApplication.h"

/**
 * Singularly manages the current state of the keyboard
 */
@interface IonApplication (Keyboard)
#pragma mark Instance Variables
/**
 * Managed frame of the keyboard.
 */
@property (assign, nonatomic, readonly) CGRect keyboardFrame;

#pragma mark Instance Management
/**
 * Starts keyboard notification observation.
 * @warning Must call end on deallocation.
 */
- (void) startKeyboardObservation;

/**
 * Ends keyboard notification observation.
 */
- (void) stopKeyboardObservation;

#pragma mark Guides
/**
 * Guide which represents the top of the keyboard in the window.
 */
@property (weak, nonatomic, readonly) IonGuideLine *keyboardTop;

/**
 * Guide Which represents the height of the keyboard.
 */
@property (weak, nonatomic, readonly) IonGuideLine *keyboardHeight;

/**
 * Guide which represent the keyboards vertical position.
 */
@property (weak, nonatomic, readonly) IonGuideLine *keyboardPositionVert;
@end

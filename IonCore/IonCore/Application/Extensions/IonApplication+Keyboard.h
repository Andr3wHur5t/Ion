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
@end

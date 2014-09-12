//
//  IonInputManager.h
//  Ion
//
//  Created by Andrew Hurst on 9/9/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IonInputFilter;

/**
 * The required protocol to support input filtering on the IonInputManager.
 */
@protocol IonInputManagerFilterSpec <NSObject>
@required
/**
 * The input filter the Input manager will use.
 */
@property (strong, nonatomic, readwrite) IonInputFilter *inputFilter;

@optional
/**
 * The method that will be called when there is an error in filtering the input.
 */
- (void) inputDidFailFilter;

/**
 * The method that will be called when the return key was pressed on a input field.
 */
- (void) inputReturnKeyDidGetPressed;

@end

/**
 * A test input manager which when put as a delegate to a TextField, or a TextView will filter input 
 * according to the IonInputManagerFilterSpec protocol.
 */
@interface IonInputManager : NSObject <UITextFieldDelegate> // TODO: Add UITextViewDelegate functionality.
@end

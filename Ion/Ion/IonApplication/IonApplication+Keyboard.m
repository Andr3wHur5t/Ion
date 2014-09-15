//
//  IonApplication+Keyboard.m
//  Ion
//
//  Created by Andrew Hurst on 9/14/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonApplication+Keyboard.h"

@implementation IonApplication (Keyboard)
#pragma mark Keyboard Frame
/**
 * Switch KVO to manual mode.
 * @returns {BOOL}
 */
+ (BOOL) automaticallyNotifiesObserversOfKeyboardFrame { return FALSE; }

/**
 * Gets the current keyboard frame.
 * @returns {CGRect}
 */
- (CGRect) keyboardFrame {
    CGRect recordedRect;
    recordedRect = [[self.catagoryVariables objectForKey: @"keyboardFrame"] CGRectValue];
    return CGRectEqualToRect(recordedRect, CGRectUndefined) ? (CGRect){
                                                (CGPoint){ 0 , [UIScreen mainScreen].bounds.size.height }, CGSizeZero
                                                                    } : recordedRect;
}

#pragma mark Keyboard Observation
/**
 * Starts keyboard notification observation.
 * @warning Must call end on deallocation.
 */
- (void) startKeyboardObservation {
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(keyboardFrameChangedWithNote:)
                                                 name: UIKeyboardWillChangeFrameNotification
                                               object: NULL];
}

/**
 * Responds to changes in the notification.
 */
- (void) keyboardFrameChangedWithNote:(NSNotification *)note {
    [self willChangeValueForKey: @"keyboardFrame"];
    [self.catagoryVariables setObject: [note.userInfo objectForKey: UIKeyboardFrameEndUserInfoKey] forKey: @"keyboardFrame"];
    [self didChangeValueForKey: @"keyboardFrame"];
}
/**
 * Ends keyboard notification observation.
 */
- (void) stopKeyboardObservation {
    [[NSNotificationCenter defaultCenter] removeObserver: self
                                                    name: UIKeyboardWillChangeFrameNotification
                                                  object: NULL];
}
@end

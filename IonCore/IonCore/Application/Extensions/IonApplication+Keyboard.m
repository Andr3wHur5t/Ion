//
//  IonApplication+Keyboard.m
//  Ion
//
//  Created by Andrew Hurst on 9/14/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonApplication+Keyboard.h"
#import "IonGuideLine+DefaultConstructors.h"
#import "IonGuideLine+DependentGuides.h"

@implementation IonApplication (Keyboard)
#pragma mark Keyboard Frame

+ (BOOL) automaticallyNotifiesObserversOfKeyboardFrame { return FALSE; }


- (CGRect) keyboardFrame {
    CGRect recordedRect;
    recordedRect = [[self.categoryVariables objectForKey: @"keyboardFrame"] CGRectValue];
    return CGPointEqualToPoint( recordedRect.origin, CGPointZero) ? (CGRect){
                                                (CGPoint){ 0 , [UIScreen mainScreen].bounds.size.height }, CGSizeZero
                                                                    } : recordedRect;
}

#pragma mark Keyboard Observation

- (void) startKeyboardObservation {
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(keyboardFrameChangedWithNote:)
                                                 name: UIKeyboardWillChangeFrameNotification
                                               object: NULL];
}

- (void) keyboardFrameChangedWithNote:(NSNotification *)note {
    // Responds to changes in the notification.
    [self willChangeValueForKey: @"keyboardFrame"];
    [self.categoryVariables setObject: [note.userInfo objectForKey: UIKeyboardFrameEndUserInfoKey] forKey: @"keyboardFrame"];
    [self didChangeValueForKey: @"keyboardFrame"];
}

- (void) stopKeyboardObservation {
    [[NSNotificationCenter defaultCenter] removeObserver: self
                                                    name: UIKeyboardWillChangeFrameNotification
                                                  object: NULL];
}

#pragma mark Guides

- (IonGuideLine *)keyboardTop {
    IonGuideLine *guide = [self.categoryVariables objectForKey: @"keyboardTop"];
    if ( !guide ) {
        guide = [IonGuideLine guideWithGuide: self.keyboardPositionVert
                                     modType: IonValueModType_Subtract
                              andSecondGuide: self.keyboardHeight];
    }
    return guide;
}

- (IonGuideLine *)keyboardHeight {
    IonGuideLine *guide = [self.categoryVariables objectForKey: @"keyboardHeight"];
    if ( !guide ) {
        guide = [IonGuideLine guideWithTarget: self keyPath: @"keyboardFrame"
                           andProcessingBlock:[IonGuideTargetToken rectSizeProcessingBlockUsingMode: IonGuideLineFrameMode_Vertical]];
    }
    return guide;
}

- (IonGuideLine *)keyboardPositionVert {
    IonGuideLine *guide = [self.categoryVariables objectForKey: @"keyboardPositionVert"];
    if ( !guide ) {
        guide = [IonGuideLine guideWithTarget: self keyPath: @"keyboardFrame"
                           andProcessingBlock:[IonGuideTargetToken externalPositioningProcessingBlockUsingMode: IonGuideLineFrameMode_Vertical]];
    }
    return guide;
}

@end

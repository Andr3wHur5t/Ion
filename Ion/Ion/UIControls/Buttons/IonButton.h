//
//  IonButton.h
//  Ion
//
//  Created by Andrew Hurst on 8/10/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * This defines all states of the button.
 */
typedef enum : NSUInteger {
    IonButtonState_Norm = 0,
    IonButtonState_Down = 1,
    IonButtonState_Selected = 2,
    IonButtonState_Disabled = 3
} IonButtonStates;

@interface IonButton : UIButton

/**
 * This is the buttons current state.
 */
@property (assign, nonatomic) IonButtonStates currentState;

@end

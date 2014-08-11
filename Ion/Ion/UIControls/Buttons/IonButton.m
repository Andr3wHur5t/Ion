//
//  IonButton.m
//  Ion
//
//  Created by Andrew Hurst on 8/10/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonButton.h"
#import "UIView+IonTheme.h"

@implementation IonButton
#pragma mark Constructors

/**
 * Default Constructor
 * @returns {instancetype}
 */
- (instancetype) init {
    self = [super init];
    if ( self ) {
        self.themeConfiguration.themeElement = @"button";
        _currentState = IonButtonState_Norm;
    }
    return self;
}

/**
 * Respond to Selected State Change.
 */
- (void) setSelected:(BOOL)selected {
    [super setSelected: selected];
    
    self.currentState = selected ? IonButtonState_Selected : IonButtonState_Norm;
}

/**
 * Respond to Highlighted (Down) state change.
 */
- (void) setHighlighted:(BOOL)highlighted {
    [super setHighlighted: highlighted];
    self.currentState = highlighted ? IonButtonState_Down : IonButtonState_Norm;
}

/**
 * Respond to Enabled and Disabled state change.
 */
- (void) setEnabled:(BOOL)enabled {
    [super setEnabled: enabled];
    self.currentState = !enabled ? IonButtonState_Disabled : IonButtonState_Norm;
    
}


@end

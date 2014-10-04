//
//  IonButton.m
//  Ion
//
//  Created by Andrew Hurst on 8/10/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonButton.h"
#import <IonData/IonData.h>

@interface IonButton ( ) {
    BOOL visiblyDisabled;
    
    IonButtonStates currentPersistantState;
}

@end

@implementation IonButton
#pragma mark Constructors

/**
 * Default Constructor
 * @returns {instancetype}
 */
- (instancetype) init {
    self = [super init];
    if ( self ) {
        self.themeElement = sIonThemeElementButton;
        _currentState = currentPersistantState = IonButtonState_Norm;
        visiblyDisabled = FALSE;
        [self addTarget: self action: @selector(checkTapUp) forControlEvents: UIControlEventTouchUpInside];
    }
    return self;
}

/**
 * Respond to Selected State Change.
 */
- (void) setSelected:(BOOL)selected {
    [super setSelected: selected];
    
    self.currentState = selected ? IonButtonState_Selected : currentPersistantState;
}

/**
 * Respond to Highlighted (Down) state change.
 */
- (void) setHighlighted:(BOOL)highlighted {
    [super setHighlighted: highlighted];
    self.currentState = highlighted ? IonButtonState_Down : currentPersistantState;
}

/**
 * Respond to Enabled and Disabled state change.
 */
- (void) setEnabled:(BOOL)enabled {
    visiblyDisabled = !enabled;
    self.currentState = currentPersistantState = visiblyDisabled ? IonButtonState_Disabled : IonButtonState_Norm;
}

#pragma mark Style application

/**
 * Applies a theme style to the button.
 * @param {IonStyle*} the style to apply.
 * @returns {void}
 */
- (void) applyStyle:(IonStyle*) style {
    [super applyStyle: style];
    NSDictionary* config;
    CGSize newSize;
    
    // Validate
    NSParameterAssert( style && [style isKindOfClass:[IonStyle class]] );
    if ( !style || ![style isKindOfClass:[IonStyle class]] )
        return;
    
    // Get Element config
    config = [style.configuration dictionaryForKey: self.themeElement];
    if ( !config )
        return;
    
    // Update Size
    newSize = [config sizeForKey: sIonThemeElementButton_SizeKey];
    if ( !CGSizeEqualToSize( newSize, CGSizeUndefined) && !CGSizeEqualToSize( newSize, CGSizeZero) )
        self.frame = (CGRect){ self.frame.origin, newSize };
}

#pragma mark Custom Responses

/**
 * Checks for what type of tap occurred.
 */
- (void) checkTapUp {
    if ( [self userCanCompleteValidTap] ) {
        [self sendActionsForControlEvents: IonCompletedButtonAction];
        [self validTapCompleted];
    }
    else
        [self invalidTapCompleted];
}

/**
 * Gets called when there is a valid complete tap.
 * @returns {void}
 */
- (void) validTapCompleted {
    // Subclass this
    return;
}

/**
 * Gets called when there has been an invalid tap.
 * @return {void}
 */
- (void) invalidTapCompleted {
     // Subclass this
    return;
}

#pragma mark Utilities

/**
 * Gets if the user can complete a valid tap on the button.
 * @returns {BOOL}
 */
- (BOOL) userCanCompleteValidTap {
    return !visiblyDisabled && !self.selected;
}

@end

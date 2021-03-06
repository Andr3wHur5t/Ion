//
//  IonButtonBehavior.m
//  Ion
//
//  Created by Andrew Hurst on 8/11/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonButtonBehavior.h"
#import <IonData/IonData.h>


@implementation IonButtonBehavior

#pragma mark Button Behavior Interface

/**
 * Sets up the behavior with the button, and the info object.
 * @param {IonInterfaceButton*} the button that the delegate will administrate.
 * @param {NSDictionary*} the info object associated with the behavior  
 */
- (void) setUpWithButton:(IonInterfaceButton*) button andInfoObject:(NSDictionary*) infoObject {
    // Verify
    if ( !button || ![button isKindOfClass: [IonInterfaceButton class]] )
        return;
    
    _button = button;
    _configuration = infoObject;
    
    // Update our self
    [self updateToMatchConfiguration];
    
    // Get & update child
    [self setUpChildBehaviorWithButton: button andConfiguration: infoObject];
}

/**
 * Gets called when there is a valid complete tap.  
 */
- (void) validTapCompleted {
    if ( _childBehavior )
        [_childBehavior validTapCompleted];
}

/**
 * Gets called when there has been an invalid tap.
 * @return {void}
 */
- (void) invalidTapCompleted {
    if ( _childBehavior )
        [_childBehavior invalidTapCompleted];
}


/**
 * Informs the delegate to update the button to match the inputted state.
 * @param {IonButtonStates} currentState the current state.
 * @param {BOOL} states if the change is animated.  
 */
- (void) updateButtonToMatchState:(IonButtonStates) currentState animated:(BOOL) animated {
    if ( _childBehavior )
       [_childBehavior updateButtonToMatchState: currentState animated: animated];
}


/**
 * Sets up the child behavior 
 * @param {IonInterfaceButton*} the button to interface with
 * @param {NSDictionary*} the root configuration object to generate from.  
 */
- (void) setUpChildBehaviorWithButton:(IonInterfaceButton*) button andConfiguration:(NSDictionary*) configuration {
    id suposedChild;
    if ( !button || ![button isKindOfClass: [IonInterfaceButton class]] )
        return;
    
    // Get the child from the dictionary
    suposedChild = [IonInterfaceButton behaviorForKey: [configuration stringForKey: sIonButtonBehavior_ChildBehaviorKey]];
    if ( !suposedChild )
        return;
    
    // Our child passes our standards, adopt into the behavior
    _childBehavior = suposedChild;
    
    // Set up our new child
    [_childBehavior setUpWithButton: button
                      andInfoObject: [configuration dictionaryForKey: sIonButtonBehavior_ChildBehaviorInfoKey]];
}

/**
 * Updates our self with the current configuration.
 */
- (void) updateToMatchConfiguration {
    // Should be sub classed
}

/**
 * Informs the behavior that the view was applyed with a style.
 * @param {IonStyle*} the new style.  
 */
- (void) styleWasApplyed:(IonStyle*) style {
    // Should be sub classed
    if ( _childBehavior )
        [_childBehavior styleWasApplyed: style];
    return;
}

#pragma mark Utilities

/**
 * Gets the state key, for the specified button state.
 * @param {IonButtonStates} the state you want the key for.
 * @return {NSString*}
 */
+ (NSString*) keyForButtonState:(IonButtonStates) state {
    switch ( state ) {
        case IonButtonState_Norm:
            return @"Norm";
            break;
        case IonButtonState_Down:
            return @"Down";
            break;
        case IonButtonState_Selected:
            return @"Selected";
            break;
        case IonButtonState_Disabled:
            return @"Disabled";
            break;
        default:
            return @"Norm";
            break;
    }
}
@end

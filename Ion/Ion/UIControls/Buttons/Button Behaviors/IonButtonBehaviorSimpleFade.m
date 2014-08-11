//
//  IonButtonBehaviorSimpleFade.m
//  Ion
//
//  Created by Andrew Hurst on 8/11/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonButtonBehaviorSimpleFade.h"

@implementation IonButtonBehaviorSimpleFade
#pragma mark Constructors

/**
 * Default constructor
 */
- (instancetype)init {
    self = [super init];
    if ( self ) {
        
    }
    return self;
}


#pragma mark Behavior Protocol Implmentation

/**
 * Sets up the behavior with the button, and the info object.
 * @param {IonInterfaceButton*} the button that the delegate will administrate.
 * @param {NSDictionary*} the info object associated with the behavior
 * @returns {void}
 */
- (void) setUpWithButton:(IonInterfaceButton*) button andInfoObject:(NSDictionary*) infoObject {
    
}

/**
 * Informs the delegate that the button did complete a tap, and that it should respond accordingly.
 * @returns {void}
 */
- (void) buttonDidCompleteTap {
    
}

/**
 * Informs the delegate to update the button to match the inputted state.
 * @param {IonButtonStates} currentState the current state.
 * @param {BOOL} states if the change is animated.
 * @returns {void}
 */
- (void) updateButtonToMatchState:(IonButtonStates) currentState animated:(BOOL) animated {
    
}


@end

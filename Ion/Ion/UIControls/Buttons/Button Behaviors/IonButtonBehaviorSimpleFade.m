//
//  IonButtonBehaviorSimpleFade.m
//  Ion
//
//  Created by Andrew Hurst on 8/11/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonButtonBehaviorSimpleFade.h"
#import <IonData/IonData.h>

@interface IonButtonBehaviorSimpleFade () {
    IonVec3* currentVector;
}

@end

@implementation IonButtonBehaviorSimpleFade
#pragma mark Constructors

/**
 * Default constructor
 */
- (instancetype)init {
    self = [super init];
    if ( self ) {
        _stateEffects = [[NSMutableDictionary alloc] init];
        [self setDefaultEffectStates];
        currentVector = [IonVec3 vectorZero];
    }
    return self;
}


#pragma mark Defaults

- (void) setDefaultEffectStates {
    [_stateEffects setObject: UIColorFromRGB( 0xf5f5f5 )
                     forKey: [IonButtonBehavior keyForButtonState: IonButtonState_Norm]];
    [_stateEffects setObject: UIColorFromRGB( 0x8C8C8C )
                     forKey: [IonButtonBehavior keyForButtonState: IonButtonState_Down]];
    [_stateEffects setObject: UIColorFromRGB( 0xE8E8E8 )
                     forKey: [IonButtonBehavior keyForButtonState: IonButtonState_Selected]];
    [_stateEffects setObject: UIColorFromRGB( 0x525252 )
                     forKey: [IonButtonBehavior keyForButtonState: IonButtonState_Disabled]];
}

#pragma mark Behavior Protocol Implementation

/**
 * Informs the delegate to update the button to match the inputted state.
 * @param {IonButtonStates} currentState the current state.
 * @param {BOOL} states if the change is animated.
 * @returns {void}
 */
- (void) updateButtonToMatchState:(IonButtonStates) currentState animated:(BOOL) animated {
    [super updateButtonToMatchState: currentState animated: animated];
    __block NSString *stateKey;
    void(^ContentChangeBlock)( );
    
    // Set
    stateKey = [IonButtonBehavior keyForButtonState: currentState];
    
    // The changes to execute
    ContentChangeBlock = ^{
        // Apply the effect to the view
        self.button.backgroundColor = [_stateEffects objectForKey: stateKey];
    };
    
    // Commit the changes.
    if ( !animated )
        ContentChangeBlock( );
    else
        [UIView animateWithDuration: 0.3 animations: ContentChangeBlock];
    
}

@end

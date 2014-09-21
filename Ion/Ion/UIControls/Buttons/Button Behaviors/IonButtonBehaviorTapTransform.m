//
//  IonButtonBehaviorTouchRotate.m
//  Ion
//
//  Created by Andrew Hurst on 8/11/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonButtonBehaviorTapTransform.h"
#import <IonData/IonData.h>
#import "UIView+IonPositionAndOrientation.h"
#import "UIView+IonAnimation.h"
#import "IonAnimationSession.h"

static NSString* sIonDefaultCycleName = @"defaultCycle";
static NSString* sIonDefaultTransformName = @"defaultTransform";

@interface IonButtonBehaviorTapTransform () {
    BOOL inTransision;
    NSDictionary* rawCycles;
    NSDictionary* events;
    IonButtonStates previousState;
}

@end

@implementation IonButtonBehaviorTapTransform
#pragma mark Construction
/**
 * Default constructor
 */
- (instancetype) init {
    self = [super init];
    if ( self ) {
        inTransision = FALSE;
        previousState = IonButtonState_Norm;
        [self normilizeConfiguration];
    }
    return self;
}


#pragma mark Protocol implementation
/**
 * Gets called when there is a valid complete tap.
 * @returns {void}
 */
- (void) validTapCompleted {
    [super validTapCompleted];
    [self executeCurrentCycle];
}

/**
 * Gets called when there has been an invalid tap.
 * @return {void}
 */
- (void) invalidTapCompleted {
    [super invalidTapCompleted];
    [self fireEventWithName: sIonButtonBehavior_TapTransform_Event_ErrorKey];
}


/**
 * Informs the delegate to update the button to match the inputted state.
 * @param {IonButtonStates} currentState the current state.
 * @param {BOOL} states if the change is animated.
 * @returns {void}
 */
- (void) updateButtonToMatchState:(IonButtonStates) currentState animated:(BOOL) animated {
    [super updateButtonToMatchState: currentState animated: animated];
    
    if ( !animated &&  previousState != currentState )
        return;
    
    // Fire Events if needed
    switch ( currentState ) {
        case IonButtonState_Down:
            [self fireEventWithName: sIonButtonBehavior_TapTransform_Event_DownKey];
            break;
        case IonButtonState_Norm:
            [self fireEventWithName: sIonButtonBehavior_TapTransform_Event_UpKey];
            break;
        case IonButtonState_Selected:
            [self fireEventWithName: sIonButtonBehavior_TapTransform_Event_SelectedKey];
            break;
        case IonButtonState_Disabled:
            [self fireEventWithName: sIonButtonBehavior_TapTransform_Event_DisabledKey];
            break;
        default:
            break;
    }
    
    previousState = currentState;
}

#pragma mark Configuration
/**
 * Updates our self with the current configuration.
 */
- (void) updateToMatchConfiguration {
    self.cycles = [self.configuration dictionaryForKey: sIonButtonBehavior_TapTransform_CyclesKey];
    self.currentCycleName =  [self.configuration stringForKey: sIonButtonBehavior_TapTransform_StartCycle];
    
    [self resoleveEventInformation];
    [self normilizeConfiguration];
}

#pragma mark Cycle Execution
/**
 * Executes the current trasnsision
 * @returns {void}
 */
- (void) executeCurrentCycle {
    NSString *targetCycle;
    NSDictionary *currentCycleConfig, *animationPointer;
    if ( inTransision )
        return;
    
    [self normilizeConfiguration];
    currentCycleConfig = [self.cycles dictionaryForKey: self.currentCycleName];
    if ( !currentCycleConfig )
        return;
    
    // Get the animation pointer
    animationPointer = [currentCycleConfig dictionaryForKey: sIonButtonBehavior_TapTransform_Cycles_TargetTransform];
    if ( !animationPointer )
        return;
    
    // Get the target cycle; NOTE: if null refer to self.
    targetCycle = [currentCycleConfig stringForKey: sIonButtonBehavior_TapTransform_Cycles_TargetCycle];
    if ( !targetCycle )
        targetCycle = self.currentCycleName;
    
    [self.button startAnimationWithPointerMap: animationPointer
                                andCompletion: ^{
                                    self.currentCycleName = targetCycle;
                                }];
}

#pragma mark Events
/**
 * Processes and resolves event information.
 * @returns {void}
 */
- (void) resoleveEventInformation {
    NSDictionary* rawEvents;
    rawEvents = [self.configuration dictionaryForKey: sIonButtonBehavior_TapTransform_EventsKey];
    if ( !rawEvents )
        return;
    
    // Set
    events = [NSDictionary dictionaryWithDictionary: rawEvents];
}

/**
 * Sets of the animation with the acociated event.
 * @param {NSString*} the event name to fire.
 * @returns {void}
 */
- (void) fireEventWithName:(NSString*) name {
    NSDictionary* eventAnimation;
    if ( !events || !name || ![name isKindOfClass: [NSString class]] )
        return;
    
    eventAnimation = [events dictionaryForKey: name];
    if ( !eventAnimation )
        return;
    
    // Execute
    [self.button startAnimationWithPointerMap: eventAnimation];
}

#pragma mark Utilities
/**
 * Norilizes configuration.
 */
- (void) normilizeConfiguration {
    
    // Normilize current cycles
    if ( !_currentCycleName || [_currentCycleName isEqualToString:@""] )
        self.currentCycleName = sIonDefaultCycleName;
    
    // Normilize cycles objects
    if ( !_cycles || [_cycles count] == 0 )
        self.cycles = [self defaultCyclesObject];
    
    
}


#pragma mark Defaults
/**
 * The default cycles object
 */
- (NSDictionary*) defaultCyclesObject {
    return @{ sIonDefaultCycleName:@{
                      sIonButtonBehavior_TapTransform_Cycles_TargetCycle: sIonDefaultCycleName,
                      sIonButtonBehavior_TapTransform_Cycles_TargetTransform: sIonDefaultTransformName}
              };
}

@end

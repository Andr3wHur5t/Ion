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
#import "IonTransformAnimationMap.h"

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
    
    rawCycles = [self.configuration dictionaryForKey: sIonButtonBehavior_TapTransform_CyclesKey];
    self.currentCycleName =  [self.configuration stringForKey: sIonButtonBehavior_TapTransform_StartCycle];
    
    // Process the animation pointer
    /*[transformationsMap setRawData: [self.configuration dictionaryForKey: sIonButtonBehavior_TapTransform_TransformationsKey]];*/
    
    [self processCycle];
    [self resoleveEventInformation];
    [self normilizeConfiguration];
}

/**
 * Processes the cycles information.
 * @returns {void}
 */
- (void) processCycle {
    __block NSDictionary* animationPointer;
    __block NSMutableDictionary *mutableCycles, *currentCycle;
    if ( !rawCycles || ![rawCycles isKindOfClass:[NSDictionary class]])
        return;
    
    mutableCycles = [@{} mutableCopy];
    [rawCycles enumerateKeysAndObjectsUsingBlock: ^(id key, id obj, BOOL *stop) {
        if ( !obj || ![obj isKindOfClass:[NSDictionary class]] )
            return;
        // Construct
        currentCycle = [@{} mutableCopy];
        
        // Get
        
        // Copy target cycle
        [currentCycle setObject: [obj stringForKey: sIonButtonBehavior_TapTransform_Cycles_TargetCycle]
                         forKey:sIonButtonBehavior_TapTransform_Cycles_TargetCycle];
        
        
        
        // Create the Animation Map
        animationPointer = [self resolveAnimationPointer:
                            [obj dictionaryForKey: sIonButtonBehavior_TapTransform_Cycles_TargetTransform]];
        if ( !animationPointer ) {
            currentCycle = NULL;
            return;
        }
        [currentCycle setObject: animationPointer forKey: sIonButtonBehavior_TapTransform_Cycles_TargetTransform];
        
        // Set
        [mutableCycles setObject: currentCycle forKey: key];
        currentCycle = NULL;
    }];
    
    // Set Cycles
    self.cycles = mutableCycles;
}



#pragma mark Transform Execution

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
    
    [self executeAnimationForPointer: animationPointer withCompletion:^{
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
    NSMutableDictionary* tempEvents;
    
    rawEvents = [self.configuration dictionaryForKey: sIonButtonBehavior_TapTransform_EventsKey];
    if ( !rawEvents )
        return;
    
    tempEvents = [@{} mutableCopy];
    // Enumerate through the objects
    [rawEvents enumerateKeysAndObjectsUsingBlock: ^(id key, id obj, BOOL *stop) {
        if ( !obj || ![obj isKindOfClass:[NSDictionary class]] )
            return;
        
        // Resolve and set
        [tempEvents setObject: [self resolveAnimationPointer: obj] forKey: key];
    }];
    
    // Set
    events = [NSDictionary dictionaryWithDictionary: tempEvents];
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
    [self executeAnimationForPointer: eventAnimation withCompletion: NULL];
}

#pragma mark Animation Pointers

/**
 * Resolves Animation an animation pointer into a resolved animation pointer.
 * @param {NSDictionary*} the config to process/
 * @returns {NSDictionary*}
 */
- (NSDictionary*) resolveAnimationPointer:(NSDictionary*) config {
    NSString *animationKey, *entryPoint;
    IonTransformAnimationMap* animationMap;
    if ( !config || ![config isKindOfClass:[NSDictionary class]] )
        return NULL;
    
    animationKey = [config stringForKey: sIonButtonBehavior_TapTransform_AnimationPointer_AnimationKey];
    if ( !animationKey )
        return NULL;
    
    entryPoint = [config stringForKey: sIonButtonBehavior_TapTransform_AnimationPointer_EntryPointKey];
    if ( !entryPoint )
        return NULL;
    
    
    animationMap = [[IonTransformAnimationMap alloc] init];
    [animationMap configureWithBundleAnimationKey: animationKey];
    
    return @{
             sIonButtonBehavior_TapTransform_AnimationPointer_AnimationKey: animationMap,
             sIonButtonBehavior_TapTransform_AnimationPointer_EntryPointKey: entryPoint
             };
}

/**
 * Executes the inputted animation pointer on the button.
 * @param {NSDictionary*} animation pointer
 * @returns {void}
 */
- (void) executeAnimationForPointer:(NSDictionary*) animationPointer withCompletion:(void(^)( )) completion {
    IonTransformAnimationMap* transformationsMap;
    NSString *entryPoint;
    
    // Get the transformation map
    transformationsMap = [animationPointer objectForKey: sIonButtonBehavior_TapTransform_AnimationPointer_AnimationKey];
    if ( !transformationsMap || ![transformationsMap isKindOfClass:[IonTransformAnimationMap class]] ) {
        if ( completion )
            completion( );
        return;
    }
    
    // Get the entry point
    entryPoint = [animationPointer stringForKey: sIonButtonBehavior_TapTransform_AnimationPointer_EntryPointKey];
    if ( !entryPoint ) {
        if ( completion )
            completion( );
        return;
    }
    
    
    // Lock Mutex
   // inTransision = TRUE;
    // Perform Transform for the current key
    [transformationsMap executeChainForKey: entryPoint
                                    onView: self.button
                       withCompletionBlock: ^{
                           // Update to next cycle
                           if ( completion )
                               completion( );
                           
                           // Unlock Mutex
                           //inTransision = FALSE;
                       }];
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

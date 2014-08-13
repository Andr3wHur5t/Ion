//
//  IonButtonBehaviorTouchRotate.m
//  Ion
//
//  Created by Andrew Hurst on 8/11/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonButtonBehaviorTouchRotate.h"
#import <IonData/IonData.h>
#import "UIView+IonPositionAndOrientation.h"
#import "IonTransformAnimationMap.h"

static NSString* sIonDefaultCycleName = @"defaultCycle";
static NSString* sIonDefaultTransformName = @"defaultTransform";

@interface IonButtonBehaviorTouchRotate () {
    BOOL inTransision;
    NSDictionary* rawCycles;
}

@end

@implementation IonButtonBehaviorTouchRotate

/**
 * Default constructor
 */
- (instancetype) init {
    self = [super init];
    if ( self ) {
        inTransision = FALSE;
        [self normilizeConfiguration];
    }
    return self;
}


#pragma mark Protocol implementation
/**
 * Gets called when the tap completes
 */
- (void) buttonDidCompleteTap {
    [self executeCurrentCycle];
}

/**
 * Updates our self with the current configuration.
 */
- (void) updateToMatchConfiguration {
    
    rawCycles = [self.configuration dictionaryForKey: sIonButtonBehavior_TapTransform_CyclesKey];
    self.currentCycleName =  [self.configuration stringForKey: sIonButtonBehavior_TapTransform_StartCycle];
    
    // Process the animation pointer
    /*[transformationsMap setRawData: [self.configuration dictionaryForKey: sIonButtonBehavior_TapTransform_TransformationsKey]];*/
    
    [self processCycle];
    
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
        animationPointer = [self processAnimationMapConfig:
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


/**
 * Process Animation Map Config.
 * @param {NSDictionary*} the config to process/
 * @returns {void}
 */
- (NSDictionary*) processAnimationMapConfig:(NSDictionary*) config {
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
#pragma mark Transform Execution

/**
 * Executes the current trasnsision
 * @returns {void}
 */
- (void) executeCurrentCycle {
    IonTransformAnimationMap* transformationsMap;
    NSString *entryPoint, *targetCycle;
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
    
    // Get the transformation map
    transformationsMap = [animationPointer objectForKey: sIonButtonBehavior_TapTransform_AnimationPointer_AnimationKey];
    if ( !transformationsMap || ![transformationsMap isKindOfClass:[IonTransformAnimationMap class]] )
        return;
    
    // Get the entry point
    entryPoint = [animationPointer stringForKey: sIonButtonBehavior_TapTransform_AnimationPointer_EntryPointKey];
    if ( !entryPoint )
        return;
    
    // Get the target cycle; NOTE: if null refer to self.
    targetCycle = [currentCycleConfig stringForKey: sIonButtonBehavior_TapTransform_Cycles_TargetCycle];
    if ( !targetCycle )
        targetCycle = self.currentCycleName;
    
    
    // Lock Mutex
    inTransision = TRUE;
    // Perform Transform for the current key
    [transformationsMap executeChainForKey: entryPoint
                                    onView: self.button
                       withCompletionBlock: ^{
                           // Update to next cycle
                           self.currentCycleName = targetCycle;
        
                           // Unlock Mutex
                           inTransision = FALSE;
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

//
//  IonButtonBehaviorTouchRotate.h
//  Ion
//
//  Created by Andrew Hurst on 8/11/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonButtonBehavior.h"

/**
 * Keys
 */
static NSString* sIonButtonBehavior_TapTransform_TransformationsKey = @"tranformations";
static NSString* sIonButtonBehavior_TapTransform_EventsKey = @"events";
static NSString* sIonButtonBehavior_TapTransform_StartCycle = @"startCycle";
static NSString* sIonButtonBehavior_TapTransform_CyclesKey = @"cycles";
static NSString* sIonButtonBehavior_TapTransform_Cycles_TargetCycle = @"targetCycle";
static NSString* sIonButtonBehavior_TapTransform_Cycles_TargetTransform = @"targetTransision";

/**
 * Animation Pointer Keys
 */
static NSString* sIonButtonBehavior_TapTransform_AnimationPointer_AnimationKey = @"animation";
static NSString* sIonButtonBehavior_TapTransform_AnimationPointer_EntryPointKey = @"entryPoint";

/**
 * Event Name Keys
 */
static NSString* sIonButtonBehavior_TapTransform_Event_ErrorKey = @"error";
static NSString* sIonButtonBehavior_TapTransform_Event_DownKey =  @"toDown";
static NSString* sIonButtonBehavior_TapTransform_Event_UpKey =  @"toUp";
static NSString* sIonButtonBehavior_TapTransform_Event_SelectedKey =  @"toSelected";
static NSString* sIonButtonBehavior_TapTransform_Event_DisabledKey =  @"toDisabled";



// KEY == "TapTransform"
@interface IonButtonBehaviorTapTransform : IonButtonBehavior

/**
 * Our current cycles name.
 */
@property (strong, nonatomic) NSString* currentCycleName;

/**
 * Map of our cycles
 */
@property (strong, nonatomic) NSDictionary* cycles;



@end

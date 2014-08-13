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
static NSString* sIonButtonBehavior_TapTransform_StartCycle = @"startCycle";
static NSString* sIonButtonBehavior_TapTransform_CyclesKey = @"cycles";
static NSString* sIonButtonBehavior_TapTransform_Cycles_TargetCycle = @"targetCycle";
static NSString* sIonButtonBehavior_TapTransform_Cycles_TargetTransform = @"targetTransision";

/**
 * Animation Pointer Keys
 */
static NSString* sIonButtonBehavior_TapTransform_AnimationPointer_AnimationKey = @"animation";
static NSString* sIonButtonBehavior_TapTransform_AnimationPointer_EntryPointKey = @"entryPoint";


// KEY == "TouchRotate"
@interface IonButtonBehaviorTouchRotate : IonButtonBehavior

/**
 * Our current cycles name.
 */
@property (strong, nonatomic) NSString* currentCycleName;

/**
 * Map of our cycles
 */
@property (strong, nonatomic) NSDictionary* cycles;



@end

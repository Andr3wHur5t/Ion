//
//  IonButtonBehaviorSimpleFade.h
//  Ion
//
//  Created by Andrew Hurst on 8/11/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IonButtonBehavior.h"

// Keys
static NSString* sIonButtonSimpleFade_States = @"buttonStats";
static NSString* sIonButtonSimpleFade_States_Norm = @"norm";
static NSString* sIonButtonSimpleFade_States_Down = @"down";
static NSString* sIonButtonSimpleFade_States_Disabled = @"disabled";
static NSString* sIonButtonSimpleFade_States_Selected = @"selected";

// KEY == "SimpleFade"
@interface IonButtonBehaviorSimpleFade : IonButtonBehavior

/**
 * The current effects accociated with states.
 */
@property (strong, nonatomic, readonly) NSMutableDictionary* stateEffects;

/**
 * The current masks accociated with stated.
 */
@property (strong, nonatomic, readonly) NSDictionary* stateMasks;

@end

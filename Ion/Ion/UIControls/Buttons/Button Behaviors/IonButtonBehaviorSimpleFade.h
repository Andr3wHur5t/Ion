//
//  IonButtonBehaviorSimpleFade.h
//  Ion
//
//  Created by Andrew Hurst on 8/11/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IonButtonBehavior.h"

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

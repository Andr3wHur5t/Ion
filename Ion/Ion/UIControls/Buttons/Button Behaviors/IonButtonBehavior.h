//
//  IonButtonBehavior.h
//  Ion
//
//  Created by Andrew Hurst on 8/11/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IonInterfaceButton.h"

/**
 * Keys
 */
static NSString* sIonButtonBehavior_ChildBehaviorKey = @"childBehavior";
static NSString* sIonButtonBehavior_ChildBehaviorInfoKey = @"childInfo";

@interface IonButtonBehavior : NSObject <IonButtonBehaviorDelegate>

/**
 * The button the behavior delegates.
 */
@property (strong, nonatomic, readonly) IonInterfaceButton* button;

/**
 * The configuration Info, if any.
 */
@property (strong, nonatomic, readonly) NSDictionary* configuration;

/**
 * The child behavior if any.
 */
@property (strong, nonatomic) id<IonButtonBehaviorDelegate> childBehavior;

/**
 * Updates our self with the current configuration.
 */
- (void) updateToMatchConfiguration;

#pragma mark Utilities

/**
 * Gets the state key, for the specified button state.
 * @param {IonButtonStates} the state you want the key for.
 * @returns {NSString*}
 */
+ (NSString*) keyForButtonState:(IonButtonStates) state;

@end

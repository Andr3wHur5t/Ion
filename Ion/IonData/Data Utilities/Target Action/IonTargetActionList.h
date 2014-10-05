//
//  IonTargetActionList.h
//  Ion
//
//  Created by Andrew Hurst on 10/1/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IonTargetActionSet.h"

@interface IonTargetActionList : NSObject
#pragma mark Item Management
/**
 * Adds the target, and action to the specified group.
 * @param target - the target to invoke the action on.
 * @param action - the action to invoke on the target.
 * @param group - the group to add the target action set to.
 */
- (void) addTarget:(id) target andAction:(SEL) action toGroup:(NSString *)group;

/**
 * Removes the target action set from the specified group.
 * @param target - the target which was specified on the set before.
 * @param action -  the action which was specified on the set before.
 * @param group - the group the set should be removed from.
 */
- (void) removeTarget:(id) target andAction:(SEL) action fromGroup:(NSString *)group;

/**
 * Adds the inputted action set to the inputted group.
 * @param actionSet -  the action set to be added. Can not be NULL
 * @param group - the group to add the action set to.
 */
- (void) addActionSet:(IonTargetActionSet *)actionSet toGroup:(NSString *)group;

/**
 * Removes the inputted action set to the inputted group.
 * @param actionSet - the action set to be removed. Can not be NULL
 * @param group - the group to remove the action set from.
 */
- (void) removeActionSet:(IonTargetActionSet *)actionSet fromGroup:(NSString *)group;


#pragma mark invocation
/**
 * Invokes all target action sets in the specified group.
 * @param group - the group identifier to invoke action sets for.
 */
- (void) invokeActionSetsInGroup:(NSString *)group;

/**
 * Invokes all target action sets in the specified group with the inputted object.
 * @param group - the group identifier to invoke action sets for.
 * @param object - the object to pass on invocation of target action sets.
 */
- (void) invokeActionSetsInGroup:(NSString *)group withObject:(id) object;

#pragma mark Group Management
/**
 * Removes the specified group, and its' content.
 * @param group - the group to remove.
 */
- (void) removeGroup:(NSString *)group;

/**
 * Reports the count of items in the specified group.
 * @param group - the group to get the count of.
 */
- (NSUInteger) actionCountInGroup:(NSString *)group;

/**
 * Removes all groups, and their content.
 */
- (void) removeAllGroups;

@end

//
//  IonTargetActionList.m
//  Ion
//
//  Created by Andrew Hurst on 10/1/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonTargetActionList.h"

@interface IonTargetActionList ()

/**
 * The map with all of our group arrays.
 */
@property (strong, nonatomic, readonly) NSMutableDictionary *groupsMap;
@end

@implementation IonTargetActionList

@synthesize groupsMap = _groupsMap;

#pragma mark Groups Map
/**
 * Gets, or constructs the group map.
 */
- (NSMutableDictionary *)groupsMap {
    if ( !_groupsMap )
        _groupsMap = [[NSMutableDictionary alloc] init];
    return _groupsMap;
}

#pragma mark Item Management
/**
 * Adds the target, and action to the specified group.
 * @param target - the target to invoke the action on.
 * @param action - the action to invoke on the target.
 * @param group - the group to add the target action set to.
 */
- (void) addTarget:(id) target andAction:(SEL) action toGroup:(NSUInteger) group {
    [self addActionSet: [IonTargetActionSet setWithTarget: target andAction: action] toGroup: group];
}

/**
 * Removes the target action set from the specified group.
 * @param target - the target which was specified on the set before.
 * @param action -  the action which was specified on the set before.
 * @param group - the group the set should be removed from.
 */
- (void) removeTarget:(id) target andAction:(SEL) action fromGroup:(NSUInteger) group {
    [self removeActionSet: [IonTargetActionSet setWithTarget: target andAction: action] fromGroup: group];
}

/**
 * Adds the inputted action set to the inputted group.
 * @param actionSet -  the action set to be added. Can not be NULL
 * @param group - the group to add the action set to.
 */
- (void) addActionSet:(IonTargetActionSet *)actionSet toGroup:(NSUInteger) group {
    [[self arrayForGroup: group] addObject: actionSet];
}

/**
 * Removes the inputted action set to the inputted group.
 * @param actionSet - the action set to be removed. Can not be NULL
 * @param group - the group to remove the action set from.
 */
- (void) removeActionSet:(IonTargetActionSet *)actionSet fromGroup:(NSUInteger) group {
    [[self arrayForGroup: group] removeObject: actionSet];
}


#pragma mark invocation
/**
 * Invokes all target action sets in the specified group.
 * @param group - the group identifier to invoke action sets for.
 */
- (void) invokeActionSetsInGroup:(NSUInteger) group {
    [self invokeActionSetsInGroup: group withObject: NULL];
}

/**
 * Invokes all target action sets in the specified group with the inputted object.
 * @param group - the group identifier to invoke action sets for.
 * @param object - the object to pass on invocation of target action sets.
 */
- (void) invokeActionSetsInGroup:(NSUInteger) group withObject:(id) object {
    NSMutableArray *groupArray = [self arrayForGroup: group];
    for ( IonTargetActionSet *actionSet in groupArray)
        [actionSet invokeWithObject: object];
}

#pragma mark Group Management
/**
 * Removes the specified group, and its' content.
 * @param group - the group to remove.
 */
- (void) removeGroup:(NSUInteger) group {
    [self.groupsMap removeObjectForKey: [[self class] idToKey: group]];
}

/**
 * Removes all groups, and their content.
 */
- (void) removeAllGroups {
    [self.groupsMap removeAllObjects];
}

#pragma mark Utilties
/**
 * Converts the NSUInteger key into a NSString key.
 * @param key - the key to convert to a NSString.
 * @returns {NSString*}
 */
+ (NSString *)idToKey:(NSUInteger) keyId {
    return [NSString stringWithFormat:@"%lul", (unsigned long)keyId];
}

/**
 * Gets the array for the specified group.
 * @param {NSUInteger} the group id.
 * @returns {NSMutableArray*}
 */
- (NSMutableArray *)arrayForGroup:(NSUInteger) group {
    NSMutableArray *groupArray;
    
    // Try to get it from our group map
    groupArray = [self.groupsMap objectForKey: [[self class] idToKey: group]];
    
    // create it if if dosent exsist.
    if ( !groupArray ) {
        groupArray = [[NSMutableArray alloc] init];
        
        // Cache it to the groupsMap using the group key.
        [self.groupsMap setObject: groupArray forKey: [[self class] idToKey: group]];
    }
    return groupArray;
}

@end

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

- (NSMutableDictionary *)groupsMap {
    if ( !_groupsMap )
        _groupsMap = [[NSMutableDictionary alloc] init];
    return _groupsMap;
}

#pragma mark Item Management

- (void) addTarget:(id) target andAction:(SEL) action toGroup:(NSString *)group {
    [self addActionSet: [IonTargetActionSet setWithTarget: target andAction: action] toGroup: group];
}

- (void) removeTarget:(id) target andAction:(SEL) action fromGroup:(NSString *)group {
    [self removeActionSet: [IonTargetActionSet setWithTarget: target andAction: action] fromGroup: group];
}

- (void) addActionSet:(IonTargetActionSet *)actionSet toGroup:(NSString *)group {
    [[self arrayForGroup: group] addObject: actionSet];
}

- (void) removeActionSet:(IonTargetActionSet *)actionSet fromGroup:(NSString *)group {
    [[self arrayForGroup: group] removeObject: actionSet];
}


#pragma mark invocation

- (void) invokeActionSetsInGroup:(NSString *)group {
    [self invokeActionSetsInGroup: group withObject: NULL];
}

- (void) invokeActionSetsInGroup:(NSString *)group withObject:(id) object {
    NSMutableArray *groupArray = [self arrayForGroup: group];
    for ( IonTargetActionSet *actionSet in groupArray)
        [actionSet invokeWithObject: object];
}

#pragma mark Group Management

- (void) removeGroup:(NSString *)group {
    [self.groupsMap removeObjectForKey: group];
}

- (void) removeAllGroups {
    [self.groupsMap removeAllObjects];
}

- (NSUInteger) actionCountInGroup:(NSString *)group {
    return [self arrayForGroup: group].count;
}

#pragma mark Utilties

+ (NSString *)idToKey:(NSUInteger) keyId {
    return [NSString stringWithFormat:@"%lul", (unsigned long)keyId];
}

- (NSMutableArray *)arrayForGroup:(NSString *)group {
    NSMutableArray *groupArray;
    
    // Try to get it from our group map
    groupArray = [self.groupsMap objectForKey: group.uppercaseString];
    
    // create it if if dosent exsist.
    if ( !groupArray ) {
        groupArray = [[NSMutableArray alloc] init];
        
        // Cache it to the groupsMap using the group key.
        [self.groupsMap setObject: groupArray forKey: group.uppercaseString];
    }
    return groupArray;
}

@end

//
//  FOTargetActionList.m
//  FOUtilities
//
//  Created by Andrew Hurst on 10/7/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "FOTargetActionList.h"
#import "FOTargetActionSet.h"

@interface FOTargetActionList ()
/**
 * The map with all of our group arrays.
 */
@property (strong, nonatomic, readonly) NSMutableDictionary *groupsMap;

@end

@implementation FOTargetActionList

@synthesize groupsMap = _groupsMap;

#pragma mark Groups Map

- (NSMutableDictionary *)groupsMap {
    if ( !_groupsMap )
        _groupsMap = [[NSMutableDictionary alloc] init];
    return _groupsMap;
}

#pragma mark Item Management

- (void) addTarget:(id) target andAction:(SEL) action toGroup:(NSString *)group {
    [self addActionSet: [FOTargetActionSet setWithTarget: target andAction: action] toGroup: group];
}

- (void) removeTarget:(id) target andAction:(SEL) action fromGroup:(NSString *)group {
    [self removeActionSet: [FOTargetActionSet setWithTarget: target andAction: action] fromGroup: group];
}

- (void) addActionSet:(FOTargetActionSet *)actionSet toGroup:(NSString *)group {
    [[self arrayForGroup: group] addObject: actionSet];
}

- (void) removeActionSet:(FOTargetActionSet *)actionSet fromGroup:(NSString *)group {
    [[self arrayForGroup: group] removeObject: actionSet];
}


#pragma mark invocation

- (void) invokeActionSetsInGroup:(NSString *)group {
    [self invokeActionSetsInGroup: group withObject: NULL];
}

- (void) invokeActionSetsInGroup:(NSString *)group withObject:(id) object {
    NSMutableArray *groupArray = [self arrayForGroup: group];
    for ( FOTargetActionSet *actionSet in groupArray)
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

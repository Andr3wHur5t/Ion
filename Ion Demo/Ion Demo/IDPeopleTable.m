//
//  IDPeopleTabel.m
//  Ion Demo
//
//  Created by Andrew Hurst on 10/8/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "IDPeopleTable.h"
#import <FOUtilities/FOUtilities.h>

@interface IDPeopleTable () {
    FOKeyValueObserver *dataModelObserver;
}

@end

@implementation IDPeopleTable

#pragma mark Data Model

- (void) registerDataModelInTarget:(id) target atKeyPath:(NSString *)keyPath {
    NSArray *dataModel;
    NSParameterAssert( target );
    NSParameterAssert( [keyPath isKindOfClass: [NSString class]] );
    if ( !target || ![keyPath isKindOfClass: [NSString class]] )
        return;
    
    // Observe Object
    dataModelObserver = [FOKeyValueObserver observeObject: target
                                                  keyPath: keyPath
                                                   target: self
                                                 selector: @selector(dataModelDidChange:)];
    
    // Add the initial objects to the tabel.
    dataModel = [target valueForKeyPath: keyPath];
    if ( [dataModel isKindOfClass: [NSArray class]] )
        [self addProfiles: dataModel];
   
}

- (void) dataModelDidChange:(NSDictionary *)change {
    NSArray *changedObjects;
    changedObjects = [dataModelObserver.observedValue objectsAtIndexes: [change objectForKey: @"indexes"]];
    [self addProfiles: changedObjects];
}

#pragma mark Item Management

- (void) addProfile:(PHProfile *)profile {
    NSParameterAssert( [profile isKindOfClass: [PHProfile class]] );
    if ( ![profile isKindOfClass: [PHProfile class]] )
        return;
    NSLog( @"Add Profile with name \"%@\"", profile.name );
    
    // Construct the cell.
   
    // Set it with the profile data.
    
    // Add it to the view.
}

- (void) addProfiles:(NSArray *)profiles {
    NSParameterAssert( [profiles isKindOfClass: [NSArray class]] );
    if ( ![profiles isKindOfClass: [NSArray class]] )
        return;
    
    // Add the objects
    for ( PHProfile *profile in profiles )
        [self addProfile: profile];
}

@end

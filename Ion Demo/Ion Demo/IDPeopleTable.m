//
//  IDPeopleTable.m
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

/**
 * Our refresh view.
 */
@property (strong, nonatomic, readonly) IonScrollRefreshActionView *refreshView;
@end

@implementation IDPeopleTable

@synthesize refreshView = _refreshView;

#pragma mark Construction

- (instancetype) init {
    self = [super init];
    if ( self )
        // Add our refresh view, this will automatically configure the refresh action.
        [self addSubview: self.refreshView];
    return self;
}
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
    
    // Add the initial objects to the table.
    dataModel = [target valueForKeyPath: keyPath];
    if ( [dataModel isKindOfClass: [NSArray class]] )
        [self addProfiles: dataModel];
   
}

- (void) dataModelDidChange:(NSDictionary *)change {
    NSArray *changedObjects;
    
    // Get the changed objects
    changedObjects = [dataModelObserver.observedValue objectsAtIndexes: [change objectForKey: @"indexes"]];
    
    // Add the changed objects
    [self addProfiles: changedObjects];
}

#pragma mark Refresh View

- (IonScrollRefreshActionView *)refreshView {
    if ( !_refreshView ) {
        _refreshView = [[IonScrollRefreshActionView alloc] init];
        
        // Set refresh content view.
        
        // Register to be called when we need to refesh.
        [_refreshView addTarget: self andAction: @selector(didInitiateRefresh)];
    }
    return _refreshView;
}

- (void) didInitiateRefresh {
    NSLog( @"Did Initiate Refresh." );
    [[IACLink linkWithURLString: @"ion:///test/test/" andReason: @"Refresh"] invoke];
    
    // We are in charge of hiding the refresh view when we are done.
    [self performBlock:^{
        [self.refreshView hideAnimated];
    } afterDelay: 0.75f];
}

#pragma mark Item Management

- (void) addProfile:(PHProfile *)profile {
    UIView *cell;
    static IonGuideLine *lastGuide;
    NSParameterAssert( [profile isKindOfClass: [PHProfile class]] );
    if ( ![profile isKindOfClass: [PHProfile class]] )
        return;
    
    // Construct the cell.
    cell = [[UIView alloc] init];
    cell.themeElement = @"red";
    // Set it with the profile data.
    lastGuide = lastGuide ? lastGuide : self.topAutoPadding;
    
    [cell setGuidesWithLocalHoriz: cell.originGuideHoriz
                        localVert: cell.originGuideVert
                       superHoriz: self.leftAutoPadding
                        superVert: lastGuide
                             left: self.leftAutoPadding
                            right: self.rightAutoPadding
                              top: [@0 toGuideLine]
                        andBottom: [@65 toGuideLine]];
    
    lastGuide = cell.bottomMargin;
    // Add it to the view.
    [self addSubviewUsingStyle: cell];
    
    cell.backgroundColor = [UIColor redColor];
    // Update Content Size.
    [self setContentSizeHoriz: self.sizeGuideHoriz
                      andVert: lastGuide];
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

//
//  IonGuideSet.m
//  Ion
//
//  Created by Andrew Hurst on 10/4/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonGuideSet.h"

@interface IonGuideSet ()
#pragma mark Observers
/**
 * A list of locally managed observers.
 */
@property (strong, nonatomic, readonly) FOTargetActionList *localObservers;

@end

@implementation IonGuideSet

@synthesize guides = _guides;
@synthesize localObservers = _localObservers;

#pragma mark Guides

- (NSMutableDictionary *)guides {
    if ( !_guides )
        _guides = [[NSMutableDictionary alloc] init];
    return _guides;
}

- (void) setGuide:(IonGuideLine *)guide forKey:(NSString *)key {
    IonGuideLine *object;
    NSParameterAssert( key && [key isKindOfClass: [NSString class]] );
    if ( !key || ![key isKindOfClass: [NSString class]] )
        return;
    
    // Was there a change?
    object = [self.guides objectForKey: key];
    if ( [guide isEqual: object] )
        return; // Nope don't do anything
    
    // Was there a previous object?
    if ( object ) // Yep, unregister this guide set from it.
        [object removeLocalObserverTarget: self andAction: @selector(guideDidUpdate)];
    
    // Inform KVO of incoming change
    [self willChangeValueForKey: key];
    
    if ( guide ) // Are we setting the guide or removing it?
        [self.guides setObject: guide forKey: key];
    else
        [self.guides removeObjectForKey: key];
    
    // Inform KVO of change completion
    [self didChangeValueForKey: key];
    
    // Register the guide with our self.
    if ( guide && [guide isKindOfClass: [IonGuideLine class]] )
        [guide addLocalObserverTarget: self andAction: @selector(guideDidUpdate)];
    
    // Force an update
    [self guideDidUpdate];
}

- (IonGuideLine *)guideForKey:(NSString *)key {
    IonGuideLine *guide;
    NSParameterAssert( key && [key isKindOfClass: [NSString class]] );
    if ( !key || ![key isKindOfClass: [NSString class]] )
        return NULL;
    
    guide = [self.guides objectForKey: key];
    if ( ![guide isKindOfClass: [IonGuideLine class]] )
        return NULL;
    
    return guide;
}

- (void) guideDidUpdate {
    [self.localObservers invokeActionSetsInGroup: @"observers"];
}

#pragma mark Local Observers

- (FOTargetActionList *)localObservers {
    if ( !_localObservers )
        _localObservers = [[FOTargetActionList alloc] init];
    return _localObservers;
}

- (void) addTarget:(id) target andAction:(SEL) action {
    [self.localObservers addTarget: target andAction: action toGroup: @"observers"];
}

- (void) removeTarget:(id) target andAction:(SEL) action {
    [self.localObservers removeTarget: target andAction: action fromGroup: @"observers"];
}

@end

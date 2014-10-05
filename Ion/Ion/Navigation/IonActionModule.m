//
//  IonActionModule.m
//  Ion
//
//  Created by Andrew Hurst on 10/5/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonActionModule.h"
#import <IonData/IonData.h>

@interface IonActionModule ()

/**
 * Our target action list.
 */
@property (strong, nonatomic, readonly) IonTargetActionList *actionList;
@end

@implementation IonActionModule

@synthesize actionList = _actionList;

#pragma mark Constructors

- (instancetype) init {
    self = [super init];
    if ( self )
        self.debugLinkInvocations = FALSE;
    return self;
}

- (instancetype) initWithTarget:(id) target {
    NSParameterAssert( target );
    if ( !target )
        return NULL;
    
    self = [self init];
    if ( self )
        _target = target;
    return self;
}

+ (instancetype) moduleWithTarget:(id) target {
    return [[[self class] alloc] initWithTarget: target];
}

#pragma mark Action Management

- (IonTargetActionList *)actionList {
   if ( !_actionList )
       _actionList = [[IonTargetActionList alloc] init];
    return _actionList;
}

- (void) addAction:(SEL) action toEndpoint:(NSString *)endpoint {
    NSParameterAssert( endpoint && [endpoint isKindOfClass: [NSString class]] );
    NSParameterAssert( action && _target );
    if ( !endpoint || ![endpoint isKindOfClass: [NSString class]] || !action || !_target )
        return;
    
    [self.actionList addTarget: _target andAction: action toGroup: endpoint];
}

- (void) removeActionsForEndpoint:(NSString *)endpoint {
    NSParameterAssert( endpoint && [endpoint isKindOfClass: [NSString class]] );
    if ( !endpoint || ![endpoint isKindOfClass: [NSString class]] )
        return;
    
    [self.actionList removeGroup: endpoint];
}

- (void) removeAllEndpoints {
    [self.actionList removeAllGroups];
}

#pragma mark Module Interface

- (BOOL) invokeLink:(IonLink *)link {
    NSString *key;
    if ( !link || ![link isKindOfClass: [IonLink class]] )
        return FALSE;
    
    // Valid Key?
    key = [link.pathComponents firstObject];
    if ( !key || ![key isKindOfClass: [NSString class]] ) {
        if ( self.debugLinkInvocations )
            NSLog( @"Attempted to invoke endpoint but couldn't resolve path components." );
        return FALSE;
    }
    
    // invoke the actions at the specified endpoint.
    [self.actionList invokeActionSetsInGroup: key withObject: link];
    
    if ( self.debugLinkInvocations )
        NSLog( @"%@ endpoint \"%@\"%@",
              [self.actionList actionCountInGroup: key] > 0 ? @"Invoked" : @"Failed to invoke",
              key,
              [self.actionList actionCountInGroup: key] > 0 ?
              @"" : @" because there were no subscribed actions.");
    return [self.actionList actionCountInGroup: key] > 0; // Report success if we have an action that responds.
}

@end

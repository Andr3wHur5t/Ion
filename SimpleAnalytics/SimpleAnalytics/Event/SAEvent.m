//
//  SAEvent.m
//  SimpleAnalytics
//
//  Created by Andrew Hurst on 10/10/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "SAEvent.h"
#import "SAEventManager.h"

@implementation SAEvent

@synthesize description = _description;

#pragma mark Construction

- (instancetype) initWithDescription:(SADescription *)description {
    self = [super init];
    if ( self ) {
        _description = description;
        _time = [NSDate date];
    }
    return self;
}

+ (instancetype) eventWithDescription:(SADescription *)description {
    return [[[self class] alloc] initWithDescription: description];
}

#pragma mark Interface

- (void) record {
    [[SAEventManager defaultEventManager] recordEvent: self];
}

- (NSString *)description {
    return [NSString stringWithFormat: @"%@ at %@", _description ? _description : NULL, self.time];
}

@end

@implementation SANamedEvent

- (instancetype) initWithName:(NSString *)name {
    return [super initWithDescription: [[SANamedDescription alloc] initWithName: name]];
}

+ (instancetype) eventWithName:(NSString *)name {
    return [[[self class] alloc] initWithName: name];
}

@end
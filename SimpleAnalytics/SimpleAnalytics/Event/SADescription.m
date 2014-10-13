//
//  SADescription.m
//  SimpleAnalytics
//
//  Created by Andrew Hurst on 10/10/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "SADescription.h"

@implementation SADescription
@end

@implementation SANamedDescription

- (instancetype) initWithName:(NSString *)name {
    self = [super init];
    if ( self )
        _name = name;
    return self;
}

- (NSString *)description {
    return _name;
}

@end
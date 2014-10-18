//
//  IACLinkDescription.m
//  IACommunication
//
//  Created by Andrew Hurst on 10/14/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "IACLinkDescription.h"
#import "IACLink.h"

@implementation IACLinkDescription

- (instancetype) initWithLink:(IACLink *)link {
    NSURL *realLinkUrl;
    self = [super init];
    if ( self ) {
        // Yes, this is in effecent we should change it later.
        realLinkUrl = [NSURL URLWithString: [link urlString]];
        _linkURL = [[NSURL alloc] initWithScheme: [realLinkUrl scheme]
                                            host: [realLinkUrl host]
                                            path: [realLinkUrl path]];
        _reason = link.reason;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat: @"\"%@\" for \"%@\"", _linkURL, _reason];
}

@end

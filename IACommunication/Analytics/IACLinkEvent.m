//
//  IACUrlEvent.m
//  IACommunication
//
//  Created by Andrew Hurst on 10/14/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "IACLinkEvent.h"
#import "IACLinkDescription.h"

@implementation IACLinkEvent

- (instancetype) initWithLink:(IACLink *)link{
    return [self initWithDescription: [[IACLinkDescription alloc] initWithLink: link]];
}

@end

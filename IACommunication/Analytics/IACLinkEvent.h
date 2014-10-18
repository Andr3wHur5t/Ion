//
//  IACUrlEvent.h
//  IACommunication
//
//  Created by Andrew Hurst on 10/14/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <SimpleAnalytics/SimpleAnalytics.h>

@class IACLink;

@interface IACLinkEvent : SAEvent

/**
 * Constructs with the inputted link, using its URL without the query string.
 * @param link - the link for the event.
 */
- (instancetype) initWithLink:(IACLink *)link;

@end

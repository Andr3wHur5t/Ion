//
//  IACLinkDescription.h
//  IACommunication
//
//  Created by Andrew Hurst on 10/14/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <SimpleAnalytics/SimpleAnalytics.h>

@class IACLink;

@interface IACLinkDescription : SADescription
#pragma mark Construction
/**
 * Constructs with the inputted link, and reason.
 * @param link - the link to construct with.
 */
- (instancetype) initWithLink:(IACLink *)link;

#pragma mark Proproties
/**
 * The URL representing our link.
 */
@property (strong, nonatomic, readonly) NSURL *linkURL;

/**
 * The reason accocated with our link.
 */
@property (strong, nonatomic, readonly) NSString *reason;

@end

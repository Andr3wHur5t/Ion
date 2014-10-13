//
//  SAEventFilter.h
//  SimpleAnalytics
//
//  Created by Andrew Hurst on 10/10/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SAEvent;

@interface SAEventFilter : NSObject


#pragma mark Interface
/**
 * Check if the event conforms to our filter.
 * @param event - the event to check.
 */
- (BOOL) eventIsValid:(SAEvent *)event;

@end

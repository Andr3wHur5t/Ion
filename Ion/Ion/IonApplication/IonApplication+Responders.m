//
//  IonApplication+Responders.m
//  Ion
//
//  Created by Andrew Hurst on 9/9/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonApplication+Responders.h"
#import "UIView+FirstResponderSearch.h"

@implementation IonApplication (Responders)
#pragma mark First Responder
/**
 * The current first responder.
 * @warning Not KVO compliant; This dose a search on each invoaction!
 */
- (UIResponder *)firstResponder {
    // Get the first responder from the key window.
    return [[[UIApplication sharedApplication] keyWindow] ionFristResponder];
}

#pragma mark Keyboard Management
// This simply proxies keyboard managment functions.
@end

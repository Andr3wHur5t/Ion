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

- (UIResponder *)firstResponder {
    // Get the first responder from the key window.
    return [[[UIApplication sharedApplication] keyWindow] ionFristResponder];
}

@end

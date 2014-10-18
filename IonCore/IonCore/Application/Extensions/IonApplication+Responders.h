//
//  IonApplication+Responders.h
//  Ion
//
//  Created by Andrew Hurst on 9/9/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonApplication.h"

@interface IonApplication (Responders)
#pragma mark First Responder
/**
 * The current first responder.
 * @warning Not KVO compliant; This dose a search on each invocation!
 */
@property (weak, nonatomic, readonly) UIResponder *firstResponder;

@end
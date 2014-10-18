//
//  IonApplication+InterappComunication.m
//  IonCore
//
//  Created by Andrew Hurst on 10/14/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "IonApplication+InterappComunication.h"
#import <IonCore/IACRouter.h>

@implementation IonApplication (InterappComunication)

#pragma mark Router

- (IACRouter *)router {
    IACRouter *_router = [self.categoryVariables objectForKey: @"applicationIACRouter"];
    if ( !_router ) {
        _router = [[IACRouter alloc] init];
        _router.recordToAnalytics = TRUE;
        [self.categoryVariables setObject: _router forKey: @"applicationIACRouter"];
    }
    return _router;
}

@end

//
//  IonThemeConfiguration.m
//  Ion
//
//  Created by Andrew Hurst on 7/23/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonThemeConfiguration.h"


@implementation IonThemeConfiguration

/**
 * The Standard Constructor.
 */
- (instancetype) init {
    self = [super init];
    if ( self ) {
        _themeShouldBeApplyedToSelf = true;
    }
    return self;
}


@end

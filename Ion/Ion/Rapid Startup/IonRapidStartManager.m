//
//  IonRapidStartManager.m
//  Ion
//
//  Created by Andrew Hurst on 6/26/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonRapidStartManager.h"

@implementation IonRapidStartManager

/**
 * Default constructor; This is suposed to be fast, only call things you need.
 * @returns {instancetype}
 */
- (instancetype)init {
    self = [super init];
    if (self) {
        [self constructRapidStartViewController];
    }
    return self;
}

#pragma mark constructors

/**
 * This constructs the rapid start view controller.
 * *Note may be overloaded for customization*
 * @returns {void}
 */
- (void) constructRapidStartViewController {
    // construct
    _viewController = [[IonRapidStartViewController alloc] init];
}

#pragma mark interface

/**
 * This prepares us to display.
 * @returns {void}
 */
-(void) prepareToDisplay {
    //run all preperation for displaying
    NSLog(@"rapid manager prepared to display");
}

/**
 * This sets the rapid view controller configuration
 * @returns {void}
 */
-(void) setViewConfiguration:(IonRapidStartupViewConfiguration) configuration {
    _viewController.viewConfiguration = configuration;
}

/**
 * this sets the did display callback.
 * @returns {void}
 */
- (void) setPostDisplayCallback:(void(^)()) callback {
    [_viewController setPostAppearCallback:callback];
}

#pragma mark defaults

@end

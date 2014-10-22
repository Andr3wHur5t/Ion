//
//  EventsViewController.m
//  Sandbox
//
//  Created by Andrew Hurst on 10/19/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "EventsViewController.h"

@interface EventsViewController () {
    IonLabel *titleLabel;
}

@end

@implementation EventsViewController

- (void) configureSearchField {
    self.searchField.placeholder = @"Search for an event";
}

- (void) configureTitleConfiguration {
    titleLabel = [[IonLabel alloc] init];
    titleLabel.text = @"Events";
    self.titleConfiguration.leftView = [[IonInterfaceButton alloc] initWithFileName: @"viewfinder"];
    self.titleConfiguration.rightView = [[IonInterfaceButton alloc] initWithFileName: @"settings"];
    self.titleConfiguration.centerView = titleLabel;
}

@end

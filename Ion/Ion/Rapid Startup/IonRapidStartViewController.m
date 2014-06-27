//
//  IonRapidStartViewController.m
//  Ion
//
//  Created by Andrew Hurst on 6/26/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonRapidStartViewController.h"

@interface IonRapidStartViewController () {
    void (^postAppearCallback)(void);
}

@end

@implementation IonRapidStartViewController

#pragma mark animations

/**
 * This initilizes all configured animations
 * @returns {void}
 */
- (void) initilizeAnimations {
    
}

/**
 * This starts all configured animations
 * @returns {void}
 */
- (void) startAnimations {
    
}

#pragma mark configuration

/**
 * this loads the necacary assets.
 * @returns {void}
 */
- (void) loadAssets {
     NSLog(@"rapid view loaded assets");
}


#pragma mark rapid start interface

/**
 * this sets the post appear callback which will be called after the view appears.
 # @returns {void}
 */
- (void) setPostAppearCallback:(void(^)()) callback {
    postAppearCallback = callback;
}

/**
 * This sets the configuration object of the view.
 @ @returns {void}
 */
- (void) setViewConfiguration:(IonRapidStartupViewConfiguration)viewConfiguration {
    _viewConfiguration = viewConfiguration;
    NSLog(@"set View configuration");
    self.view.backgroundColor = [UIColor orangeColor];
}


#pragma mark std view methods

- (void) viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // call display callback
    if( postAppearCallback )
        postAppearCallback();
    
    //initilize and start animations
    [self initilizeAnimations];
    [self startAnimations];
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

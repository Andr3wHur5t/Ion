//
//  IonRapidStartViewController.m
//  Ion
//
//  Created by Andrew Hurst on 6/26/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonRapidStartViewController.h"
#import "UIView+IonTheme.h"
#import "IonApplication.h"

@interface IonRapidStartViewController () {
    // Callbacks
    void (^postAppearCallback)(void);
    void (^finishedDispatchingCallback)(void);
}
/**
 * The first real root view controller which we will transition to.
 */
@property (strong, nonatomic) UIViewController* frvc;


@end

@implementation IonRapidStartViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        
        // Enable automatic transition
        _readyForViewToDispatchToFRVC = true;
    }
    return self;
}

#pragma mark animations

- (void) initAnimations {
    // This initializes all configured animations
}

- (void) startAnimations {
    // This starts all configured animations
}

#pragma mark configuration

- (void) loadAssets {
    // this loads the necessary assets.
     NSLog(@"rapid view loaded assets");
}


#pragma mark rapid start interface

- (void) setPostAppearCallback:(void(^)()) callback {
    // this sets the post appear callback which will be called after the view appears.
    postAppearCallback = callback;
}

- (void) setFinishedDispatchingCallback:(void(^)()) callback {
    // this sets the finished dispatching callback which will be called after the view removes itself from root.
    finishedDispatchingCallback = callback;
}

- (void) prepareToDispatchWithNewController:(UIViewController*) vc {
    _frvc = vc;

    [self goToNextRootViewControllerIfReady];
}


#pragma mark public internal Interface

- (bool) goToNextRootViewControllerIfReady {
    // This will Transition to the next root view controller if it has been loaded.
    if ( _readyForViewToDispatchToFRVC )
        [self transisionToTheNextRootViewController];
    
    return _readyForViewToDispatchToFRVC;
}

#pragma mark private internal interface

- (void) transisionToTheNextRootViewController {
    // Transition the window the next root view controller which has been provided to us.
    if ( _frvc )
        [UIView transitionWithView: ((IonApplication*)[UIApplication sharedApplication].delegate).window
                          duration: _frvc.view.animationDuration
                           options: UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            ((IonApplication*)[UIApplication sharedApplication].delegate).window.rootViewController = _frvc;
                        }
                        completion:^(BOOL finished) {
                            _frvc = NULL;
                            
                            if ( finishedDispatchingCallback )
                                finishedDispatchingCallback();
                        }];
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
    
    //initialize and start animations
    [self initAnimations];
    [self startAnimations];
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

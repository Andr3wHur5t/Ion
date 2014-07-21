//
//  IonRapidStartViewController.m
//  Ion
//
//  Created by Andrew Hurst on 6/26/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonRapidStartViewController.h"
#import "IonApplication.h"

@interface IonRapidStartViewController () {
    void (^postAppearCallback)(void);
    
    void (^finishedDispatchingCallback)(void);
    
    
}
// This is the first real root view controller which we will transision to.
@property (strong, nonatomic) UIViewController* frvc;



@end

@implementation IonRapidStartViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        
        // Enabel automatic transision
        _readyForViewToDispatchToFRVC = true;
    }
    return self;
}

#pragma mark animations

/**
 * This initilizes all configured animations
 * @returns {void}
 */
- (void) initAnimations {
    
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
 * this sets the finished dispatching callback which will be called after the view removes itself from root.
 # @returns {void}
 */
- (void) setFinishedDispatchingCallback:(void(^)()) callback {
    finishedDispatchingCallback = callback;
}

/**
 * This is called when the manager tells us its time to dispatch from the view.
 * @param {UIViewController*} the controller we will be dispatching to.
 * @returns {void}
 */
- (void) prepareToDispatchWithNewController:(UIViewController*) vc {
    _frvc = vc;

    [self goToNextRootViewControllerIfReady];
}


#pragma mark public internial Interface
/**
 * This will Transision to the next root view controller if it has been loaded.
 * @returns {bool} true if successfull, else it failed.
 */
- (bool) goToNextRootViewControllerIfReady {
    if ( _readyForViewToDispatchToFRVC )
        [self transisionToTheNextRootViewController];
    
    return _readyForViewToDispatchToFRVC;
}

#pragma mark private internial interface

/**
 * This will transision the window the next root view controller which has been provided to us.
 * @returns {void}
 */
- (void) transisionToTheNextRootViewController {
    // if the view exsists
    if ( _frvc )
        [UIView transitionWithView: ((IonApplication*)[UIApplication sharedApplication].delegate).window
                          duration:0.5 // TODO: Load From Defaults
                           options:UIViewAnimationOptionTransitionCrossDissolve
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
    
    //initilize and start animations
    [self initAnimations];
    [self startAnimations];
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

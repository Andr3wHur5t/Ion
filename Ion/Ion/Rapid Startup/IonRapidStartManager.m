//
//  IonRapidStartManager.m
//  Ion
//
//  Created by Andrew Hurst on 6/26/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonRapidStartManager.h"

#define OnBoardingScreenVersionKey @"OnBoardingScreenVersion"


@interface IonRapidStartManager () {
    
}
#pragma mark view controller utilities
/**
 * Gets the correct rapid start controller.
 * @returns {IonRapidStartViewController}
 */
- (IonRapidStartViewController *)getRapidStartController;

/**
 * Checks if we should use the on boarding rapid splash or not.
 */
- (BOOL) useOnBoardingRapidSplash;

#pragma mark system defaults management
/*
 * Sets the last used on boarding screen version ID.
 */
- (void) updateLastOnBoardingVersionIDto:(id) newID;

/*
 * Gets the last displayed on boarding version ID from user defaults.
 * @returns {NSString*}
 */
-(NSString *)lastOnBoardingVersionID;

#pragma mark Delegate Utilities

/**
 * Checks the delegate.
 * @returns {BOOL} TRUE if delegate is valid, otherwise FALSE
 */
- (BOOL) checkDelegate;

@end


/* = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
 *                                                  Implementation
 * = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =*/

@implementation IonRapidStartManager
#pragma mark Constructors
/**
 * Constructs a manager using the inputted delegate.
 * @param {id<IonRapidStartManagerDelegate>} the delegate to construct with.
 * @returns {instancetype}
 */
- (instancetype) initWithDelegate:(id<IonRapidStartManagerDelegate>) delegate {
    self = [self init];
    if ( self )
        self.delegate = delegate;
    return self;
}
#pragma mark view controller utilities

/**
 * Setter for the view controller.
 * @praram {IonRapidStartViewController*} the controller to be set
 */
- (void) setViewController:(IonRapidStartViewController *)viewController {
    _viewController = viewController;
    if ( !_viewController )
        return;
   
    // Set Callbacks
    __weak typeof(self) weakSelf = self;
    [_viewController setFinishedDispatchingCallback: ^{
        // Kill our children, they have no purpose now :'(
        weakSelf.viewController = NULL;
        
        // Inform our parent we can be freed, we now have no use...
        if ( [weakSelf checkDelegate] )
            [weakSelf.delegate freeRapidSplashManager];
    }];
    
    [_viewController setPostAppearCallback: ^{
        // Inform the delegate that post display has occurred
        if ( [weakSelf checkDelegate] )
            [weakSelf.delegate postDisplay];
    }];
    
    
}

/**
 * Gets the correct rapid start controller.
 * @returns {IonRapidStartViewController*}
 */
- (IonRapidStartViewController *)getRapidStartController {
   if ( ![self checkDelegate] )
       return NULL;
    
    if ( [self useOnBoardingRapidSplash] ) {
        // Update the last run on boarding version id
        [self updateLastOnBoardingVersionIDto: [_delegate currentOnBoardingScreenVersion]];
        // Display the on boarding view
        return [_delegate onBoardingRapidSplash];
    }
    else
        return [_delegate rapidSplash];
}


/**
 * Gets if we should use the on boarding rapid splash or not.
 */
- (BOOL) useOnBoardingRapidSplash {
    BOOL firstRun = FALSE;
    if ( ![self checkDelegate] )
        return FALSE;
    
    // Check if the last run version of on boarding is the same as our current version.
    if( [self lastOnBoardingVersionID] )
        firstRun = ![[self lastOnBoardingVersionID] isEqualToString: [_delegate currentOnBoardingScreenVersion]];
    else
        firstRun = TRUE;
    
    // Check if we need to override and disable on boarding
    if( ![_delegate currentOnBoardingScreenVersion] ) {
        [self updateLastOnBoardingVersionIDto: NULL];
        firstRun = FALSE;
    }
    
    return firstRun;
}

#pragma mark System Defaults Management
/**
 * This sets the last used on boarding screen version ID.
 * BUG: Sometimes doesn't set...
 */
- (void) updateLastOnBoardingVersionIDto:(id) newID {
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue: newID forKey: OnBoardingScreenVersionKey];
    [userDefaults synchronize];
}

/**
 * This gets the last displayed on boarding version ID from user defaults.
 * @returns {NSString*}
 */
-(NSString *)lastOnBoardingVersionID {
    return [[NSUserDefaults standardUserDefaults] stringForKey:OnBoardingScreenVersionKey];
}

#pragma mark Delegate Utilities
/**
 * Checks the delegate.
 * @returns {BOOL} TRUE if delegate is valid, otherwise FALSE
 */
- (BOOL) checkDelegate {
    if( !_delegate )
        return FALSE;
    return TRUE;
}

/**
 * This is the setter for the delegate.
 * @praram {id<IonRapidStartManagerDelegate>} the delegate to set.
 */
- (void) setDelegate:(id<IonRapidStartManagerDelegate>)delegate {
    _delegate = delegate;
    self.viewController = [self getRapidStartController];
}

@end

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
 * This returns the correct rapid start controller.
 * @returns {IonRapidStartViewController}
 */
- (IonRapidStartViewController*) getRapidStartController;

/**
 * This returns if we should use the on boarding rapic splash or not.
 */
- (bool) useOnBoardingRapidSplash;

#pragma mark system defaults management

/*
 * This sets the last used on boarding screen version ID.
 * @returns {void}
 */
- (void) updateLastOnBoardingVersionIDto:(id)newID;

/*
 * This gets the last displayed on boarding version ID from user defaults.
 * @returns {NSString*}
 */
-(NSString*) lastOnBoardingVersionID;

#pragma mark Deligate Utilities

/**
 * This Checks the deligate and throws an exception if there is a problem
 * @returns {bool} false if deligate is NULL
 */
- (bool) checkDeligate;

@end





@implementation IonRapidStartManager

/**
 * Default constructor; This is suposed to be fast, only call things you need.
 * @returns {instancetype}
 */
- (instancetype)init {
    self = [super init];
    if (self)
        ;
    return self;
}

#pragma mark interface

/**
 * this sets the did display callback.
 * @returns {void}
 */
- (void) setPostDisplayCallback:(void(^)()) callback {
    [_viewController setPostAppearCallback:callback];
}


#pragma mark view controller utilities

/**
 * This is the setter for the view controller.
 * @praram {IonRapidStartViewController} the controller to be set
 * @returns {void}
 */
- (void) setViewController:(IonRapidStartViewController*)viewController {
    _viewController = viewController;
    
    if ( !_viewController )
        return;
   
    __weak typeof(self) weakself = self;
    [_viewController setFinishedDispatchingCallback:^{
        // this is where we kill our children, they have server their purpose.
        weakself.viewController = NULL;
        
        // this is where we kill self, we now have no use...
        if ( [weakself checkDeligate] )
            [weakself.deligate freeRapidSplashManager];
    }];
}

/**
 * This returns the correct rapid start controller.
 * @returns {IonRapidStartViewController}
 */
- (IonRapidStartViewController*) getRapidStartController {
   if ( ![self checkDeligate] )
       return NULL;
    
    if ( [self useOnBoardingRapidSplash] ) {
        // Update the last run on boarding version id
        [self updateLastOnBoardingVersionIDto: [_deligate currentOnBoardingScreenVersion]];
        // Display the on boarding view
        return [_deligate onBoardingRapidSplash];
    }
    else
        return [_deligate rapidSplash];
}


/**
 * This returns if we should use the on boarding rapic splash or not.
 */
- (bool) useOnBoardingRapidSplash {
    bool firstRun = false;
    
    if ( ![self checkDeligate] )
        return false;
    
    
    // Check if the last run version of on boarding is the same as our current version.
    if( [self lastOnBoardingVersionID] )
        firstRun = ![[self lastOnBoardingVersionID] isEqualToString: [_deligate currentOnBoardingScreenVersion]];
    else
        firstRun = true;
    
    // Check if we need to override and disable on boarding
    if( ![_deligate currentOnBoardingScreenVersion] ) {
        [self updateLastOnBoardingVersionIDto: NULL];
        firstRun = false;
    }
    
    return firstRun;
}

#pragma mark system defaults management

/*
 * This sets the last used on boarding screen version ID.
 * BUG: Sometims dosn't set...
 * @returns {void}
 */
- (void) updateLastOnBoardingVersionIDto:(id)newID {
    NSUserDefaults* userDefalts = [NSUserDefaults standardUserDefaults];
    
    [userDefalts setValue:newID forKey:OnBoardingScreenVersionKey];
    
    [userDefalts synchronize];
}

/*
 * This gets the last displayed on boarding version ID from user defaults.
 * @returns {NSString*}
 */
-(NSString*) lastOnBoardingVersionID {
    return [[NSUserDefaults standardUserDefaults] stringForKey:OnBoardingScreenVersionKey];
}

#pragma mark Deligate Utilities

/**
 * This Checks the deligate and throws an exception if there is a problem
 * @returns {bool} false if deligate is NULL
 */
- (bool) checkDeligate {
    if( !_deligate ) {
        [NSException raise:@"IonRapidStartManagerDeligate is NULL" format:@"Deligate is NULL"];
        return false;
    }
    
    return true;
}


/**
 * This is the setter for the deligate.
 * @praram {id<IonRapidStartManagerDeligate>} the deligate to set.
 * @returns {void}
 */
- (void) setDeligate:(id<IonRapidStartManagerDeligate>)deligate {
    _deligate = deligate;
    self.viewController = [self getRapidStartController];
}

@end

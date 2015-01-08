//
//  IonApplication+plistGetters.h
//  Ion
//
//  Created by Andrew Hurst on 8/29/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonApplication.h"

/**
 * Specifies if we should run in demo mode.
 * Default: NO;
 */
static NSString* sIonApplication_IsDemoModeKey = @"Demo Mode";

/**
 * Specifies the Current version of the on boarding screen
 * Default: 0.0v;
 */
static NSString* sIonApplication_CurrentOnBoardingScreenVersion = @"On Boarding Screen Version";

/**
 * Holds typed, and untyped getter functions for info.plist file.
 */
@interface IonApplication (plistGetters)
#pragma mark Untyped Getters
/**
 * Gets the plist value for the specified key.
 * @param key - the key to get the value for.
 */
+ (id) plistValueForKey:(NSString *)key;

#pragma mark Typed Getters
/**
 * Gets the current on boarding screen version from the plist.
 * @return the value stored in the plist, or v0.0 if non-existent
 */
+ (NSString *)currentOnBoardingVersion;
/**
 * Gets if the application is in demo mode from the plist.
 * @return the value stored in the plist, or FALSE if non-existent
 */
+ (BOOL) isInDemoMode;


/*!
 @brief Gets if the inputted scheme is a scheme that the application
 
 @param scheme The scheme to check.
 
 @return True if the application responds to the scheme.
 */
+ (BOOL)respondsToScheme:(NSString *)scheme;

@end

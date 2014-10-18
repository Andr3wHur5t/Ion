//
//  IonThemeConfiguration.m
//  Ion
//
//  Created by Andrew Hurst on 7/23/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonThemeConfiguration.h"

@interface IonThemeConfiguration () {
    BOOL calbackSet;
    IonCompletionBlock _changeCallback;
}

@end

@implementation IonThemeConfiguration

/**
 * The Standard Constructor.
 */
- (instancetype) init {
    self = [super init];
    if ( self ) {
        _themeShouldBeAppliedToSelf = TRUE;
        calbackSet = FALSE;
    }
    return self;
}


#pragma mark Setter Hooks

- (void) setThemeClass:(NSString *)themeClass {
    BOOL didChange = ![_themeClass isEqualToString: themeClass];
    _themeClass = themeClass;
    
    if ( didChange && calbackSet )
        _changeCallback( NULL );
}

- (void) setThemeID:(NSString *)themeID {
    BOOL didChange = ![_themeID isEqualToString: themeID];
    _themeID = themeID;
    
    if ( didChange && calbackSet )
        _changeCallback( NULL );
}

- (void) setThemeElement:(NSString *)themeElement {
    BOOL didChange = ![_themeElement isEqualToString: themeElement];
    _themeElement = themeElement;
    
    if ( didChange && calbackSet )
        _changeCallback( NULL );
}

- (void) setChangeCallback:(IonCompletionBlock)changeCallback {
    calbackSet = TRUE;
    _changeCallback = changeCallback;
}


@end

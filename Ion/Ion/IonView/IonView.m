//
//  IonView.m
//  Ion
//
//  Created by Andrew Hurst on 7/13/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonView.h"

@implementation IonView

#pragma mark Subview Management

/**
 * Performs the block with each IonView child as a parameter.
 * @param { void(^)( IonView* child) }
 * @returns {void}
 */
- (void) forEachIonViewChildPerformBlock: (void(^)( IonView* child )) actionBlock {
    if ( !actionBlock )
        return;
    for ( IonView* child in self.subviews )
        actionBlock( child );
}


/**
 * Adds as a subview, and sets the internial theme.
 */
- (void) addSubview:(UIView*) view {
    [super addSubview: view];
    if ( !view )
        return;
    [view setIonInternalSystemTheme: self.themeConfiguration.currentTheme ];
}


@end

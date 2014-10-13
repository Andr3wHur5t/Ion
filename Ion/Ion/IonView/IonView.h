//
//  IonView.h
//  Ion
//
//  Created by Andrew Hurst on 7/13/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+IonTheme.h"
#import "UIView+IonAnimation.h"
#import "UIView+IonViewProperties.h"
#import "UIView+IonAnimation.h"
#import "IonGuideLine.h"

static NSString* sIonStyle_IonView_StyleMargin = @"styleMargin";

@interface IonView : UIView
#pragma mark Subview Management

/**
 * Performs the block with each IonView child as a parameter.
 * @param { void(^)( IonView* child) }
 
 */
- (void) forEachIonViewChildPerformBlock: (void(^)( IonView* child )) actionBlock;

@end

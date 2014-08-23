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
#import "IonGuideLine.h"

static NSString* sIonStyle_IonView_StyleMargin = @"styleMargin";

@interface IonView : UIView <IonThemeSpecialUIView>
#pragma mark Subview Management

/**
 * Performs the block with each IonView child as a parameter.
 * @param { void(^)( IonView* child) }
 * @returns {void}
 */
- (void) forEachIonViewChildPerformBlock: (void(^)( IonView* child )) actionBlock;

#pragma mark View Positioning Properties

/**
 * The style margin of the view.
 */
@property (assign, nonatomic) CGSize styleMargin;

/**
 * The auto margin which is decided via the the corner radius, and the style margin.
 */
@property (assign, nonatomic, readonly) CGSize autoMargin;


#pragma mark Auto Margin Guide Lines

/**
 * Vertical Auto Margin Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* autoMarginGuideVert;

/**
 * Horizontal Auto Margin Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* autoMarginGuideHoriz;

#pragma mark Style Margin Guide Lines

/**
 * Vertical Style Margin Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* styleMarginGuideVert;

/**
 * Horizontal Style Margin Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* styleMarginGuideHoriz;

@end

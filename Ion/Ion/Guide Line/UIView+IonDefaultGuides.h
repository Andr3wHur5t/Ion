//
//  UIView+IonDefaultGuides.h
//  Ion
//
//  Created by Andrew Hurst on 8/23/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IonGuideLine.h"

@interface UIView (IonDefaultGuides)

#pragma mark Corrner Radius

/**
 * Vertical Corner Radius Margin Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* cornerRadiusMarginGuideVert;

/**
 * Horizontal Corner Radius Margin Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* cornerRadiusMarginGuideHoriz;

#pragma mark Internal Origin
/**
 * Vertical Internal Origin Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* internalOriginGuideVert;

/**
 * Horizontal Internal Origin Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* internalOriginGuideHoriz;

#pragma mark One Third
/**
 * Vertical One Third Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* oneThirdGuideVert;

/**
 * Horizontal One Third Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* oneThirdGuideHoriz;

#pragma mark Center
/**
 * Vertical Center Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* centerGuideVert;

/**
 * Horizontal Center Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* centerGuideHoriz;

#pragma mark Two Thirds
/**
 * Vertical Two Thirds Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* twoThirdsGuideVert;

/**
 * Horizontal Two Thirds Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* twoThirdsGuideHoriz;

#pragma mark Full Size
/**
 * Vertical Size Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* sizeGuideVert;

/**
 * Horizontal  Size Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* sizeGuideHoriz;


#pragma mark Padding

/**
 * Left padding Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* leftPadding;

/**
 * Right padding Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* rightPadding;

/**
 * Top padding Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* topPadding;

/**
 * Bottom padding Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* bottomPadding;

#pragma mark Margins

/**
 * Left Margin Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* leftMargin;

/**
 * Right Margin Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* rightMargin;

/**
 * Top Margin Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* topMargin;

/**
 * Top Margin Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* bottomMargin;

@end

//
//  UIView+IonExternalGuides.h
//  Ion
//
//  Created by Andrew Hurst on 8/25/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IonGuideGroup.h"

@interface UIView (IonExternalGuides)
#pragma mark External Guide Group

/**
 * The External Guide Group.
 */
@property (weak, nonatomic, readonly) IonGuideGroup* externalGuides;

#pragma mark  Origin
/**
 * External Vertical Internal Origin Guide Line
 */
@property (weak, nonatomic, readonly) IonGuideLine* originGuideVertExternal;

/**
 * External Horizontal Internal Origin Guide Line
 */
@property (weak, nonatomic, readonly) IonGuideLine* originGuideHorizExternal;

#pragma mark One Third
/**
 * External Vertical One Third Guide Line
 */
@property (weak, nonatomic, readonly) IonGuideLine* oneThirdGuideVertExternal;

/**
 * External Horizontal One Third Guide Line
 */
@property (weak, nonatomic, readonly) IonGuideLine* oneThirdGuideHorizExternal;

#pragma mark Center
/**
 * External Vertical Center Guide Line
 */
@property (weak, nonatomic, readonly) IonGuideLine* centerGuideVertExternal;

/**
 * External Horizontal Center Guide Line
 */
@property (weak, nonatomic, readonly) IonGuideLine* centerGuideHorizExternal;

#pragma mark Two Thirds
/**
 * External Vertical Two Thirds Guide Line
 */
@property (weak, nonatomic, readonly) IonGuideLine* twoThirdsGuideVertExternal;

/**
 * External Horizontal Two Thirds Guide Line
 */
@property (weak, nonatomic, readonly) IonGuideLine* twoThirdsGuideHorizExternal;

#pragma mark Full Size
/**
 * External Vertical Size Guide Line
 */
@property (weak, nonatomic, readonly) IonGuideLine* sizeGuideVertExternal;

/**
 * External Horizontal  Size Guide Line
 */
@property (weak, nonatomic, readonly) IonGuideLine* sizeGuideHorizExternal;


#pragma mark Margins

/**
 * Left Margin Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* leftMarginExternal;

/**
 * Right Margin Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* rightMarginExternal;

/**
 * Top Margin Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* topMarginExternal;

/**
 * Top Margin Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* bottomMarginExternal;

@end

//
//  IonGuideGroup.h
//  Ion
//
//  Created by Andrew Hurst on 8/23/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IonViewGuideSet.h"

@interface IonGuideGroup : NSObject

/**
 * Constructs using the inputted frame.
 * @param {CGRect} the frame to construct with.
 * @returns {instancetype}
 */
- (instancetype) initWithFrame:(CGRect) frame;

/**
 * Constructs using the inputted view.
 * @param {UIVIew*} the view to construct with.
 * @returns {instancetype}
 */
- (instancetype) initWithView:(UIView*) view;

/**
 * The frame of the group
 */
@property (assign, nonatomic) CGRect frame;

/**
 * The Guide Cache
 */
@property (strong, nonatomic, readonly) NSMutableDictionary* cachedGuideLines;

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

@end

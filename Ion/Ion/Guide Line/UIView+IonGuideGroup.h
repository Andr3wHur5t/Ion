//
//  UIView+IonDefaultGuides.h
//  Ion
//
//  Created by Andrew Hurst on 8/23/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IonCompleteGuideGroup.h"

/**
 * A proxy catagory to add guide group functionality.
 */
@interface UIView (IonGuideGroup)

/** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = == = =
 *                                                  Guide Group
 *  = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = */

@property (weak, nonatomic, readonly) IonGuideGroup* guideGroup;


/* = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
 *                              Internal Guides
 * = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = */

#pragma mark Origin
/**
 * Horizontal Origin Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* originGuideHoriz;

/**
 * Vertical Origin Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* originGuideVert;

#pragma mark One Forth
/**
 * Horizontal One Forth Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* oneForthGuideHoriz;

/**
 * Vertical One Forth Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* oneForthGuideVert;

#pragma mark One Third

/**
 * Horizontal One Third Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* oneThirdGuideHoriz;

/**
 * Vertical One Third Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* oneThirdGuideVert;

#pragma mark Center
/**
 * Horizontal Center Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* centerGuideHoriz;

/**
 * Vertical Center Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* centerGuideVert;

#pragma mark Two Thirds
/**
 * Horizontal Two Thirds Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* twoThirdsGuideHoriz;

/**
 * Vertical Two Thirds Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* twoThirdsGuideVert;

#pragma mark Three Forths
/**
 * Horizontal Three Forths Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* threeForthsGuideHoriz;

/**
 * Vertical Three Forths Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* threeForthsGuideVert;

#pragma mark Full Size
/**
 * Horizontal  Size Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* sizeGuideHoriz;

/**
 * Vertical Size Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* sizeGuideVert;


/* = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
 *                              External Guides
 * = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = */

#pragma mark Origin External
/**
 * Horizontal External Origin Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* originExternalGuideHoriz;

/**
 * Vertical External Origin Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* originExternalGuideVert;

#pragma mark One Forth External
/**
 * Horizontal One Forth Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* oneForthExternalGuideHoriz;

/**
 * Vertical One Forth Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* oneForthExternalGuideVert;

#pragma mark One Third External
/**
 * Horizontal External One Third Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* oneThirdExternalGuideHoriz;

/**
 * Vertical External One Third Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* oneThirdExternalGuideVert;

#pragma mark Center External
/**
 * Horizontal External Center Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* centerExternalGuideHoriz;

/**
 * Vertical External Center Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* centerExternalGuideVert;

#pragma mark Two Thirds External
/**
 * Horizontal External Two Thirds Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* twoThirdsExternalGuideHoriz;

/**
 * Vertical External Two Thirds Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* twoThirdsExternalGuideVert;

#pragma mark Three Forths External
/**
 * Horizontal Three Forths Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* threeForthsExternalGuideHoriz;

/**
 * Vertical Three Forths Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* threeForthsExternalGuideVert;

#pragma mark Size External
/**
 * Horizontal External Size Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* sizeExternalGuideHoriz;

/**
 * Vertical External Size Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* sizeExternalGuideVert;


/** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
 *                                              UIView Spcific Guides
 *  = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = */

#pragma mark Corrner Radius
/**
 * Vertical Corner Radius Margin Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* cornerRadiusMarginGuideVert;

/**
 * Horizontal Corner Radius Margin Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* cornerRadiusMarginGuideHoriz;

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

#pragma mark Auto Padding

/**
 * Left auto padding Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* leftAutoPadding;

/**
 * Right auto padding Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* rightAutoPadding;

/**
 * Top auto padding Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* topAutoPadding;

/**
 * Bottom auto padding Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* bottomAutoPadding;

#pragma mark Margins
/**
 * Margin Width Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* marginWidth;

/**
 * Margin Height Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* marginHeight;

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

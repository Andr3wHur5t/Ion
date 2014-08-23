//
//  UIView+IonGuideLine.h
//  Ion
//
//  Created by Andrew Hurst on 8/22/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IonGuideLine.h"
#import "IonViewGuideSet.h"

@interface UIView (IonGuideLine)
/**
 * A Dictionary of all created guide lines for the view.
 */
@property (strong, nonatomic) NSMutableDictionary* cachedGuideLines;

/**
 * The Guide lines states object.
 */
@property (strong, nonatomic) IonViewGuideSet* guideSet;

/**
 * Local Guides
 */
@property (weak, nonatomic) IonGuideLine* localVertGuide;
@property (weak, nonatomic) IonGuideLine* localHorizGuide;

/**
 * Super Guides
 */
@property (weak, nonatomic) IonGuideLine* superVertGuide;
@property (weak, nonatomic) IonGuideLine* superHorizGuide;

#pragma mark Setters

/**
 * Sets the local guides.
 * @param {IonGuideLine*} the vertical guide line.
 * @param {IonGuideLine*} the horizontal guide line.
 * @returns {void}
 */
- (void) setLocalGuidesWithVert:(IonGuideLine*) vert andHoriz:(IonGuideLine*) horiz;

/**
 * Sets the super guides.
 * @param {IonGuideLine*} the vertical guide line.
 * @param {IonGuideLine*} the horizontal guide line.
 * @returns {void}
 */
- (void) setSuperGuidesWithVert:(IonGuideLine*) vert andHoriz:(IonGuideLine*) horiz;

/**
 * Sets all guides.
 * @param {IonGuideLine*} the local vertical guide line.
 * @param {IonGuideLine*} the local horizontal guide line.
 * @param {IonGuideLine*} the super vertical guide line.
 * @param {IonGuideLine*} the super horizontal guide line.
 * @returns {void}
 */
- (void) setGuidesWithLocalVert:(IonGuideLine*) lVert
                     localHoriz:(IonGuideLine*) lHoriz
                      superVert:(IonGuideLine*) sVert
                  andSuperHoriz:(IonGuideLine*) sHoriz;

#pragma mark Update Functions

/**
 * Updates the position of the current frame to match the guide set.
 * @returns {void}
 */
- (void) updateFrameToMatchGuideSet;
@end

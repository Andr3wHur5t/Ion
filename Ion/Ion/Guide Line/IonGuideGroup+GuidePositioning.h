//
//  IonGuideGroup+GuidePositioning.h
//  Ion
//
//  Created by Andrew Hurst on 8/27/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonGuideGroup.h"

@interface IonGuideGroup (GuidePositioning)

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

/**
 * The size guides
 */
@property (weak, nonatomic) IonGuideLine* topSizeGuide;
@property (weak, nonatomic) IonGuideLine* bottomSizeGuide;
@property (weak, nonatomic) IonGuideLine* leftSizeGuide;
@property (weak, nonatomic) IonGuideLine* rightSizeGuide;


/**
 * Logs frame auto updating for the view, with the specified string.
 */
@property (weak, nonatomic) NSString* logAutoFrameUpdatesWithString;


#pragma mark Setters

/**
 * Sets the local guides.
 * @param {IonGuideLine*} the vertical guide line.
 * @param {IonGuideLine*} the horizontal guide line.
 * @returns {void}
 */
- (void) setLocalGuidesWithVert:(IonGuideLine*) vert andHoriz:(IonGuideLine*) horiz __attribute__((deprecated));

/**
 * Sets the super guides.
 * @param {IonGuideLine*} the vertical guide line.
 * @param {IonGuideLine*} the horizontal guide line.
 * @returns {void}
 */
- (void) setSuperGuidesWithVert:(IonGuideLine*) vert andHoriz:(IonGuideLine*) horiz __attribute__((deprecated));

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
                  andSuperHoriz:(IonGuideLine*) sHoriz __attribute__((deprecated));

#pragma mark Update Functions

/**
 * Updates the position of the current frame to match the guide set.
 * @returns {void}
 */
- (void) updateFrameToMatchGuideSet;

@end

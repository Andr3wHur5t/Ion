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
@property (weak, nonatomic, readonly) IonViewGuideSet *guideSet;

/**
 * Local Guides
 */
@property (weak, nonatomic, readwrite) IonGuideLine *localVertGuide;
@property (weak, nonatomic, readwrite) IonGuideLine *localHorizGuide;

/**
 * Super Guides
 */
@property (weak, nonatomic, readwrite) IonGuideLine *superVertGuide;
@property (weak, nonatomic, readwrite) IonGuideLine *superHorizGuide;

/**
 * The size guides
 */
@property (weak, nonatomic, readwrite) IonGuideLine *topSizeGuide;
@property (weak, nonatomic, readwrite) IonGuideLine *bottomSizeGuide;
@property (weak, nonatomic, readwrite) IonGuideLine *leftSizeGuide;
@property (weak, nonatomic, readwrite) IonGuideLine *rightSizeGuide;

/**
 * Forces the view into manual size mode, overriding size guides.
 */
@property (nonatomic, readwrite) BOOL manualSizeMode;

#pragma mark Debugging
/**
 * Logs frame auto updating for the view, with the specified string.
 */
@property (weak, nonatomic, readwrite) NSString *debuggingName;

/**
 * States if we log guide frame updates, or not.
 */
//@property (assign, nonatomic, readwrite) BOOL debugGuideFrameUpdates;

#pragma mark Setter Utilities.
/**
 * Sets the local guides.
 * @param horiz - the horizontal guide line.
 * @param vert - the vertical guide line.
 */
- (void) setLocalGuidesWithHorz:(IonGuideLine *)horiz andVert:(IonGuideLine *)vert;

/**
 * Sets the super guides.
 * @param horiz - the horizontal guide line.
 * @param vert - the vertical guide line.
 */
- (void) setSuperGuidesWithHorz:(IonGuideLine *)horiz andVert:(IonGuideLine *)vert;

/**
 * Sets all position guides.
 * @param lHoriz - the local horizontal guide line.
 * @param lVert - the local vertical guide line.
 * @param sHoriz- the super horizontal guide line.
 * @param sVert - the super vertical guide line.
 */
- (void) setGuidesWithLocalHoriz:(IonGuideLine *)lHoriz
                       localVert:(IonGuideLine *)lVert
                      superHoriz:(IonGuideLine *)sHoriz
                    andSuperVert:(IonGuideLine *)sVert;

/**
 * Sets the horizontal size guides.
 * @param left - the left size guide.
 * @param right - the right size guide.
 */
- (void) setSizeHorizontalWithLeft:(IonGuideLine *)left andRight:(IonGuideLine *)right;

/**
 * Sets the horizontal size guides.
 * @param top - the top size guide.
 * @param bottom - the bottom size guide.
 */
- (void) setSizeVerticalyWithTop:(IonGuideLine *)top andBottom:(IonGuideLine *)bottom;

/**
 * Sets all size guides.
 * @param left - the left size guide.
 * @param right - the right size guide.
 * @param top - the top size guide.
 * @param bottom - the bottom size guide.
 */
- (void) setSizeGuidesWithLeft:(IonGuideLine *)left
                         right:(IonGuideLine *)right
                           top:(IonGuideLine *)top
                     andBottom:(IonGuideLine *)bottom;

/**
 * Sets both size, and positioning guides.
 * @param lHoriz - the local horizontal guide line.
 * @param lVert - the local vertical guide line.
 * @param sHoriz- the super horizontal guide line.
 * @param sVert - the super vertical guide line.
 * @param left - the left size guide.
 * @param right - the right size guide.
 * @param top - the top size guide.
 * @param bottom - the bottom size guide.
 */
- (void) setGuidesWithLocalHoriz:(IonGuideLine *)lHoriz
                       localVert:(IonGuideLine *)lVert
                      superHoriz:(IonGuideLine *)sHoriz
                       superVert:(IonGuideLine *)sVert
                            left:(IonGuideLine *)left
                           right:(IonGuideLine *)right
                             top:(IonGuideLine *)top
                       andBottom:(IonGuideLine *)bottom;

#pragma mark Update Functions
/**
 * Updates the position of the current frame to match the guide set.  
 */
- (void) updateFrameToMatchGuideSet;

@end

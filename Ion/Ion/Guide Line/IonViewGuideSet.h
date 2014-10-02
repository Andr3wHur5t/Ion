//
//  IonViewGuideSet.h
//  Ion
//
//  Created by Andrew Hurst on 8/22/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IonGuideLine.h"


/**
 * Calculates sizes, and positions based off of a set of guide lines.
 */
@interface IonViewGuideSet : NSObject

/**
 * The super views' guide pair.
 */
@property (weak, nonatomic, readwrite) IonGuideLine* superVertGuide;
@property (weak, nonatomic, readwrite) IonGuideLine* superHorizGuide;

/**
 * The local views' guide pair.
 */
@property (weak, nonatomic, readwrite) IonGuideLine* localVertGuide;
@property (weak, nonatomic, readwrite) IonGuideLine* localHorizGuide;

/**
 * The size guides
 */
@property (weak, nonatomic, readwrite) IonGuideLine* topSizeGuide;
@property (weak, nonatomic, readwrite) IonGuideLine* bottomSizeGuide;
@property (weak, nonatomic, readwrite) IonGuideLine* leftSizeGuide;
@property (weak, nonatomic, readwrite) IonGuideLine* rightSizeGuide;

/**
 * The guides frame.
 */
@property (assign, nonatomic, readonly) CGRect frame;

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

#pragma mark Retrieval
/**
 * Gets the origin position using the current guide pairs.
 * @returns {CGPoint}
 */
- (CGPoint) toPoint;

/**
 * Gets the size position using size current guides.
 * @returns {CGSize}
 */
- (CGSize) toSize;

/**
 * Gets the resulting rect for the inputted view, and current guides.
 * @returns {CGRect} the resulting rect
 */
- (CGRect) toRect;

#pragma mark Change Callback
/**
 * Adds the target and action for guides position change updates.
 * @param target - the target to call the action on.
 * @param action the action to call on the target.
 */
- (void) addTarget:(id) target andAction:(SEL) action;

/**
 * Removes the target and action for guides position change updates.
 * @param target - the target to call the action on.
 * @param action - the action to call on the target.
 */
- (void) removeTarget:(id) target andAction:(SEL) action;

@end

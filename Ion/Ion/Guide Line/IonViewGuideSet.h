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
@property (strong, nonatomic) IonGuideLine* superVertGuide;
@property (strong, nonatomic) IonGuideLine* superHorizGuide;

/**
 * The local views' guide pair.
 */
@property (strong, nonatomic) IonGuideLine* localVertGuide;
@property (strong, nonatomic) IonGuideLine* localHorizGuide;

/**
 * The size guides
 */
@property (strong, nonatomic) IonGuideLine* topSizeGuide;
@property (strong, nonatomic) IonGuideLine* bottomSizeGuide;
@property (strong, nonatomic) IonGuideLine* leftSizeGuide;
@property (strong, nonatomic) IonGuideLine* rightSizeGuide;

@property (strong, nonatomic, readwrite) NSString *tag;

#pragma mark Position Setter Utilities.
/**
 * Sets the super pair to match the inputted guides.
 * @param {IonGuideLine*} the vertical guide line.
 * @param {IonGuideLine*} the horizontal guide line.
 * @returns {void}
 */
- (void) setSuperPairWithVert:(IonGuideLine*) vert andHoriz:(IonGuideLine*) horiz;

/**
 * Sets the local pair to match the inputted guides.
 * @param {IonGuideLine*} the vertical guide line.
 * @param {IonGuideLine*} the horizontal guide line.
 * @returns {void}
 */
- (void) setLocalPairWithVert:(IonGuideLine*) vert andHoriz:(IonGuideLine*) horiz;

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
 * Sets the target and action for guides position change.
 * @param {id} the target to call the action on.
 * @param {SEL} the action to call on the target.
 * @returns {void}
 */
- (void) setTarget:(id) target andAction:(SEL) action;

@end

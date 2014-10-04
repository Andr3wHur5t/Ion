//
//  IonGuideLine+DependentGuides.h
//  Ion
//
//  Created by Andrew Hurst on 8/26/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonGuideLine.h"

@interface IonGuideLine (DependentGuides)

/**
 * Creates a guide line from two guide line modified by each other.
 * @param {IonGuideLine*} the first guide line.
 * @param {IonGuideLine*} the second guide line.
 * @returns {instancetype}
 */
- (instancetype) initWithGuide:(IonGuideLine*) firstGuide
                       modType:(IonValueModType) modType
                andSecondGuide:(IonGuideLine*) secondGuide;

/**
 * Creates a guide line from two guide line modified by each other.
 * @param {IonGuideLine*} the first guide line.
 * @param {IonGuideLine*} the second guide line.
 * @returns {instancetype}
 */
+ (instancetype) guideWithGuide:(IonGuideLine*) firstGuide
                       modType:(IonValueModType) modType
                andSecondGuide:(IonGuideLine*) secondGuide;

@end

//
//  IonGuideLine+DependentGuides.h
//  Ion
//
//  Created by Andrew Hurst on 8/26/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonGuideLine.h"

@interface IonGuideLine (DependentGuides)

/*!
 @brief  Creates a guide line from two guide line modified by each other.
 
 @param firstGuide  the first guide line.
 @param modType     The modification you want the lines to have on the resulting value.
 @param secondGuide the second guide line.
 
 @return A guide representing the lines with modification
 */
- (instancetype) initWithGuide:(IonGuideLine*) firstGuide
                       modType:(IonValueModType) modType
                andSecondGuide:(IonGuideLine*) secondGuide;

/*!
 @brief  Creates a guide line from two guide line modified by each other.
 
 @param firstGuide  the first guide line.
 @param modType     The modification you want the lines to have on the resulting value.
 @param secondGuide the second guide line.
 
 @return A guide representing the lines with modification
 */
+ (instancetype) guideWithGuide:(IonGuideLine*) firstGuide
                       modType:(IonValueModType) modType
                andSecondGuide:(IonGuideLine*) secondGuide;

#pragma mark Arithmetic
/*!
 @brief Constructs a guide which represents the current guide divided by the other guide.
 
 @param otherGuide The guide you want to divided the current guide by.
 
 @return the resulting guide.
 */
- (IonGuideLine *)dividedBy:(IonGuideLine *)otherGuide;

/*!
 @brief Constructs a guide which represents the current guide multiplied by the other guide.
 
 @param otherGuide The guide you want to multiplied the current guide by.
 
 @return the resulting guide.
 */
- (IonGuideLine *)multipliedBy:(IonGuideLine *)otherGuide;

/*!
 @brief Constructs a guide which represents the current guide added by the other guide.
 
 @param otherGuide The guide you want to added the current guide.
 
 @return the resulting guide.
 */
- (IonGuideLine *)addedBy:(IonGuideLine *)otherGuide;

/*!
 @brief Constructs a guide which represents the current guide subtracted by the other guide.
 
 @param otherGuide The guide you want to subtract the current guide.
 
 @return the resulting guide.
 */
- (IonGuideLine *)subtractedBy:(IonGuideLine *)otherGuide;

#pragma mark Min Max

- (IonGuideLine *)min:(IonGuideLine *)bGuide;

- (IonGuideLine *)max:(IonGuideLine *)bGuide;
@end

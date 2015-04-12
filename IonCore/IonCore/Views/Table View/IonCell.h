//
//  IonCell.h
//  IonCore
//
//  Created by Andrew Hurst on 11/9/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "IonView.h"

@class IonGuideLine;

@interface IonCell : IonView

#pragma mark Size Information
/*!
 @brief The preferred height of the cell.
 */
@property (assign, nonatomic, readwrite) CGFloat preferredHeight;

/*!
 @brief Guide representing the preferred height of the cell.
 */
@property (strong, nonatomic, readonly) IonGuideLine *preferredHeightGuide;

#pragma mark Data Binding
/*!
 @brief Binds the cell to a data model
 
 @param dataModel The data model for the cell to bind to.
 */
- (void)bindToDataModel:(id)dataModel;

/*!
 @brief Makes the cell unbind from its data model.
 */
- (void)unbindFromDataModel;

#pragma mark Scoring
/*!
 @brief Gets the current size score for the cell in context of its super view.
 
 @return The current size score of the cell.
 */
- (CGFloat) cellSizeScore;

#pragma mark Tap Gesture Recognizer

/*!
 @brief The views tap gesture recognizer.
 */
@property (strong, nonatomic, readonly) UITapGestureRecognizer *tapGestureRecognizer;

@end

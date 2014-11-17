//
//  IonTextView.h
//  Ion
//
//  Created by Andrew Hurst on 8/18/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IonStyle.h"

// Theme Properties


// Default Font Configuration
static CGFloat sDefaultFontSize = 12.0f;
static NSString* sDefaultFontName = @"Helvetica Neue";

@class IonLabel;
@class IonGuideLine;

/*!
 @brief  The protocol for overflow behavior
 */
@protocol IonLabelOverflowBehaviorDelegate <NSObject>

/*!
 @brief Sets the Current managed views.
 
 @param view  the containing view
 @param label the label to manage
 */
- (void) setContainer:(IonLabel*) view andLabel:(UILabel*) label;

/*!
 @brief Informs the behavior delegate of an attribute change of the label.
 */
- (void) updateStates;

@end


/**
 * The labels' external interface.
 */
@interface IonLabel : UIView <IonThemeSpecialUIView>

/*!
 @brief The text to be displayed in the view.
 */
@property (weak, nonatomic, readwrite) NSString* text;

/*!
 @brief The text color to be displayed in the view
 */
@property (weak, nonatomic, readwrite) UIColor* textColor;

/*!
 @brief The text alignment to use.
 */
@property (assign, nonatomic, readwrite) NSTextAlignment textAlignment;

/*!
 @brief The font to use in the view.
 */
@property (weak, nonatomic, readwrite) UIFont* font;

/*!
 @brief The overflow delegate.
 */
@property (strong, nonatomic, readwrite) id<IonLabelOverflowBehaviorDelegate> overflowBehavior;

#pragma mark Guides

/*!
 @brief A guide representing the current text height.
 */
@property (strong, nonatomic, readonly) IonGuideLine *textHeightGuide;

/*!
 @brief A guide representing the current text width.
 */
@property (strong, nonatomic, readonly) IonGuideLine *textWidthGuide;

@end

@interface UILabel (IonStyle)

@property (assign, nonatomic, readonly) CGSize textSize;

/*!
 @brief A guide representing the current text height.
 */
@property (strong, nonatomic, readonly) IonGuideLine *textHeightGuide;

/*!
 @brief A guide representing the current text width.
 */
@property (strong, nonatomic, readonly) IonGuideLine *textWidthGuide;

@property (assign, nonatomic, readonly) CGFloat textSizeConstrainedByWidth;

@property (strong, nonatomic, readonly) IonGuideLine *textSizeConstrainedByWidthGuide;

@end
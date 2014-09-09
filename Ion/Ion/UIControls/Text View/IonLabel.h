//
//  IonTextView.h
//  Ion
//
//  Created by Andrew Hurst on 8/18/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IonStyle.h"

// Theme Proproties


// Default Font Configuration
static CGFloat sDefaultFontSize = 12.0f;
static NSString* sDefaultFontName = @"Helvetica Neue";

@class IonLabel;

/**
 * The protocol for overflow behavior
 */
@protocol IonLabelOverflowBehaviorDeligate <NSObject>

/**
 * Sets the Current managed views.
 * @param {UIView*} the containing view
 * @param {UILabel*} the label to manage
 * @returns {void}
 */
- (void) setContainer:(IonLabel*) view andLabel:(UILabel*) label;

/**
 * Informs the behavior deligate of an attribute change of the label.
 * @returns {void}
 */
- (void) updateStates;


@end


/**
 * The labels' external interface.
 */
@interface IonLabel : UIView <IonThemeSpecialUIView>

/**
 * The text to be displayed in the view.
 */
@property (weak, nonatomic) NSString* text;

/**
 * The text color to be displayed in the view.
 */
@property (weak, nonatomic) UIColor* textColor;

/**
 * The text alignment to use.
 */
@property (assign, nonatomic) NSTextAlignment textAlignment;

/**
 * The font to use in the view.
 */
@property (weak, nonatomic) UIFont* font;

/**
 * The overflow delegate.
 */
@property (strong, nonatomic) id<IonLabelOverflowBehaviorDeligate> overflowBehavior;



@end
//
//  IonTextView.m
//  Ion
//
//  Created by Andrew Hurst on 8/18/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonLabel.h"
#import <IonData/IonData.h>
#import "NSDictionary+IonThemeResolution.h"
#import "UIView+IonTheme.h"
#import "IonLabelOverflowBehavior.h"

@interface IonLabel () {
    // The label
    UILabel* _labelView;
}
@end

@implementation IonLabel
#pragma mark Constructors
/**
 * Default Constructor
 * @returns {instancetype}
 */
- (instancetype) init {
    self = [super init];
    if ( self )
        [self construct];
    return self;
}

/**
 * Framed Constructor
 * @returns {instancetype}
 */
- (instancetype) initWithFrame:(CGRect) frame {
    self = [super initWithFrame: frame];
    if ( self ) {
        [self construct];
        [self setFrame: frame];
    }
    return self;
}

/**
 * Construction Code.
 */
- (void) construct {
    self.clipsToBounds = TRUE;
    self.themeElement = sIonThemeElementLabel;
    [self createLabelView];
    self.overflowBehavior = [[IonLabelOverflowBehavior alloc] init];
}

#pragma mark Label
/**
 * Responds to getting the label
 */
- (void) createLabelView {
    // Construct
    _labelView = [[UILabel alloc] init];
    _labelView.themeConfiguration.themeShouldBeAppliedToSelf = FALSE;
    
    // Configure
    self.textColor = [UIColor whiteColor];
    self.font = [IonLabel defaultFont];
    
    // Add
    [self addSubview: _labelView];
}

#pragma mark Text
/**
 * Responds to changes in text.
 */
- (void) setText:(NSString*) text {
    _labelView.text = text;
    if ( _overflowBehavior )
        [_overflowBehavior updateStates];
}

/**
 * Gets the current text
 * @returns {NSString*}
 */
- (NSString*) text {
    return _labelView.text;
}

#pragma mark Text Color
/**
 * Sets the text color.
 * @param textColor the text color to be set.
 */
- (void) setTextColor:(UIColor*) textColor {
    if ( !textColor )
        return;
    _labelView.textColor = textColor;
}

/**
 * Gets the text color from the label.
 */
- (UIColor*) textColor {
    return _labelView.textColor;
}

#pragma mark Text Alignment
/**
 * Sets the text alignment.
 * @param textAlignment the new text alignment to use
 */
- (void) setTextAlignment:(NSTextAlignment) textAlignment {
    _labelView.textAlignment = textAlignment;
    if ( _overflowBehavior )
        [_overflowBehavior updateStates];
}

/**
 * Gets the current text alignment.
 */
- (NSTextAlignment) textAlignment {
    return  _labelView.textAlignment;
}

#pragma mark Font

/**
 * Responds to changes in font.
 */
- (void) setFont:(UIFont*) font {
    if ( !font )
        return;
    
    _labelView.font = font;
    if ( _overflowBehavior )
        [_overflowBehavior updateStates];
}

/**
 * Gets the current font.
 * @returns {UIFont*}
 */
- (UIFont*) font {
    return _labelView.font;
}

#pragma mark Overflow Behavior
/**
 * Responds to changes in the overflow delegate.
 * @param overflowBehavior the new overflow behavior.
 */
- (void) setOverflowBehavior:(id<IonLabelOverflowBehaviorDelegate>) overflowBehavior {
    _overflowBehavior = overflowBehavior;
    [_overflowBehavior setContainer: self andLabel: _labelView];
}

#pragma mark Frame

/**
 * Responds to change in the frame.
 * @param frame the new frame.
 */
- (void) setFrame:(CGRect)frame {
    [super setFrame: frame];
    if ( _overflowBehavior )
        [_overflowBehavior updateStates];
}


#pragma mark Style Application
/**
 * Applies the style to the view.
 * @param style the style to apply to the view.
 */
- (void) applyStyle:(IonStyle*) style {
    [super applyStyle: style];
    
    // Text Color
    self.textColor = [style.configuration colorForKey: sIonThemeText_Color usingTheme: style.theme];
    
    // Font
    self.font = [style.configuration fontForKey: sIonThemeText_Font];
    
    // Alignment
    self.textAlignment = [style.configuration textAlignmentForKey: sIonThemeText_Alignment];
}

#pragma mark Defaults
/**
 * The Ion default font.
 * @returns {UIFont*}
 */
+ (UIFont*) defaultFont {
    return [UIFont fontWithName: sDefaultFontName size: sDefaultFontSize];
}


@end

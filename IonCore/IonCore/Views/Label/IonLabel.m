//
//  IonTextView.m
//  Ion
//
//  Created by Andrew Hurst on 8/18/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonLabel.h"
#import <IonCore/IonCore.h>
#import <IonData/IonData.h>
#import "NSDictionary+IonThemeResolution.h"
#import "UIView+IonTheme.h"
#import "IonLabelOverflowBehavior.h"

@interface IonLabel () {
  // The label
  UILabel *_labelView;
}

/*!
 @brief The current size of our text using the current font.
 */
@property(assign, nonatomic, readwrite) CGSize textSizeWithFont;
@end

@implementation IonLabel

@synthesize textHeightGuide = _textHeightGuide;
@synthesize textWidthGuide = _textWidthGuide;

#pragma mark Constructors

- (instancetype)init {
  self = [super init];
  if (self)
    [self construct];
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self construct];
    [self setFrame:frame];
  }
  return self;
}

- (void)construct {
  self.clipsToBounds = TRUE;
  self.themeElement = sIonThemeElementLabel;
  [self createLabelView];
  self.overflowBehavior = [[IonLabelOverflowBehavior alloc] init];
}

#pragma mark Label

- (void)createLabelView {
  // Construct
  _labelView = [[UILabel alloc] init];
  _labelView.themeConfiguration.themeShouldBeAppliedToSelf = FALSE;

  // Configure
  self.textColor = [UIColor whiteColor];
  self.font = [IonLabel defaultFont];

  // Add
  [self addSubview:_labelView];
}

#pragma mark Text

- (void)setText:(NSString *)text {
  
  // Update the label text
  _labelView.text = text;

  // Update behavior
  if (_overflowBehavior)
    [_overflowBehavior updateStates];

  [self updateTextSize];
}

- (NSString *)text {
  return _labelView.text;
}


#pragma mark Guides

- (void)updateTextSize {
  CGSize textSize = [self.text sizeWithFont:_labelView.font];
  
  // Shh I'm adding a buffer so that we don't clip the text.
  self.textSizeWithFont = (CGSize){ textSize.width + 2, textSize.height };
}

- (IonGuideLine *)textHeightGuide {
  if (!_textHeightGuide)
    _textHeightGuide =
        [IonGuideLine guideFromSizeOnTarget:self
                               usingKeyPath:@"textSizeWithFont"
                                     amount:1.0f
                                    andMode:IonGuideLineFrameMode_Vertical];
  return _textHeightGuide;
}

- (IonGuideLine *)textWidthGuide {
  if (!_textWidthGuide)
    _textWidthGuide =
        [IonGuideLine guideFromSizeOnTarget:self
                               usingKeyPath:@"textSizeWithFont"
                                     amount:1.0f
                                    andMode:IonGuideLineFrameMode_Horizontal];
  return _textWidthGuide;
}

#pragma mark Text Color

- (void)setTextColor:(UIColor *)textColor {
  if (!textColor)
    return;
  _labelView.textColor = textColor;
}

- (UIColor *)textColor {
  return _labelView.textColor;
}

#pragma mark Text Alignment

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
  _labelView.textAlignment = textAlignment;
  if (_overflowBehavior)
    [_overflowBehavior updateStates];
}

- (NSTextAlignment)textAlignment {
  return _labelView.textAlignment;
}

#pragma mark Font

- (void)setFont:(UIFont *)font {
  if (!font)
    return;

  _labelView.font = font;
  if (_overflowBehavior)
    [_overflowBehavior updateStates];
  
  [self updateTextSize];
}

- (UIFont *)font {
  return _labelView.font;
}

#pragma mark Overflow Behavior

- (void)setOverflowBehavior:
            (id<IonLabelOverflowBehaviorDelegate>)overflowBehavior {
  _overflowBehavior = overflowBehavior;
  [_overflowBehavior setContainer:self andLabel:_labelView];
}

#pragma mark Frame

- (void)setFrame:(CGRect)frame {
  [super setFrame:frame];
  if (_overflowBehavior)
    [_overflowBehavior updateStates];
}

#pragma mark Style Application

- (void)applyStyle:(IonStyle *)style {
  [super applyStyle:style];

  // Text Color
  self.textColor = [style.configuration colorForKey:sIonThemeText_Color
                                         usingTheme:style.theme];

  // Font
  self.font = [style.configuration fontForKey:sIonThemeText_Font];

  // Alignment
  self.textAlignment =
      [style.configuration textAlignmentForKey:sIonThemeText_Alignment];
}

#pragma mark View Updates

- (void)addSubview:(UIView *)view {
  [super addSubview: view];
  [view setParentStyle: self.themeConfiguration.currentStyle ];
}


#pragma mark Defaults

+ (UIFont *)defaultFont {
  return [UIFont fontWithName:sDefaultFontName size:sDefaultFontSize];
}

@end

@implementation UILabel (IonStyle)

- (void)applyStyle:(IonStyle *)style {
  [super applyStyle:style];
  
  // Text Color
  self.textColor = [style.configuration colorForKey:sIonThemeText_Color
                                         usingTheme:style.theme];
  
  // Font
  self.font = [style.configuration fontForKey:sIonThemeText_Font];
  
  // Alignment
  self.textAlignment =
  [style.configuration textAlignmentForKey:sIonThemeText_Alignment];
}

+ (NSSet *)keyPathsForValuesAffectingTextSize {
  return [[NSSet alloc] initWithArray: @[@"font", @"text", @"frame"]];
}
- (CGSize) textSize {
  CGSize textSize = [self.text sizeWithFont:self.font];
  // Shh I'm adding a buffer so that we don't clip the text.
  return  (CGSize){ textSize.width + 2, textSize.height };
}

- (IonGuideLine *)textHeightGuide {
  IonGuideLine *_textHeightGuide = [self.categoryVariables objectForKeyedSubscript:@"textHeightGuide"];
  if (!_textHeightGuide) {
    _textHeightGuide =
    [IonGuideLine guideFromSizeOnTarget:self
                           usingKeyPath:@"textSizeWithFont"
                                 amount:1.0f
                                andMode:IonGuideLineFrameMode_Vertical];
    
    [self.categoryVariables setObject: _textHeightGuide forKey:@"textHeightGuide"];
  }
  return _textHeightGuide;
}

- (IonGuideLine *)textWidthGuide {
  IonGuideLine *_textWidthGuide = [self.categoryVariables objectForKeyedSubscript:@"textWidthGuide"];
  if (!_textWidthGuide) {
    _textWidthGuide =
    [IonGuideLine guideFromSizeOnTarget:self
                           usingKeyPath:@"textSizeWithFont"
                                 amount:1.0f
                                andMode:IonGuideLineFrameMode_Horizontal];
    [self.categoryVariables setObject: _textWidthGuide forKey:@"textWidthGuide"];
  }
  return _textWidthGuide;
}

+ (NSSet *)keyPathsForValuesAffectingTextSizeConstrainedByWidth {
  return [[NSSet alloc] initWithArray: @[@"font", @"text", @"frame"]];
}

- (CGFloat) textSizeConstrainedByWidth {
  return [self sizeThatFits:(CGSize){ self.frame.size.width, CGFLOAT_MAX }].height;
}


- (IonGuideLine *)textSizeConstrainedByWidthGuide {
  IonGuideLine *_textWidthGuide = [self.categoryVariables objectForKeyedSubscript:@"textSizeConstrainedByWidthGuide"];
  if (!_textWidthGuide) {
    _textWidthGuide =
    [IonGuideLine guideWithTarget:self andKeyPath:@"textSizeConstrainedByWidth"];
    [self.categoryVariables setObject: _textWidthGuide forKey:@"textSizeConstrainedByWidthGuide"];
  }
  return _textWidthGuide;
}
@end

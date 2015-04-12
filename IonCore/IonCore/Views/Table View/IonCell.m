//
//  IonCell.m
//  IonCore
//
//  Created by Andrew Hurst on 11/9/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "IonCell.h"
#import <IonCore/IonCore.h>

@implementation IonCell

@synthesize preferredHeightGuide = _preferredHeightGuide;
@synthesize tapGestureRecognizer = _tapGestureRecognizer;

#pragma mark Construction

- (void)construct {
  [super construct];
  self.themeElement = @"cell";
  self.preferredHeight = 50;
  self.styleCanSetBackground = TRUE;
}

#pragma mark Guides

- (IonGuideLine *)preferredHeightGuide {
  if (!_preferredHeightGuide)
    _preferredHeightGuide =
        [IonGuideLine guideWithTarget:self andKeyPath:@"preferredHeight"];
  return _preferredHeightGuide;
}

#pragma mark Data Binding

- (void)bindToDataModel:(id)dataModel {
  // Set the UI to match the data
}

- (void)unbindFromDataModel {
  // Clear current bindings.
}

#pragma mark Tap Gesture Recognizor

- (UITapGestureRecognizer *)tapGestureRecognizer {
  if (!_tapGestureRecognizer) {
    _tapGestureRecognizer = [[UITapGestureRecognizer alloc] init];
    [self addGestureRecognizer:_tapGestureRecognizer];
  }
  return _tapGestureRecognizer;
}

#pragma mark Scoring

- (CGFloat)cellSizeScore {
  if (![self.superview isKindOfClass:[UIView class]]) return 0.0f;
  return (CGFloat)ceil(self.frame.size.height /
                       self.superview.frame.size.height);
}

@end

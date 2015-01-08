//
//  IonView.m
//  Ion
//
//  Created by Andrew Hurst on 7/13/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonView.h"
#import "UIView+IonGuideLine.h"
#import <IonData/IonData.h>

static NSString* sIonGuideLine_AutoMargin_Vert =
    @"IonGuideLine_AutoMargin_Vert";
static NSString* sIonGuideLine_AutoMargin_Horiz =
    @"IonGuideLine_AutoMargin_Horiz";

static NSString* sIonGuideLine_StyleMargin_Vert =
    @"IonGuideLine_StyleMargin_Vert";
static NSString* sIonGuideLine_StyleMargin_Horiz =
    @"IonGuideLine_StyleMargin_Horiz";

@interface IonView () {
  CGSize _autoMargin;
}

@end

@implementation IonView
#pragma mark Construction

- (instancetype)init {
  self = [super init];
  if (self) {
    [self construct];
    self.styleCanSetBackground = TRUE;
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self construct];
    self.styleCanSetBackground = TRUE;
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder*)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self construct];
    self.styleCanSetBackground = TRUE;
  }
  return self;
}

- (void)construct {
  self.styleCanSetBackground = TRUE;
  // Subclass all construction code here.
}
#pragma mark Subview Management
- (void)forEachIonViewChildPerformBlock:(void (^)(IonView* child))actionBlock {
  if (!actionBlock) return;
  for (IonView* child in self.subviews) actionBlock(child);
}

- (void)addSubview:(UIView*)view {
  [super addSubview:view];
  [view setParentStyle:self.themeConfiguration.currentStyle];
}
@end

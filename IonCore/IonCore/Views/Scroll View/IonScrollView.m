//
//  IonScrollView.m
//  Ion
//
//  Created by Andrew Hurst on 9/21/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonScrollView.h"
#import <IonCore/IonCore.h>

@interface IonScrollView ()
#pragma mark Content Size
/**
 * The guide set in charge of manageing guide set updates.
 */
@property(strong, nonatomic, readonly) IonGuideSet *contentSizeGuideSet;

/**
 * The last captured content size manually set.
 */
@property(assign, nonatomic, readwrite) CGSize lastManualContentSize;

/**
 * Gets invoked by the guide set when one of the guides describing the content
 * size changes.
 */
- (void)contentSizeGuidesDidChange;

#pragma mark Style Application
/**
 * Apples general scroll configuration from the inputted style.
 * @param style - the style to extract the zoom configuration from.
 */
- (void)applyScrollConfiguration:(NSDictionary *)config;

/**
 * Applies scroll indicator configuration from the inputted style.
 * @param style - the style to extract the zoom configuration from.
 */
- (void)applyScrollIndicatorsConfiguration:(NSDictionary *)config;

/**
 * Applies zoom configuration from the inputted style.
 * @param style - the style to extract the zoom configuration from.
 */
- (void)applyZoomConfiguration:(NSDictionary *)config;

#pragma mark Actions
/**
 * An array of linked actions which we inform of changes to our content offset.
 */
@property(strong, nonatomic, readonly) NSMutableArray *actions;

#pragma mark Threshold Updates
/**
 * Informs actions of changes.
 */
- (void)informActionsOfChange;

@end

@implementation IonScrollView

@synthesize actions = _actions;
@synthesize contentOffsetHoriz = _contentOffsetHoriz;
@synthesize contentOffsetVert = _contentOffsetVert;
@synthesize contentSizeGuideSet = _contentSizeGuideSet;
@synthesize contentSizeHoriz = _contentSizeHoriz;
@synthesize contentSizeVert = _contentSizeVert;
@synthesize forceScrollHoriz = _forceScrollHoriz;
@synthesize forceScrollVert = _forceScrollVert;

#pragma mark Construction

- (instancetype)init {
  self = [super init];
  if (self) [self construct];
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) [self construct];
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) [self construct];
  return self;
}

- (void)construct {
  self.lastManualContentSize = CGSizeZero;
  self.styleCanSetBackground = TRUE;
  // Configurable
  self.themeElement = sIonScrollStyle_Name;
}

#pragma mark Content Offset

- (IonGuideLine *)contentOffsetHoriz {
  if (!_contentOffsetHoriz)
    _contentOffsetHoriz =
        [IonGuideLine guideFromPointOnTarget:self
                                usingKeyPath:@"contentOffset"
                                     andMode:IonGuideLineFrameMode_Horizontal];
  return _contentOffsetHoriz;
}

- (IonGuideLine *)contentOffsetVert {
  if (!_contentOffsetVert)
    _contentOffsetVert =
        [IonGuideLine guideFromPointOnTarget:self
                                usingKeyPath:@"contentOffset"
                                     andMode:IonGuideLineFrameMode_Vertical];
  return _contentOffsetVert;
}

#pragma mark Content Size

- (IonGuideSet *)contentSizeGuideSet {
  if (!_contentSizeGuideSet) {
    _contentSizeGuideSet = [[IonGuideSet alloc] init];
    [_contentSizeGuideSet addTarget:self
                          andAction:@selector(contentSizeGuidesDidChange)];
  }
  return _contentSizeGuideSet;
}

- (void)setContentSize:(CGSize)contentSize {
  [self setContentSizeInternal:contentSize];
  // Intercept the last captured manual content size so we can revert to it if
  // necessary
  self.lastManualContentSize = contentSize;
}

- (void)setContentSizeInternal:(CGSize)contentSize {
  CGSize iSize = contentSize;
  iSize = (CGSize){
      MAX(1, self.forceScrollHoriz ? MAX(self.frame.size.width + 1, iSize.width)
                                   : iSize.width),
      MAX(1, self.forceScrollVert
                 ? MAX(self.frame.size.height + 1, iSize.height)
                 : iSize.height)};
  [super setContentSize:iSize];
}

- (void)setFrame:(CGRect)frame {
  [super setFrame:frame];
  self.contentSize = self.contentSize;
}

- (void)setContentSizeHoriz:(IonGuideLine *)horiz andVert:(IonGuideLine *)vert {
  self.contentSizeHoriz = horiz;
  self.contentSizeVert = vert;
}

+ (NSSet *)keyPathsForValuesAffectingContentSizeHoriz {
  return [[NSSet alloc]
      initWithArray:@[ @"contentSizeGuideSet.contentSizeHoriz" ]];
}

- (void)setContentSizeHoriz:(IonGuideLine *)contentSizeHoriz {
  [self.contentSizeGuideSet setGuide:contentSizeHoriz
                              forKey:@"contentSizeHoriz"];
}

- (IonGuideLine *)contentSizeHoriz {
  return [self.contentSizeGuideSet guideForKey:@"contentSizeHoriz"];
}

+ (NSSet *)keyPathsForValuesAffectingContentSizeVert {
  return [[NSSet alloc]
      initWithArray:@[ @"contentSizeGuideSet.contentSizeVert" ]];
}

- (void)setContentSizeVert:(IonGuideLine *)contentSizeVert {
  [self.contentSizeGuideSet setGuide:contentSizeVert forKey:@"contentSizeVert"];
}

- (IonGuideLine *)contentSizeVert {
  return [self.contentSizeGuideSet guideForKey:@"contentSizeVert"];
}

- (void)contentSizeGuidesDidChange {
  CGSize newContentSize;

  // Update horizontal if applicable
  if (self.contentSizeHoriz)
    newContentSize.width = self.contentSizeHoriz.position;
  else
    newContentSize.width = self.lastManualContentSize.width;

  // Update vertical if applicable.
  if (self.contentSizeVert)
    newContentSize.height = self.contentSizeVert.position;
  else
    newContentSize.height = self.lastManualContentSize.height;

  // We need to set it to the super so we can intercept when the user sets the
  // content size manually.
  [self setContentSizeInternal:newContentSize];
}

#pragma mark Style

- (void)applyStyle:(IonStyle *)style {
  [super applyStyle:style];
  if (!style || ![style isKindOfClass:[IonStyle class]]) return;

  [self applyScrollConfiguration:style.configuration];
  [self applyScrollIndicatorsConfiguration:style.configuration];
  [self applyZoomConfiguration:style.configuration];
}

- (void)applyScrollConfiguration:(NSDictionary *)config {
  if (!config || ![config isKindOfClass:[NSDictionary class]]) return;
  // Content Inset
  self.contentInset = [config edgeInsetsForKey:sIonScrollStyle_ContentInset];

  // Bounce at edge
  self.bounces =
      [config boolForKey:sIonScrollStyle_BouncesAtEdge defaultValue:TRUE];

  // always bounce vertical
  self.alwaysBounceVertical =
      [config boolForKey:sIonScrollStyle_AlwaysBouncesVertical
            defaultValue:FALSE];

  // always bounce horizontal
  self.alwaysBounceHorizontal =
      [config boolForKey:sIonScrollStyle_AlwaysBouncesHorizontal
            defaultValue:FALSE];

  // scroll to top gesture enabled
  self.scrollsToTop = [config boolForKey:sIonScrollStyle_UsesScrollToTopGesture
                            defaultValue:TRUE];

  // Deceleration rate
  self.decelerationRate = [config
      scrollViewDecelerationRateForKey:sIonScrollStyle_DecelerationRate];

  // Keyboard dismiss mode
  self.keyboardDismissMode = [config
      scrollViewKeyboardDismissModeForKey:sIonScrollStyle_KeyboardDismissMode];
}

- (void)applyScrollIndicatorsConfiguration:(NSDictionary *)config {
  if (!config || ![config isKindOfClass:[NSDictionary class]]) return;
  // Indicator style
  self.indicatorStyle =
      [config scrollViewIndicatorStyleForKey:sIonScrollStyle_IndicatorStyle];

  // Shows horizontal scroll indicator
  self.showsHorizontalScrollIndicator =
      [config boolForKey:sIonScrollStyle_ShowsHorizontalIndicator
            defaultValue:TRUE];

  // Shows vertical scroll indicator
  self.showsVerticalScrollIndicator =
      [config boolForKey:sIonScrollStyle_ShowsHorizontalIndicator
            defaultValue:TRUE];

  // Scroll Indicator insets
  self.scrollIndicatorInsets =
      [config edgeInsetsForKey:sIonScrollStyle_IndicatorInsets];
}

- (void)applyZoomConfiguration:(NSDictionary *)config {
  if (!config || ![config isKindOfClass:[NSDictionary class]]) return;
  // Minimum zoom scale
  self.minimumZoomScale = [[config numberForKey:sIonScrollStyle_MinimumZoomScale
                                   defaultValue:@1.0] floatValue];

  // Maximum zoom scale
  self.maximumZoomScale = [[config numberForKey:sIonScrollStyle_MaximumZoomScale
                                   defaultValue:@1.0] floatValue];

  // Zoom bounces
  self.bouncesZoom =
      [config boolForKey:sIonScrollStyle_ZoomBounces defaultValue:TRUE];
}

#pragma mark Scroll View Interface

- (void)setContentOffset:(CGPoint)contentOffset {
  [super setContentOffset:contentOffset];

  // Inform our thresholds so that we can check our offset
  [self informActionsOfChange];
}

#pragma mark Force Scroll

- (void)setForceScrollHoriz:(BOOL)forceScrollHoriz {
  [self willChangeValueForKey:@"forceScrollHoriz"];
  _forceScrollHoriz = forceScrollHoriz;
  [self didChangeValueForKey:@"forceScrollHoriz"];
  self.contentSize = self.contentSize;
}

- (void)setForceScrollVert:(BOOL)forceScrollVert {
  [self willChangeValueForKey:@"forceScrollVert"];
  _forceScrollVert = forceScrollVert;
  [self didChangeValueForKey:@"forceScrollVert"];
  self.contentSize = self.contentSize;
}

#pragma mark Action Management

- (NSMutableArray *)actions {
  if (!_actions) _actions = [[NSMutableArray alloc] init];
  return _actions;
}

- (void)addAction:(IonScrollAction *)action {
  NSParameterAssert(action && [action isKindOfClass:[IonScrollAction class]]);
  if (!action || ![action isKindOfClass:[IonScrollAction class]]) return;

  [self.actions addObject:action];
}

- (void)removeAction:(IonScrollAction *)action {
  NSParameterAssert(action && [action isKindOfClass:[IonScrollAction class]]);
  if (!action || ![action isKindOfClass:[IonScrollAction class]]) return;

  [self.actions removeObject:action];
}

- (void)removeAllActions {
  [self.actions removeAllObjects];
}

#pragma mark Threshold Updates

- (void)informActionsOfChange {
  for (IonScrollAction *action in self.actions)
    [action scrollViewDidUpdateContext:self];
}

#pragma mark View Updates

- (void)addSubview:(UIView *)view {
  [super addSubview:view];
  [view setParentStyle:self.themeConfiguration.currentStyle];
}

@end

@implementation UIScrollView (ContentSizeGuides)

- (IonGuideLine *)currentContentHeightGuide {
  IonGuideLine *currentGuide =
      [self.categoryVariables objectForKey:@"currentContentHeightGuide"];
  if (!currentGuide) {
    currentGuide =
        [IonGuideLine guideFromSizeOnTarget:self
                               usingKeyPath:@"contentSize"
                                     amount:1.0f
                                    andMode:IonGuideLineFrameMode_Vertical];
    [self.categoryVariables setObject:currentGuide
                               forKey:@"currentContentHeightGuide"];
  }
  return currentGuide;
}

- (IonGuideLine *)currentContentWidthGuide {
  IonGuideLine *currentGuide =
      [self.categoryVariables objectForKey:@"currentContentWidthGuide"];
  if (!currentGuide) {
    currentGuide =
        [IonGuideLine guideFromSizeOnTarget:self
                               usingKeyPath:@"contentSize"
                                     amount:1.0f
                                    andMode:IonGuideLineFrameMode_Horizontal];
    [self.categoryVariables setObject:currentGuide
                               forKey:@"currentContentWidthGuide"];
  }
  return currentGuide;
}
@end

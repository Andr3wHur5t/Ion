//
//  IonScrollRefreshActionView.m
//  Ion
//
//  Created by Andrew Hurst on 10/3/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonScrollRefreshActionView.h"
#import <IonCore/IonCore.h>

@interface IonScrollRefreshActionView () {
  UIEdgeInsets _originalInsets, _showInsets;
}

/**
 * A quick reference to our scroll view.
 */
@property(weak, nonatomic, readonly) IonScrollView *scrollView;

#pragma mark Guides
/**
 * Our content bottom guide; This is the calculated guide for the bottom size of
 * the content view.
 */
@property(strong, nonatomic, readonly) IonGuideLine *contentBottomGuide;

/**
 * Our active height guide; This is just a guide set to the active height of the
 * view.
 */
@property(strong, nonatomic, readonly) IonGuideLine *activeHeightGuide;

#pragma mark Scroll Action
/**
 * Our scroll action, all of our scroll response logic is in here.
 * We simply add our self as a target action, and display a response to
 * activation.
 */
@property(strong, nonatomic, readonly) IonScrollRefreshAction *scrollAction;

/**
 * Gets invoked by our scroll action whenever a refresh gesture occurs.
 */
- (void)refreshGestureDidOccur;

@end

@implementation IonScrollRefreshActionView

@synthesize scrollAction = _scrollAction;
@synthesize contentBottomGuide = _contentBottomGuide;
@synthesize activeHeightGuide = _activeHeightGuide;
@synthesize activationDistance = _activationDistance;

@synthesize offsetGuide = _offsetGuide;

#pragma mark Construction

- (instancetype)initWithContentView:(UIView *)contentView
                       activeHeight:(CGFloat)activeHeight
              andActivationDistance:(CGFloat)distance {
  self = [super init];
  if (self) {
    self.contentView = contentView;
    self.activeHeight = activeHeight;
    self.activationDistance = distance;
    [self offsetDidUpdate];
  }
  return self;
}

- (instancetype)initWithContentView:(UIView *)contentView
                    andActiveHeight:(CGFloat)activeHeight {
  return [self
        initWithContentView:contentView
               activeHeight:activeHeight
      andActivationDistance:sIonRefreshActionViewDefault_ActivationDistance];
}

- (instancetype)initWithContentView:(UIView *)contentView {
  return [self initWithContentView:contentView
                   andActiveHeight:sIonRefreshActionViewDefault_ActiveHeight];
}

- (void)construct {
  self.themeElement = sIonRefreshActionViewStyle_Name;
  self.activeHeight = sIonRefreshActionViewDefault_ActiveHeight;
  self.activationDistance = sIonRefreshActionViewDefault_ActivationDistance;
  self.canAutomaticallyDisplay =
      sIonRefreshActionViewDefault_CanAutomaticallyDisplay;
  _state = IonScrollRefreshActionViewState_Closed;
}

#pragma mark Style Application

- (void)applyStyle:(IonStyle *)style {
  [super applyStyle:style];

  // Set active height or use default.
  self.activeHeight = [[style.configuration
      numberForKey:sIonRefreshActionViewStyle_ActiveHeight
      defaultValue:@(sIonRefreshActionViewDefault_ActiveHeight)] floatValue];

  // Set activation distance or use default.
  self.activationDistance = [[style.configuration
      numberForKey:sIonRefreshActionViewStyle_ActivationDistance
      defaultValue:
          @(sIonRefreshActionViewDefault_ActivationDistance)] floatValue];

  [self offsetDidUpdate];
}

#pragma mark Action View Interface.

- (void)configureScrollView:(IonScrollView *)scrollView {
  // Add our scroll action to the scroll view
  [scrollView addAction:self.scrollAction];

  // Configure our position and size
  [self setGuidesWithLocalHoriz:self.originGuideHoriz
                      localVert:self.sizeGuideVert
                     superHoriz:scrollView.originGuideHoriz
                      superVert:[[self marginHeight] negativeGuide]
                           left:scrollView.originGuideHoriz
                          right:scrollView.sizeGuideHoriz
                            top:scrollView.originGuideVert
                      andBottom:scrollView.sizeGuideVert];
}

- (void)removeConfigurationsFromScrollView:(IonScrollView *)scrollView {
  [scrollView removeAction:self.scrollAction];
}

#pragma mark Content View

+ (BOOL)automaticallyNotifiesObserversOfContentView {
  return FALSE;
}

- (void)setContentView:(UIView *)contentView {
  // Remove the old view if there was one.
  if (_contentView) {
    [_contentView removeFromSuperview];
    self.scrollAction.statusDelegate = NULL;
  }

  // Update the content view.
  [self willChangeValueForKey:@"contentView"];
  _contentView = contentView;
  [self didChangeValueForKey:@"contentView"];

  // We can't configure null, return.
  if (!_contentView || ![_contentView isKindOfClass:[UIView class]]) return;

  // Check if we can update the status of the gesture
  if ([_contentView
          conformsToProtocol:@protocol(IonScrollRefreshActionStatusDelegate)])
    self.scrollAction.statusDelegate =
        (UIView<IonScrollRefreshActionStatusDelegate> *)contentView;

  // Position the content view.
  [_contentView setGuidesWithLocalHoriz:_contentView.originGuideHoriz
                              localVert:_contentView.sizeGuideVert
                             superHoriz:self.leftAutoPadding
                           andSuperVert:self.bottomAutoPadding];

  // Configure the content view.
  [_contentView setSizeGuidesWithLeft:self.leftAutoPadding
                                right:self.rightAutoPadding
                                  top:self.topAutoPadding
                            andBottom:self.contentBottomGuide];

  // Add to the view.
  [self addSubview:_contentView];

  return;
}

#pragma mark Guides

- (IonGuideLine *)contentBottomGuide {
  if (!_contentBottomGuide) {
    _contentBottomGuide = [IonGuideLine guideWithGuide:self.activeHeightGuide
                                               modType:IonValueModType_Subtract
                                        andSecondGuide:self.topAutoPadding];
    _contentBottomGuide.debugName = @"contentBottomGuide";
  }
  return _contentBottomGuide;
}

- (IonGuideLine *)activeHeightGuide {
  if (!_activeHeightGuide) {
    _activeHeightGuide =
        [IonGuideLine guideWithTarget:self andKeyPath:@"activeHeight"];
    _activeHeightGuide.debugName = @"activeHeightGuide";
  }
  return _activeHeightGuide;
}

- (void)setOffsetGuide:(IonGuideLine *)offsetGuide {
  if ([_offsetGuide isKindOfClass:[IonGuideLine class]]) {
    [_offsetGuide removeLocalObserverTarget:self
                                  andAction:@selector(offsetDidUpdate)];
  }

  _offsetGuide = offsetGuide;
  if ([_offsetGuide isKindOfClass:[IonGuideLine class]]) {
    [_offsetGuide addLocalObserverTarget:self
                               andAction:@selector(offsetDidUpdate)];
    [self offsetDidUpdate];
  }
}

#pragma mark Positioning

- (void)offsetDidUpdate {
  UIEdgeInsets insets = _showInsets;

  // Modify
  insets.top += [self offsetPositon];
  // Set insets and update state
  self.scrollView.contentInset = insets;
  self.scrollAction.distance = self.activationDistance;
  self.scrollAction.returnBuffer = [self offsetPositon];
}

- (CGFloat)offsetPositon {
  return ([self.offsetGuide isKindOfClass:[IonGuideLine class]]
              ? self.offsetGuide.position
              : 0);
  ;
}

- (UIEdgeInsets)realInsets {
  UIEdgeInsets i = self.scrollView.contentInset;
  i.top -= [self offsetPositon];
  return i;
}

- (void)show {
  // Only animate if we are not already in open state.
  if (self.state != IonScrollRefreshActionViewState_Closed) return;

  // Animate if we have a scroll view.
  if (![self.superview isKindOfClass:[IonScrollView class]]) return;

  // Modify
  _showInsets.top = self.activeHeight + [self marginHeight].position;

  // Set insets and update state
  //    self.scrollView.contentInset = newInsets;
  [self offsetDidUpdate];
  _state = IonScrollRefreshActionViewState_Open;
}

- (void)hide {
  // Only animate if we are not already in open state.
  if (self.state != IonScrollRefreshActionViewState_Open) return;

  // Animate if we have a scroll view.
  if (![self.superview isKindOfClass:[IonScrollView class]]) return;

  _showInsets.top = 0;
  // Set insets and update state

  _state = IonScrollRefreshActionViewState_Closed;
  [self offsetDidUpdate];
}

#pragma mark Animations

- (void)showAnimated {
  [UIView animateWithDuration:self.animationDuration
                   animations:^{
                     [self show];
                   }];
}

- (void)hideAnimated {
  [UIView animateWithDuration:self.animationDuration
                   animations:^{
                     [self hide];
                   }];
}

#pragma mark Scroll Action

- (IonScrollRefreshAction *)scrollAction {
  if (!_scrollAction) {
    _scrollAction = [[IonScrollRefreshAction alloc] init];
    [_scrollAction addTarget:self andAction:@selector(refreshGestureDidOccur)];
  }
  return _scrollAction;
}

- (void)refreshGestureDidOccur {
  if (self.canAutomaticallyDisplay) [self showAnimated];
}

#pragma mark Scroll View

- (IonScrollView *)scrollView {
  return (IonScrollView *)self.superview;
}

#pragma mark Target Actions

- (void)addTargetActionSet:(FOTargetActionSet *)targetAction {
  [self.scrollAction addTargetActionSet:targetAction];
}

- (void)removeTargetActionSet:(FOTargetActionSet *)targetAction {
  [self.scrollAction removeTargetActionSet:targetAction];
}

- (void)addTarget:(id)target andAction:(SEL)action {
  [self.scrollAction addTarget:target andAction:action];
}

- (void)removeTarget:(id)target andAction:(SEL)action {
  [self.scrollAction removeTarget:target andAction:action];
}
@end

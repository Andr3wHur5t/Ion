//
//  IonPaginationController.m
//  IonCore
//
//  Created by Andrew Hurst on 10/20/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "IonPaginationController.h"
#import <IonCore/IonCore.h>
#import <SimpleMath/SimpleMath.h>
#import <objc/runtime.h>

@interface IonPaginationController ()

#pragma mark Guides

/*!
 @brief An array of guide groups.
 */
@property(strong, nonatomic, readonly) NSMutableArray *guideGroups;

/*!
 @brief  Gets, or constructs a guide group for the specified index.

 @param index The index to get the guide group for.

 @return A guide group positioned at the specified index.
 */
- (IonGuideGroup *)guideGroupForIndex:(NSUInteger)index;

@property(strong, nonatomic, readonly) NSMutableArray *activeControllers;

/*!
 @brief This keeps a count of the number of pages that we are displaying.

 @discussion This should be a NSUInteger but because the guide system uses
 CGFloat and there is no casting we have to use a CGFloat. Fix when possible.
 */
@property(assign, nonatomic, readwrite) CGFloat pageCount;

@property(assign, nonatomic, readwrite) CGFloat currentPagePosition;

@end

@implementation IonPaginationController

@synthesize pages = _pages;
@synthesize pageNames = _pageNames;
@synthesize guideGroups = _guideGroups;
@synthesize activeControllers = _activeControllers;
@synthesize router = _router;
@synthesize currentIndex = _currentIndex;

@synthesize pageCountGuide = _pageCountGuide;
@synthesize contentWidthGuide = _contentWidthGuide;
@synthesize scrollGuide = _scrollGuide;
@synthesize pagePosition = _pagePosition;

#pragma mark Construction

- (instancetype)init {
  self = [super init];
  if (self) {
    _currentIndex = 0;
    _isHorizontal = TRUE;
    self.pageCount = 0;
    self.pagingEnabled = TRUE;
    // Configure Guides
    [self configureContentSize];
  }
  return self;
}

- (instancetype)initWithHorizontalMode:(BOOL)mode {
  self = [self init];
  if (self) _isHorizontal = mode;
  // TODO: Add Vertical Mode
  return self;
}

- (instancetype)initWithRouter:(IACRouter *)router
             andHorizontalMode:(BOOL)mode {
  self = [self initWithHorizontalMode:mode];
  if (self) _router = router;
  return self;
}

- (instancetype)initWithRouter:(IACRouter *)router {
  return [self initWithRouter:router andHorizontalMode:TRUE];
}

#pragma mark Style

- (void)applyStyle:(IonStyle *)style {
  [super applyStyle:style];

  // Style Overrides
  self.showsHorizontalScrollIndicator = NO;
  self.showsVerticalScrollIndicator = NO;
}

#pragma mark Page Management

- (NSMutableArray *)pageNames {
  if (!_pageNames) _pageNames = [[NSMutableArray alloc] init];
  return _pageNames;
}

- (NSMutableArray *)pages {
  if (!_pages) _pages = [[NSMutableArray alloc] init];
  return _pages;
}

#pragma mark Page Management

- (void)addPageControllerClass:(Class)controllerClass
                      withName:(NSString *)name {
  NSString *controllerIdentifier;
  NSUInteger index;
  IACRouter *subrouter;
  NSParameterAssert(controllerClass);
  NSParameterAssert([name isKindOfClass:[NSString class]]);
  if (![name isKindOfClass:[NSString class]] || !controllerClass) return;

  // Generate Controller ID so we can register it.
  // TODO: Register with prepended identifier (Conflict Resolution)
  controllerIdentifier = name;

  // Register Controller
  [[IonApplication sharedApplication]
      registerControllerClass:controllerClass
               withIdentifier:controllerIdentifier];

  // Register Router For Controller
  if (self.router) {
    subrouter = [self.router subRouterWithName:name];

    // Configure router to invoke self so we can transition to it.
    // Create a method for the router to invoke
    class_addMethod([self class],
                    [self selectorForControllerWithLocalName:name],
                    [self impForControllerWithLocalName:name], "v@:@");

    // Register it with the router
    [subrouter addTarget:self
               addAction:[self selectorForControllerWithLocalName:name]];

    // Register for the controller to be configured with the router.
    [[IonApplication sharedApplication] registerRouter:subrouter
                                        withIdentifier:controllerIdentifier];
  }

  // Register Name & ID
  index = self.pages.count;
  [self.pageNames setObject:name atIndexedSubscript:index];
  [self.pages setObject:controllerIdentifier atIndexedSubscript:index];

  // We need to increment using += or it wont register in KVO.
  self.pageCount += 1;
}

#pragma mark Orientation Change

- (void)setFrame:(CGRect)frame {
  [super setFrame:frame];

  // Wait tell after any animation to update position.
  // This is hacky :( need to find a better way.
  if (!isnan(self.currentPagePosition)) {
    //    NSLog( @"Last: %@", @(self.currentPagePosition) );
    //    self.contentOffset = (CGPoint){ self.currentPagePosition *
    //    self.frame.size.width, 0.0f };
  }

  // The first value always seems good, once change occurs things get weird
}

#pragma mark Router Interface

- (IMP)impForControllerWithLocalName:(NSString *)name {
  // We need a name to invoke that persists.
  __block NSString *localName = name;
  return imp_implementationWithBlock(
      ^(IonPaginationController *_self, IACLink *link) {
        UIViewController *controller;
        if (![link isKindOfClass:[IACLink class]]) return;

        // Get the controller
        controller = [[IonApplication sharedApplication]
            controllerForName:[self.pages
                                  objectAtIndex:[_self indexOfName:localName]]];

        // Report to the delegate
        if ([self.pageDelegate
                respondsToSelector:@selector(willOpenSubControllerWithLink:)])
          [self.pageDelegate willOpenSubControllerWithLink:link];

        // Invoke link methods so the controller can respond
        [controller willOpenWithLink:link];
        [_self navigateToPageWithName:localName];
        [controller didOpenWithLink:link];

        // Report to the delegate
        if ([self.pageDelegate
                respondsToSelector:@selector(didOpenSubControllerWithLink:)])
          [self.pageDelegate didOpenSubControllerWithLink:link];
      });
}

- (SEL)selectorForControllerWithLocalName:(NSString *)name {
  return NSSelectorFromString(
      [NSString stringWithFormat:@"open%@WithLink:", name]);
}

#pragma mark Internal Page Management

- (NSMutableArray *)activeControllers {
  if (!_activeControllers) _activeControllers = [[NSMutableArray alloc] init];
  return _activeControllers;
}

- (void)addActiveController:(UIViewController *)controller
                    atIndex:(NSUInteger)index {
  while (self.activeControllers.count <= index)
    [self.activeControllers addObject:[NSNull null]];
  [self.activeControllers setObject:controller atIndexedSubscript:index];
}

- (void)configurePageAtIndex:(NSUInteger)index {
  UIViewController *controller;
  NSString *controllerID;
  IonGuideGroup *guideGroup;
  if (self.pages.count <= index) return;
  // Set up controllers here when we need to.
  controllerID = [self.pages objectAtIndex:index];

  // Get the guide group for our position.
  guideGroup = [self guideGroupForIndex:index];

  // Construct controller
  controller =
      [[IonApplication sharedApplication] controllerForName:controllerID];

  // Add it to active controllers so we can remove it later.
  [self addActiveController:controller atIndex:index];

  // Size, and Position
  [controller.view setGuidesWithLocalHoriz:controller.view.originGuideHoriz
                                 localVert:controller.view.originGuideVert
                                superHoriz:guideGroup.originExternalGuideHoriz
                                 superVert:guideGroup.originExternalGuideVert
                                      left:self.originGuideHoriz
                                     right:self.sizeGuideHoriz
                                       top:self.originGuideVert
                                 andBottom:self.sizeGuideVert];

  // Add As Subview.
  if (![controller.view.superview isEqual:self])
    [self addSubview:controller.view];
  else
    controller.view.hidden = false;
}

- (void)removePageAtIndex:(NSUInteger)index {
  UIViewController *controller;
  if (self.activeControllers.count <= index) return;

  controller = [self.activeControllers objectAtIndex:index];
  if (![controller isKindOfClass:[UIViewController class]]) return;

  // Remove
  controller.view.hidden = TRUE;
}

#pragma mark Preloading

- (void)preloadPageAtIndex:(NSUInteger)index {
  [self configurePageAtIndex:index];
  [self removePageAtIndex:index];
}

#pragma mark Start

- (void)startAtPageWithName:(NSString *)name {
  NSParameterAssert([name isKindOfClass:[NSString class]]);
  if (![name isKindOfClass:[NSString class]]) return;
  [self startAtIndex:[self indexOfName:name]];
}

- (void)startAtIndex:(NSUInteger)index {
  NSParameterAssert(index <= self.pages.count);
  if (index >= self.pages.count) return;

  // Load Pages
  [self configureIndex:index];

  // Navigate to the page
  [self navigateToPageAtIndex:index animated:NO];

  // Force update index incase the index didn't initially change.
  [self updateDelegateWithIndex];
}

#pragma mark Utilities

- (NSUInteger)indexOfName:(NSString *)name {
  return [self.pageNames indexOfObject:name];
}

#pragma mark Navigation

- (void)navigateToPageWithName:(NSString *)name animated:(BOOL)animated {
  NSParameterAssert([name isKindOfClass:[NSString class]]);
  if (![name isKindOfClass:[NSString class]]) return;

  [self navigateToPageAtIndex:[self indexOfName:name] animated:animated];
}

- (void)navigateToPageWithName:(NSString *)name {
  [self navigateToPageWithName:name
                      animated:ABS((NSInteger)self.currentIndex -
                                   (NSInteger)[self indexOfName:name]) <= 2];
}

- (void)navigateToPageAtIndex:(NSUInteger)index animated:(BOOL)animated {
  CGFloat target =
      index * (_isHorizontal ? self.frame.size.width : self.frame.size.height);
  [self setContentOffset:(CGPoint) {
    _isHorizontal ? target : 0.0f, _isHorizontal ? 0.0f : target
  } animated:animated];
  [self navigatedToIndex:index];
}

- (void)navigateToPageAtIndex:(NSUInteger)index {
  [self navigateToPageAtIndex:index animated:TRUE];
}

#pragma mark Index Management

+ (BOOL)automaticallyNotifiesObserversOfCurrentIndex {
  return FALSE;
}

- (void)navigatedToIndex:(NSUInteger)index {
  if (index == self.currentIndex) return;

  [self willChangeValueForKey:@"currentIndex"];
  _currentIndex = index;
  [self didChangeValueForKey:@"currentIndex"];

  // Load and unload pages
  [self configureIndex:self.currentIndex];

  // Update Delegate
  [self updateDelegateWithIndex];
}

- (void)updateDelegateWithIndex {
  if ([self.pageDelegate
          conformsToProtocol:@protocol(IonPaginationControllerDelegate)])
    [self.pageDelegate didNavigateToPageAtIndex:self.currentIndex];
}

- (void)setContentOffset:(CGPoint)contentOffset {
  CGFloat flooredVal;
  [super setContentOffset:contentOffset];
  // Update our current page position
  self.currentPagePosition = self.contentOffset.x / self.frame.size.width;

  // Update navigation if needed.
  if (((CGFloat)self.currentIndex + 0.5f) < self.currentPagePosition ||
      ((CGFloat)self.currentIndex - 0.5f) > self.currentPagePosition) {
    flooredVal =
        (CGFloat)floor((self.contentOffset.x - self.frame.size.width / 2) /
                       self.frame.size.width);
    [self navigatedToIndex:(NSUInteger)(flooredVal + 1)];
  }
}

- (void)configureIndex:(NSUInteger)index {
  [self removePageAtIndex:self.currentIndex + 2];
  [self configurePageAtIndex:self.currentIndex + 1];
  [self configurePageAtIndex:self.currentIndex];
  [self configurePageAtIndex:self.currentIndex - 1];
  [self removePageAtIndex:self.currentIndex - 2];
}

#pragma mark Guide Groups

- (NSMutableArray *)guideGroups {
  if (!_guideGroups) _guideGroups = [[NSMutableArray alloc] init];
  return _guideGroups;
}

- (IonGuideGroup *)guideGroupForIndex:(NSUInteger)index {
  IonGuideGroup *guideGroup;

  if (self.guideGroups.count > index)
    guideGroup = [self.guideGroups objectAtIndex:index];

  if (!guideGroup) {
    guideGroup = [[IonGuideGroup alloc] init];

    // Position, and Size.
    [guideGroup setGuidesWithLocalHoriz:guideGroup.originGuideHoriz
                              localVert:guideGroup.originGuideVert
                             superHoriz:[self originHorizGuideForIndex:index]
                              superVert:self.originGuideVert  // TODO Change
                                                              // according to
                                                              // mode
                                   left:self.originGuideHoriz
                                  right:self.sizeGuideHoriz
                                    top:self.originGuideVert
                              andBottom:self.sizeGuideVert];

    // Construct all prior guide groups
    while (self.guideGroups.count < index)
      [self guideGroupForIndex:self.guideGroups.count];

    // Cache it
    if (self.guideGroups.count == index)
      [self.guideGroups addObject:guideGroup];
    else
      [self.guideGroups setObject:guideGroup atIndexedSubscript:index];
  }
  return guideGroup;
}

- (IonGuideLine *)originHorizGuideForIndex:(NSUInteger)index {
  // TODO Change according to mode
  return [IonGuideLine guideWithGuide:self.sizeGuideHoriz
                              modType:IonValueModType_Multiply
                       andSecondGuide:[@(index) toGuideLine]];
}

#pragma mark Content Size Guides

- (void)configureContentSize {
  // TODO: Add Vertical Mode
  self.contentSizeHoriz = self.contentWidthGuide;
}

- (IonGuideLine *)pageCountGuide {
  if (!_pageCountGuide)
    _pageCountGuide =
        [IonGuideLine guideWithTarget:self andKeyPath:@"pageCount"];
  return _pageCountGuide;
}

- (IonGuideLine *)contentWidthGuide {
  if (!_contentWidthGuide)
    _contentWidthGuide = [IonGuideLine guideWithGuide:self.pageCountGuide
                                              modType:IonValueModType_Multiply
                                       andSecondGuide:self.sizeGuideHoriz];
  return _contentWidthGuide;
}

- (IonGuideLine *)scrollGuide {
  if (!_scrollGuide)
    _scrollGuide = [IonGuideLine guideWithGuide:self.pagePosition
                                        modType:IonValueModType_Multiply
                                 andSecondGuide:self.sizeGuideHoriz];
  return _scrollGuide;
}

- (IonGuideLine *)pagePosition {
  if (!_pagePosition)
    _pagePosition = [IonGuideLine guideWithGuide:self.contentOffsetHoriz
                                         modType:IonValueModType_Divide
                                  andSecondGuide:self.contentWidthGuide];
  return _pagePosition;
}

@end

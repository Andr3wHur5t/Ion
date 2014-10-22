//
//  IonPaginationController.m
//  IonCore
//
//  Created by Andrew Hurst on 10/20/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "IonPaginationController.h"
#import <IonCore/IonCore.h>

@interface IonPaginationController () {
    NSUInteger lastIndex;
    
    // We need this to not record double navigation
    NSTimeInterval lastIndexCheck;
}

#pragma mark Page Management
/**
 * Gets the index of the page with the specified name.
 * @param name - the name to get the index of.
 * @return the index of the inputted name.
 */
- (NSUInteger) indexOfName:(NSString *)name;

@end

@implementation IonPaginationController

@synthesize pages = _pages;
@synthesize pageNames = _pageNames;

#pragma mark Construction

- (instancetype) init {
    self = [super init];
    if ( self ) {
        lastIndex = 0;
        lastIndexCheck = [NSDate date].timeIntervalSinceReferenceDate;
        _isHorizontal = TRUE;
        self.pagingEnabled = TRUE;
    }
    return self;
}

- (instancetype) initWithHorizontalMode:(BOOL)mode {
    self = [self init];
    if ( self )
        _isHorizontal = mode;
    return self;
}

#pragma mark Style

- (void) applyStyle:(IonStyle *)style {
    [super applyStyle: style];
    
    // Style Overrides
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
}

#pragma mark Page Management

- (NSMutableArray *)pageNames {
    if ( !_pageNames )
        _pageNames = [[NSMutableArray alloc] init];
    return _pageNames;
}

- (NSMutableArray *)pages {
    if ( !_pages )
        _pages = [[NSMutableArray alloc] init];
    return _pages;
}

- (void) addPage:(IonViewController *)page withName:(NSString *)name {
    NSUInteger index;
    
    NSParameterAssert( [page isKindOfClass: [IonViewController class]] );
    NSParameterAssert( [name isKindOfClass: [NSString class]] );
    if ( ![page isKindOfClass: [IonViewController class]] || ![name isKindOfClass: [NSString class]] )
        return;
    
    // Register the page with our internal list
    index = self.pages.count;
    [self.pages setObject: page atIndexedSubscript: index];
    [self.pageNames setObject: name atIndexedSubscript: index];
    
    // Configure it.
    [self configurePageAtIndex: index];
    
    // Add it to our scroll view.
    [self addSubview: page.view];
    
    [self updateContentSize];
}

- (void) configurePageAtIndex:(NSUInteger) index {
    UIView *previousPage, *currentPage;
    
    // Attempt to get the previous page
    if ( index != 0)
        previousPage = ((IonViewController *)[self.pages objectAtIndex: index - 1]).view;
    currentPage = ((IonViewController *)[self.pages objectAtIndex: index]).view;

    // Configure the current page
    if ( ![currentPage isKindOfClass: [UIView class]] )
        return;
    
    [currentPage setGuidesWithLocalHoriz: currentPage.originGuideHoriz
                               localVert: currentPage.originGuideVert
                              superHoriz: [previousPage  isKindOfClass: [UIView class]] ?
     ( _isHorizontal ? previousPage.sizeExternalGuideHoriz : previousPage.sizeExternalGuideVert ) : self.originGuideHoriz
                               superVert: self.originGuideVert
                                    left: self.originGuideHoriz
                                   right: self.sizeGuideHoriz
                                     top: self.originGuideVert
                               andBottom: self.sizeGuideVert];
    
    
}

- (void) removePageWithName:(NSString *)name {
    NSParameterAssert( [name isKindOfClass: [NSString class]] );
    if ( ![name isKindOfClass: [NSString class]] )
        return;
    
    [self removePageAtIndex: [self indexOfName: name]];
}

- (void) removePageAtIndex:(NSUInteger) index {
    [self.pages removeObjectAtIndex: index];
    [self.pageNames removeObjectAtIndex: index];
    [self configurePageAtIndex: index];
    [self updateContentSize];
}

- (NSUInteger) indexOfName:(NSString *)name {
    return [self.pageNames indexOfObject: name];
}

- (void) updateContentSize {
    UIView *lastView = ((IonViewController *)[self.pages lastObject]).view;
    if ( ![lastView isKindOfClass: [UIView class]] )
        return;
    
    if ( _isHorizontal )
        self.contentSizeHoriz = lastView.sizeExternalGuideHoriz;
    else
        self.contentSizeVert = lastView.sizeExternalGuideVert;
    
    self.contentSizeHoriz.debuggingDepth = IonGuideDebugDepth_Shallow;
}


- (void) setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self updateContentSize];
}

#pragma mark Navigation

- (void) navigateToPageWithName:(NSString *)name animated:(BOOL) animated {
    NSParameterAssert( [name isKindOfClass: [NSString class]] );
    if ( ![name isKindOfClass: [NSString class]] )
        return;
    
    [self navigateToPageAtIndex: [self indexOfName: name] animated: animated];
}

- (void) navigateToPageWithName:(NSString *)name {
    [self navigateToPageWithName: name animated: TRUE];
}

- (void) navigateToPageAtIndex:(NSUInteger) index animated:(BOOL) animated {
    CGFloat target = index * ( _isHorizontal ? self.frame.size.width : self.frame.size.height);
    [self setContentOffset: (CGPoint) { _isHorizontal ? target : 0.0f , _isHorizontal ? 0.0f : target  }
                  animated: animated];
    [self checkNavigation];
}

- (void) navigateToPageAtIndex:(NSUInteger) index {
    [self navigateToPageAtIndex: index animated: TRUE];
}

- (void) checkNavigation {
    // Our calculation here needs to be more specific
    NSUInteger currentIndex = (NSUInteger)ceil(_isHorizontal ? self.contentOffset.x / self.frame.size.width :
                                                self.contentOffset.y / self.frame.size.height);
    
    if ( [self.delegate conformsToProtocol: @protocol(IonPaginationControllerDelegate)]
        && lastIndex != currentIndex && currentIndex < self.pages.count ) {
        [self.delegate didNavigateToPageAtIndex: currentIndex];
        lastIndex = currentIndex;
    }
}

- (void)setContentOffset:(CGPoint)contentOffset {
    [super setContentOffset: contentOffset];
    if ( lastIndexCheck + 300 > [NSDate date].timeIntervalSinceReferenceDate && !self.isTracking ) {
        [self checkNavigation];
        lastIndexCheck = [NSDate date].timeIntervalSinceReferenceDate;
    }
}

@end

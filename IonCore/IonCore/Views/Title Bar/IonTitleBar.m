//
//  IonTitleBar.m
//  Ion
//
//  Created by Andrew Hurst on 8/23/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonTitleBar.h"
#import <IonCore/IonCore.h>

@interface IonTitleBar (){
    IonGuideGroup* contentGroup;
    IonGuideLine* statusBarGuide;
    FOKeyValueObserver* statusFrameObserver;
}

/**
 * Our status offset height.
 */
@property (nonatomic, readonly) CGFloat statusOffsetHeight;
@end

@implementation IonTitleBar

#pragma mark Constructors

/**
 * Default constructor.  
 */
- (instancetype) init {
    self = [super init];
    if ( self )
        [self construct];
    return self;
}

/**
 * Frame Constructor.
 * @param frame - the frame to construct with.  
 */
- (instancetype) initWithFrame:(CGRect) frame {
    self = [super initWithFrame: frame];
    if ( self ) {
       [self construct];
        self.contentHeight = frame.size.height;
    }
    return self;
}

/**
 * Constructs the view  
 */
- (void) construct {
    self.respondsToStatusBar = FALSE;
    self.themeElement = sIonThemeElementTitleBar;
    self.contentHeight = 50.0f;
    [self constructContentGroup];
}

#pragma mark Frame

/**
 * Responds to frame changes.
 * @param {CGRect} the new frame  
 */
- (void) setFrame:(CGRect) frame {
    [super setFrame: [self currentFrame]];
}

/**
 * Gets a frame to match the current configuration.
 */
- (CGRect) currentFrame {
    return( CGRect){ [self.guideSet toPoint],
        (CGSize){ self.superview.frame.size.width, self.statusOffsetHeight + self.contentHeight } } ;
}

/**
 * Updates the frame to match the current configuration.  
 */
- (void) updateFrame {
    [self setFrame: [self currentFrame]];
}

- (void) willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview: newSuperview];
    
    // This is hackish but it works, basicly we need to observe changes to our supers' size.
    self.rightSizeGuide = newSuperview.sizeGuideHoriz;
    
    [self updateFrame];
}
#pragma mark Style application

/**
 * Applies the style to self.
 */
- (void) applyStyle:(IonStyle*) style {
    NSDictionary* config;
    NSNumber *contentOffset, *contentHeight;
    
    // Validate
    NSParameterAssert( style && [style isKindOfClass:[IonStyle class]] );
    if ( !style || ![style isKindOfClass:[IonStyle class]] )
        return;
    
    // Update Super
    [super applyStyle: style];
    
    // Get Element config
    config = [style.configuration dictionaryForKey: self.themeElement];
    if ( !config )
        return;
    
    // Content offset
    contentOffset = [config numberForKey: sIonThemeElementTitleBar_StatusBarOffset];
    self.statusBarContentOffset = contentOffset ? [contentOffset floatValue] : 0.0f;
    
    // Content Height
    contentHeight = [config numberForKey: sIonThemeElementTitleBar_ContentHeight];
    self.contentHeight = contentHeight ? [contentHeight floatValue] : self.contentHeight;
}

#pragma mark Content Guide Group

/**
 * Constructs the guide group.
 */
- (void) constructContentGroup {
    contentGroup = [[IonGuideGroup alloc] init];
    statusBarGuide = [IonGuideLine guideWithTargetRectPosition: [IonApplication sharedApplication]
                                              usingRectKeyPath: @"statusBarFrame"
                                                        amount: 1.0f
                                                       andMode: IonGuideLineFrameMode_Vertical];
    
    // Sizeing
    contentGroup.leftSizeGuide = self.leftAutoPadding;
    contentGroup.rightSizeGuide = self.rightAutoPadding;
    contentGroup.topSizeGuide = [IonGuideLine guideWithStaticValue: 0];
    contentGroup.bottomSizeGuide = [IonGuideLine guideWithTarget: self andKeyPath: @"contentHeight"];
    
    // Positioning
    contentGroup.superHorizGuide = self.leftPadding;
    contentGroup.superVertGuide = self.sizeGuideVert;
    contentGroup.localVertGuide = contentGroup.bottomSizeGuide;
}

#pragma mark Responds to Status Bar

/**
 * Switched KVO to manual mode
 */
+ (BOOL) automaticallyNotifiesObserversOfRespondsToStatusBar { return FALSE; }

/**
 * The setter for responding to changes in the status bar.
 * @param {BOOL} the new state.  
 */
- (void) setRespondsToStatusBar:(BOOL) respondsToStatusBar {
    [self willChangeValueForKey: @"respondsToStatusBar"];
    _respondsToStatusBar = respondsToStatusBar;
    [self didChangeValueForKey: @"respondsToStatusBar"];
    
    if ( _respondsToStatusBar ) {
        // observe the status frame and update content according to changes
        statusFrameObserver = [FOKeyValueObserver observeObject: [IonApplication sharedApplication]
                                                        keyPath: @"statusBarFrame"
                                                         target: self
                                                       selector: @selector(updateToMatchStatusBar)];
    }
    else
        statusFrameObserver = NULL;
}

#pragma mark Status Bar Response

/**
 * Updates the title bar to respond to the status bar.
 * @warning Will automatically adjust the size of the title bar.  
 */
- (void) updateToMatchStatusBar {
    [self animateMatchingStatusBarTransition: ^{
        [self updateFrame];
    }
    usingCompletion: NULL];
}

/**
 * Runs the correct animation for the current status bar transition.
 * @param {void^( )} the animation block.
 * @param (void^( )) the completion block.  
 */
- (void) animateMatchingStatusBarTransition:(void(^)( )) animation usingCompletion:(void(^)( )) completion {
    NSParameterAssert( animation );
    if ( !animation )
        return;

    // Animate
    [UIView animateWithDuration: [IonApplication sharedApplication].statusBarAnimationDuration
                          delay: 0.0f
                        options: UIViewAnimationOptionCurveEaseIn
                     animations: animation
                     completion: ^(BOOL finished) {
                         if ( completion )
                             completion( );
                     }];
}

/**
 * Gets the offset height for the title from the title bar frame.
 * @return {CGFloat}
 */
- (CGFloat) statusOffsetHeight {
    CGFloat offset;
    if ( !self.respondsToStatusBar )
        return 0.0f;
    
    
    offset = [IonApplication sharedApplication].statusBarFrame.size.height;
    
    if ( ![IonApplication sharedApplication].statusBarHidden ) {
        if ( [IonApplication sharedApplication].inCallBarActive )
            offset -= sIonNormalStatusBarHeight;
        else
            offset += self.statusBarContentOffset;
    }
    return offset;
}

#pragma mark Content Height 
/**
 * Switch content height KVO to manual.
 */
+ (BOOL) automaticallyNotifiesObserversOfContentHeight { return FALSE; }

/**
 * Content Height Setter
 * @param {CGFloat} the new content height  
 */
- (void) setContentHeight:(CGFloat)contentHeight {
    [self willChangeValueForKey: @"contentHeight"];
    _contentHeight = contentHeight;
    [self didChangeValueForKey: @"contentHeight"];
    [self updateFrame];
}

#pragma mark Left View

/**
 * Switch notifications to manual
 */
+ (BOOL) automaticallyNotifiesObserversOfLeftView { return FALSE; }

/**
 * Setter which configures the left view.
 * @param {UIView*} the new view.  
 */
- (void) setLeftView:(UIView*) leftView {
    // Remove if it exists
    if ( _leftView ) {
        [self updateCenterViewSizeGuides];
        [_leftView removeFromSuperview];
        
    }
    
    // Set
    [self willChangeValueForKey: @"leftView"];
    _leftView = leftView;
    [self didChangeValueForKey: @"leftView"];
    
    
    // Configure the left view
    if ( !_leftView )
        return;
    _leftView.themeClass = sIonThemeElementTitleBar_LeftView;
    [self addSubview: _leftView];
    [_leftView setGuidesWithLocalHoriz: _leftView.originGuideHoriz
                             localVert: _leftView.centerGuideVert
                            superHoriz: contentGroup.originExternalGuideHoriz
                          andSuperVert: contentGroup.centerExternalGuideVert];
    
   [self updateCenterViewSizeGuides];
}


/**
 * Sets the left view using an animation.
 * @param {UIView*} the new view.
 * @param {BOOL} the animation to use.  
 */
- (void) setLeftView:(UIView *)leftView animated:(BOOL) animated {
    // Run the set left animation an animation
    self.leftView = leftView;
}

#pragma mark Center View

/**
 * Switch notifications to manual
 */
+ (BOOL) automaticallyNotifiesObserversOfCenterView { return FALSE; }

/**
 * Setter which configures the left view.
 * @param {UIView*} the new view.  
 */
- (void) setCenterView:(UIView*) centerView {
    // Remove if it exists
    if ( _centerView )
        [_centerView removeFromSuperview];
    
    // Set
    [self willChangeValueForKey: @"centerView"];
    _centerView = centerView;
    [self didChangeValueForKey: @"centerView"];
    
    
    // Configure the left view
    if ( !_centerView || ![_centerView isKindOfClass: [UIView class]] )
        return;
    _centerView.themeClass = sIonThemeElementTitleBar_CenterView;
    [self addSubview: _centerView];
    
    [self updateCenterViewSizeGuides];
}

/**
 * updates the center view size guides.  
 */
- (void) updateCenterViewSizeGuides {
  IonGuideLine *rightViewGuide, *leftViewGuide;
    if ( !_centerView )
        return;
    
    _centerView.topSizeGuide = contentGroup.originExternalGuideVert;
    _centerView.bottomSizeGuide = contentGroup.sizeExternalGuideVert;

  rightViewGuide = _rightView ? _rightView.leftMargin :
    contentGroup.oneForthExternalGuideHoriz;
  
//   if rv
//    rvg = rv.lm
//    if !lv // No Left View Equalize
//      lvg = *&rvg;
//
//  if lv
//    lvg = lv.rm
//    if !rv // No Right View Equalize
//      rvg = *&lvg;
  

  
  leftViewGuide = _leftView ? _leftView.rightMargin :
    contentGroup.threeForthsExternalGuideHoriz;
    
    [_centerView setGuidesWithLocalHoriz: _centerView.centerGuideHoriz
                               localVert: _centerView.centerGuideVert
                              superHoriz: contentGroup.centerExternalGuideHoriz
                            andSuperVert: contentGroup.centerExternalGuideVert];
}

#pragma mark Right View
/**
 * Switch notifications to manual
 */
+ (BOOL) automaticallyNotifiesObserversOfRightView { return FALSE; }

/**
 * Setter which configures the right view.
 * @param {UIView*} the new view.  
 */
- (void) setRightView:(UIView *)rightView {
    // Remove if it exists
    if ( _rightView ) {
        [self updateCenterViewSizeGuides];
        [_rightView removeFromSuperview];
    }
    
    // Set
    [self willChangeValueForKey: @"rightView"];
    _rightView = rightView;
    [self didChangeValueForKey: @"rightView"];
    
    
    // Configure the left view
    if ( !_rightView )
        return;
    _rightView.themeClass = sIonThemeElementTitleBar_RightView;
    [self addSubview: _rightView];
    [_rightView setGuidesWithLocalHoriz: _rightView.sizeGuideHoriz
                              localVert: _rightView.centerGuideVert
                             superHoriz: contentGroup.sizeExternalGuideHoriz
                           andSuperVert: contentGroup.centerExternalGuideVert];
    [self updateCenterViewSizeGuides];
}

@end

@implementation IonTitleConfiguration

- (void) apply:(IonTitleBar *)titlebar {
    NSParameterAssert( [titlebar isKindOfClass: [IonTitleBar class]] );
    if ( ![titlebar isKindOfClass: [IonTitleBar class]] )
        return;
    
    titlebar.leftView = self.leftView;
    titlebar.centerView = self.centerView;
    titlebar.rightView = self.rightView;
}

@end
//
//  IonTitleBar.m
//  Ion
//
//  Created by Andrew Hurst on 8/23/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonTitleBar.h"
#import "UIView+IonGuideLine.h"
#import "IonGuideGroup.h"

@interface IonTitleBar (){
    IonGuideGroup* contentGroup;
    IonGuideLine* statusBarGuide;
    IonKeyValueObserver* statusFrameObserver;
}

@end

@implementation IonTitleBar
#pragma mark Constructors

/**
 * Default constructor.
 * @returns {instancetype}
 */
- (instancetype) init {
    self = [super init];
    if ( self )
        [self construct];
    return self;
}

/**
 * Frame Constructor.
 * @param {CGRect} the frame to construct with.
 * @returns {instancetype}
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
 * @returns {void}
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
 * @returns {void}
 */
- (void) setFrame:(CGRect) frame {
    
    [super setFrame: [self currentFrame]];
    [self updateContentGroupFrame];
}

/**
 * Gets a frame to match the current configuration.
 */
- (CGRect) currentFrame {
    return( CGRect){ [self.guideSet toPoint],
        (CGSize){ self.superview.frame.size.width, [self statusOffsetHeight] + self.contentHeight } } ;
}

/**
 * Updates the frame to match the current configuration.
 * @returns {void}
 */
- (void) updateFrame {
    [self setFrame: [self  currentFrame]];
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
}

/**
 * Updates the Guide groups frame.
 */
- (void) updateContentGroupFrame {
    
    contentGroup.frame = (CGRect){
        (CGPoint){ self.leftPadding.position, [self statusOffsetHeight] },
        (CGSize){ self.rightPadding.position - self.leftPadding.position , self.contentHeight }
    };
    NSLog(@"Val: %f", contentGroup.frame.size.width);
}

#pragma mark Responds to Status Bar

/**
 * Switched KVO to manual mode
 */
+ (BOOL) automaticallyNotifiesObserversOfRespondsToStatusBar { return FALSE; }

/**
 * The setter for responding to changes in the status bar.
 * @param {BOOL} the new state.
 * @returns {void}
 */
- (void) setRespondsToStatusBar:(BOOL) respondsToStatusBar {
    [self willChangeValueForKey: @"respondsToStatusBar"];
    _respondsToStatusBar = respondsToStatusBar;
    [self didChangeValueForKey: @"respondsToStatusBar"];
    
    if ( _respondsToStatusBar ) {
        // observe the status frame and update content according to changes
        statusFrameObserver = [IonKeyValueObserver observeObject: [IonApplication sharedApplication]
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
 * @returns {void}
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
 * @returns {void}
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
 * @returns {CGFloat}
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
 * @returns {void}
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
 * @returns {void}
 */
- (void) setLeftView:(UIView*) leftView {
    // Remove if it exists
    if ( _leftView ) {
    //    [self updateCenterViewSizeGuides];
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
    [_leftView setGuidesWithLocalVert: _leftView.centerGuideVert
                           localHoriz: _leftView.internalOriginGuideHoriz
                            superVert: contentGroup.centerGuideVert
                        andSuperHoriz: contentGroup.internalOriginGuideHoriz];
    
 //  [self updateCenterViewSizeGuides];
}


/**
 * Sets the left view using an animation.
 * @param {UIView*} the new view.
 * @param {BOOL} the animation to use.
 * @returns {void}
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
 * @returns {void}
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
    [_centerView setGuidesWithLocalVert: _centerView.centerGuideVert
                             localHoriz: _centerView.centerGuideHoriz
                              superVert: contentGroup.centerGuideVert
                          andSuperHoriz: contentGroup.centerGuideHoriz];
    
  //  [self updateCenterViewSizeGuides];
}

/**
 * updates the center view size guides.
 * @returns {void}
 */
- (void) updateCenterViewSizeGuides {
    if ( !_centerView )
        return;
    
    _centerView.topSizeGuide = contentGroup.internalOriginGuideVert;
    _centerView.bottomSizeGuide = contentGroup.sizeGuideVert;
    
    if ( _rightView )
        _centerView.rightSizeGuide = _rightView.leftMargin;
    else
        _centerView.rightSizeGuide = contentGroup.internalOriginGuideHoriz;
    
    if ( _leftView )
        _centerView.leftSizeGuide = _leftView.rightMargin;
    else
        _centerView.leftSizeGuide = contentGroup.sizeGuideHoriz;
}

#pragma mark Right View

/**
 * Switch notifications to manual
 */
+ (BOOL) automaticallyNotifiesObserversOfRightView { return FALSE; }

/**
 * Setter which configures the right view.
 * @param {UIView*} the new view.
 * @returns {void}
 */
- (void) setRightView:(UIView *)rightView {
    // Remove if it exists
    if ( _rightView ) {
       // [self updateCenterViewSizeGuides];
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
    [_rightView setGuidesWithLocalVert: _rightView.centerGuideVert
                            localHoriz: _rightView.sizeGuideHoriz
                             superVert: contentGroup.centerGuideVert
                         andSuperHoriz: contentGroup.sizeGuideHoriz];
   // [self updateCenterViewSizeGuides];
}

@end

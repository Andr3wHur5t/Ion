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
    if ( self )
       [self construct];
    return self;
}

/**
 * Constructs the view
 * @returns {void}
 */
- (void) construct {
    self.themeConfiguration.themeElement = @"titleBar";
    [self constructContentGuideGroup];
}

#pragma mark Coniguration

/**
 * Configures the guide group.
 * @returns {void}
 */
- (void) constructContentGuideGroup {
    contentGroup = [[IonGuideGroup alloc] init];
    
}

#pragma mark Frame
/**
 * Responds to frame changes.
 * @param {CGRect} the new frame
 * @returns {void}
 */
- (void) setFrame:(CGRect) frame {
    [super setFrame: frame];
    
    // Update the Content Group Frame
    contentGroup.frame = (CGRect){
        (CGPoint){ self.autoMarginGuideHoriz.position, [UIApplication sharedApplication].statusBarFrame.size.height },
        (CGSize){ self.sizeGuideHoriz.position - (self.autoMarginGuideHoriz.position * 2), 50 }
    };
    
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
    // Remove if it exsists
    if ( _leftView )
        [_leftView removeFromSuperview];
    
    // Set
    [self willChangeValueForKey: @"leftView"];
    _leftView = leftView;
    [self didChangeValueForKey: @"leftView"];
    
    
    // Configure the left view
    if ( !_leftView )
        return;
    _leftView.themeConfiguration.themeClass = @"leftView";
    [self addSubview: _leftView];
    [_leftView setGuidesWithLocalVert: _leftView.centerGuideVert
                           localHoriz: _leftView.internalOriginGuideHoriz
                            superVert: contentGroup.centerGuideVert
                        andSuperHoriz: contentGroup.internalOriginGuideHoriz];
    return;
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
    // Remove if it exsists
    if ( _centerView )
        [_centerView removeFromSuperview];
    
    // Set
    [self willChangeValueForKey: @"centerView"];
    _centerView = centerView;
    [self didChangeValueForKey: @"centerView"];
    
    
    // Configure the left view
    if ( !_centerView || ![_centerView isKindOfClass: [UIView class]] )
        return;
    _centerView.themeConfiguration.themeClass = @"centerView";
    [self addSubview: _centerView];
    [_centerView setGuidesWithLocalVert: _centerView.centerGuideVert
                             localHoriz: _centerView.centerGuideHoriz
                              superVert: contentGroup.centerGuideVert
                          andSuperHoriz: contentGroup.centerGuideHoriz];
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
    // Remove if it exsists
    if ( _rightView )
        [_rightView removeFromSuperview];
    
    // Set
    [self willChangeValueForKey: @"rightView"];
    _rightView = rightView;
    [self didChangeValueForKey: @"rightView"];
    
    
    // Configure the left view
    if ( !_rightView )
        return;
    _rightView.themeConfiguration.themeClass = @"rightView";
    [self addSubview: _rightView];
    [_rightView setGuidesWithLocalVert: _rightView.centerGuideVert
                            localHoriz: _rightView.sizeGuideHoriz
                             superVert: contentGroup.centerGuideVert
                         andSuperHoriz: contentGroup.sizeGuideHoriz];
}

@end

//
//  IonScrollView.h
//  Ion
//
//  Created by Andrew Hurst on 9/21/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IonScrollAction.h"

@class IonGuideLine;

#pragma mark Style Keys
static NSString *sIonScrollStyle_Name =                                 @"scrollView";
static NSString *sIonScrollStyle_UsesScrollToTopGesture =               @"usesScrollToTopGesture";
static NSString *sIonScrollStyle_KeyboardDismissMode =                  @"keyboardDismissMode";

static NSString *sIonScrollStyle_ContentInset =                         @"contentInset";
static NSString *sIonScrollStyle_BouncesAtEdge =                        @"bouncesAtEdge";
static NSString *sIonScrollStyle_AlwaysBouncesVertical =                @"alwaysBouncesVertical";
static NSString *sIonScrollStyle_AlwaysBouncesHorizontal =              @"alwaysBouncesHorizontal";
static NSString *sIonScrollStyle_DecelerationRate =                     @"decelerationRate";

static NSString *sIonScrollStyle_IndicatorStyle =                       @"indicatorStyle";
static NSString *sIonScrollStyle_ShowsHorizontalIndicator =             @"showsHorizontalIndicator";
static NSString *sIonScrollStyle_ShowsVerticalIndicator =               @"showsVerticalIndicator";
static NSString *sIonScrollStyle_IndicatorInsets =                      @"indicatorInsets";

static NSString *sIonScrollStyle_MinimumZoomScale =                     @"minimumZoomScale";
static NSString *sIonScrollStyle_MaximumZoomScale =                     @"maximumZoomScale";
static NSString *sIonScrollStyle_ZoomBounces =                          @"zoomBounces";

/**
 * An Ion Theme, and guide line compatible scrollview which provides action based event functionality.
 */
@interface IonScrollView : UIScrollView


#pragma mark Content Offset
/**
 * A guide line which represents the horizontal position of the content offset of this scroll view.
 */
@property (strong, nonatomic, readonly) IonGuideLine *contentOffsetHoriz;

/**
 * A guide line which represents the vertical position of the content offset of this scroll view.
 */
@property (strong, nonatomic, readonly) IonGuideLine *contentOffsetVert;

#pragma mark Content Size
/**
 * Sets the content size guides with the inputted horizontal, and vertical guides.
 * @param horiz - the guide which describes the horizontal content size.
 * @param vert - the guide which describes the vertical content size.
 */
- (void) setContentSizeHoriz:(IonGuideLine *)horiz andVert:(IonGuideLine *)vert;

/**
 * A guide which describes the horizontal content size.
 */
@property (weak, nonatomic, readwrite) IonGuideLine *contentSizeHoriz;

/**
 * A guide which describes the vertical content size.
 */
@property (weak, nonatomic, readwrite) IonGuideLine *contentSizeVert;

#pragma mark Action Management
/**
 * Adds an action to the scrollview.
 * @param action - the action to add.
 */
- (void) addAction:(IonScrollAction *)action;

/**
 * Removes all actions matching the inputted action.
 * @param action - the action to remove.
 */
- (void) removeAction:(IonScrollAction *)action;

/**
 * Removes all actions.
 */
- (void) removeAllActions;

@end

@interface UIScrollView (ContentSizeGuides)
/**
 * Guide which represents the current height of the content offset.
 */
@property (strong, nonatomic, readonly) IonGuideLine *currentContentHeightGuide;

/**
 * Guide which represents the current width of the content offset.
 */
@property (strong, nonatomic, readonly) IonGuideLine *currentContentWidthGuide;

@end

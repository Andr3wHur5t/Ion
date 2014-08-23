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

static NSString* sIonGuideLine_AutoMargin_Vert =        @"IonGuideLine_AutoMargin_Vert";
static NSString* sIonGuideLine_AutoMargin_Horiz =       @"IonGuideLine_AutoMargin_Horiz";

static NSString* sIonGuideLine_StyleMargin_Vert =       @"IonGuideLine_StyleMargin_Vert";
static NSString* sIonGuideLine_StyleMargin_Horiz =      @"IonGuideLine_StyleMargin_Horiz";

@interface IonView () {
    CGSize _autoMargin;
}

@end

@implementation IonView
#pragma mark Subview Management

/**
 * Performs the block with each IonView child as a parameter.
 * @param { void(^)( IonView* child) }
 * @returns {void}
 */
- (void) forEachIonViewChildPerformBlock: (void(^)( IonView* child )) actionBlock {
    if ( !actionBlock )
        return;
    for ( IonView* child in self.subviews )
        actionBlock( child );
}


/**
 * Adds as a subview, and sets its' style.
 * @param {UIView*} the view to add.
 * @returns {void}
 */
- (void) addSubview:(UIView*) view {
    [super addSubview: view];
    if ( !view )
        return;
    [view setParentStyle: self.themeConfiguration.currentStyle ];
}

#pragma mark Style Application

/**
 * Applies the style to the view.
 * @param {IonStyle} the style to be applied.
 * @returns {void}
 */
- (void) applyStyle:(IonStyle*) style {
    
    CGSize styleMargin;
    NSParameterAssert( style && [style isKindOfClass: [IonStyle class]] );
    if ( !style || ![style isKindOfClass: [IonStyle class]] )
        return;
    
    // Get the style margin
    styleMargin = [style.configuration sizeForKey: sIonStyle_IonView_StyleMargin];
    if ( CGSizeEqualToSize( styleMargin, CGSizeUndefined) )
        styleMargin = CGSizeZero;
    self.styleMargin = styleMargin;
}

#pragma mark Auto Margin

/**
 * Sets the KVO dependents of the auto margin.
 * @returns {NSSet*} the set
 */
+ (NSSet*) keyPathsForValuesAffectingAutoMargin {
    return [NSSet setWithObjects: @"styleMargin", @"layer.cornerRadius", nil];
}

/**
 * Gets the auto margin value.
 * @returns {CGFloat}
 */
- (CGSize) autoMargin {
    _autoMargin.width = MAX( _styleMargin.width, self.layer.cornerRadius );
    _autoMargin.height = MAX( _styleMargin.height, self.layer.cornerRadius );
    return _autoMargin;
}


#pragma mark Auto Margin Guide Line

/**
 * Vertical Auto Margin Guide Line
 */
- (IonGuideLine*) autoMarginGuideVety {
    IonGuideLine* obj = [self.cachedGuideLines objectForKey: sIonGuideLine_AutoMargin_Vert];
    if ( !obj ) {
         obj = [IonGuideLine guideFromViewAutoMargin: self
                                           usingMode: IonGuideLineFrameMode_Vertical];
        [self.cachedGuideLines setObject: obj forKey: sIonGuideLine_AutoMargin_Vert];
    }
    return obj;
}

/**
 * Horizontal Auto Margin Guide Line
 */
- (IonGuideLine*) autoMarginGuideHoriz {
    IonGuideLine* obj = [self.cachedGuideLines objectForKey: sIonGuideLine_AutoMargin_Horiz];
    if ( !obj ) {
        obj = [IonGuideLine guideFromViewAutoMargin: self
                                          usingMode: IonGuideLineFrameMode_Horizontal];
        [self.cachedGuideLines setObject: obj forKey: sIonGuideLine_AutoMargin_Horiz];
    }
    return obj;
}

#pragma mark Style Margin Guide Line

/**
 * Vertical Style Margin Guide Line
 */
- (IonGuideLine*) styleMarginGuideVert {
    IonGuideLine* obj = [self.cachedGuideLines objectForKey: sIonGuideLine_StyleMargin_Vert];
    if ( !obj ) {
        obj = [IonGuideLine guideFromViewStyleMargin: self
                                           usingMode: IonGuideLineFrameMode_Vertical];
        [self.cachedGuideLines setObject: obj forKey: sIonGuideLine_StyleMargin_Vert];
    }
    return obj;
}

/**
 * Horizontal Style Margin Guide Line
 */
- (IonGuideLine*) styleMarginGuideHoriz {
    IonGuideLine* obj = [self.cachedGuideLines objectForKey: sIonGuideLine_StyleMargin_Horiz];
    if ( !obj ) {
        obj = [IonGuideLine guideFromViewStyleMargin: self
                                           usingMode: IonGuideLineFrameMode_Horizontal];
        [self.cachedGuideLines setObject: obj forKey: sIonGuideLine_StyleMargin_Horiz];
    }
    return obj;
}

@end

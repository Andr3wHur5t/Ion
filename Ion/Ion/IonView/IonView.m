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
#pragma mark Construction
/**
 * Default constructor
 * @returns {instancetype}
 */
- (instancetype) init {
    self = [super init];
    if ( self )
        [self construct];
    return self;
}

/**
 * Default framed constructor.
 * @param frame - the frame to construct with.
 * @returns {instancetype}
 */
- (instancetype) initWithFrame:(CGRect) frame {
    self = [super initWithFrame: frame];
    if ( self )
        [self construct];
    return self;
}

/**
 * Default coded constructor.
 * @param aDecoder - the coder to decode from.
 * @returns {instancetype}
 */
- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder: aDecoder];
    if ( self )
        [self construct];
    return self;
}

/**
 * Standard constructor method.
 */
- (void) construct {
    // Subclass all construction code here.
}
#pragma mark Subview Management
/**
 * Performs the block with each IonView child as a parameter.
 * @param { void(^)( IonView* child) }
 
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
 
 */
- (void) applyStyle:(IonStyle*) style {
    [super applyStyle: style];
}
@end

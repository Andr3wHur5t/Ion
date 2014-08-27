//
//  UIView+IonDefaultGuides.m
//  Ion
//
//  Created by Andrew Hurst on 8/23/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "UIView+IonDefaultGuides.h"
#import "UIView+IonGuideLine.h"
#import "IonGuideLine+DefaultConstructors.h"
#import "UIView+IonExternalGuides.h"

/**
 * Keys
 */
static NSString* sIonGuideLine_InternialOrigin_Vert =   @"IonGuideLine_InternialOrigin_Vert";
static NSString* sIonGuideLine_InternialOrigin_Horiz =  @"IonGuideLine_InternialOrigin_Horiz";

static NSString* sIonGuideLine_TwoThirds_Vert =         @"IonGuideLine_TwoThirds_Vert";
static NSString* sIonGuideLine_TwoThirds_Horiz =        @"IonGuideLine_TwoThirds_Horiz";

static NSString* sIonGuideLine_Center_Vert =            @"IonGuideLine_Center_Vert";
static NSString* sIonGuideLine_Center_Horiz =           @"IonGuideLine_Center_Horiz";

static NSString* sIonGuideLine_OneThird_Vert =          @"IonGuideLine_OneThird_Vert";
static NSString* sIonGuideLine_OneThird_Horiz =         @"IonGuideLine_OneThird_Horiz";

static NSString* sIonGuideLine_Size_Vert =              @"IonGuideLine_Size_Vert";
static NSString* sIonGuideLine_Size_Horiz =             @"IonGuideLine_Size_Horiz";

static NSString* sIonGuideLine_CornerRadius_Vert =      @"IonGuideLine_CornerRadius_Vert";
static NSString* sIonGuideLine_CornerRadius_Horiz =     @"IonGuideLine_CornerRadius_Horiz";

static NSString* sIonGuideLine_LeftPadding =            @"sIonGuideLine_LeftPadding";
static NSString* sIonGuideLine_RightPadding =           @"sIonGuideLine_RightPadding";
static NSString* sIonGuideLine_TopPadding =             @"sIonGuideLine_TopPadding";
static NSString* sIonGuideLine_BottomPadding =          @"sIonGuideLine_BottomPadding";

static NSString* sIonGuideLine_LeftAutoPadding =        @"sIonGuideLine_LeftAutoPadding";
static NSString* sIonGuideLine_RightAutoPadding =       @"sIonGuideLine_RightAutoPadding";
static NSString* sIonGuideLine_TopAutoPadding =         @"sIonGuideLine_TopAutoPadding";
static NSString* sIonGuideLine_BottomAutoPadding =      @"sIonGuideLine_BottomAutoPadding";

static NSString* sIonGuideLine_MarginWidth =            @"IonGuideLine_MarginWidth";
static NSString* sIonGuideLine_MarginHeight =           @"IonGuideLine_MarginHeight";

static NSString* sIonGuideLine_LeftMargin =             @"IonGuideLine_LeftMargin";
static NSString* sIonGuideLine_RightMargin =            @"IonGuideLine_RightMargin";
static NSString* sIonGuideLine_TopMargin =              @"IonGuideLine_TopMargin";
static NSString* sIonGuideLine_BottomMargin =           @"IonGuideLine_BottomtMargin";

@implementation UIView (IonDefaultGuides)

#pragma mark Corrner Radius

/**
 * Vertical Corner Radius Margin Guide Line
 */
- (IonGuideLine*) cornerRadiusMarginGuideVert {
    IonGuideLine* obj = [self.cachedGuideLines objectForKey: sIonGuideLine_CornerRadius_Vert];
    if ( !obj ) {
        obj = [IonGuideLine guideFromViewCornerRadius: self
                                            usingMode: IonGuideLineFrameMode_Vertical];
        [self.cachedGuideLines setObject: obj forKey: sIonGuideLine_CornerRadius_Vert];
    }
    return obj;
}

/**
 * Horizontal Corner Radius Margin Guide Line
 */
- (IonGuideLine*) cornerRadiusMarginGuideHoriz {
    IonGuideLine* obj = [self.cachedGuideLines objectForKey: sIonGuideLine_CornerRadius_Horiz];
    if ( !obj ) {
        obj = [IonGuideLine guideFromViewCornerRadius: self
                                            usingMode: IonGuideLineFrameMode_Horizontal];
        [self.cachedGuideLines setObject: obj forKey: sIonGuideLine_CornerRadius_Horiz];
    }
    return obj;
}

#pragma mark Internal Origin

/**
 * Vertical Internal Origin Guide Line
 */
- (IonGuideLine*) internalOriginGuideVert {
    IonGuideLine* obj = [self.cachedGuideLines objectForKey: sIonGuideLine_InternialOrigin_Vert];
    if ( !obj ) {
        obj = [IonGuideLine guideFromViewFrameSize: self
                                       usingAmount: 0.0f
                                           andMode: IonGuideLineFrameMode_Vertical];
        [self.cachedGuideLines setObject: obj forKey: sIonGuideLine_InternialOrigin_Vert];
    }
    return obj;
}

/**
 * Horizontal Internal Origin Guide Line
 */
- (IonGuideLine*) internalOriginGuideHoriz {
    IonGuideLine* obj = [self.cachedGuideLines objectForKey: sIonGuideLine_InternialOrigin_Horiz];
    if ( !obj ) {
        obj = [IonGuideLine guideFromViewFrameSize: self
                                       usingAmount: 0.0f
                                           andMode: IonGuideLineFrameMode_Horizontal];
        [self.cachedGuideLines setObject: obj forKey: sIonGuideLine_InternialOrigin_Horiz];
    }
    return obj;
}

#pragma mark One Third

/**
 * Vertical One Third Guide Line
 */
- (IonGuideLine*) oneThirdGuideVert {
    IonGuideLine* obj = [self.cachedGuideLines objectForKey: sIonGuideLine_OneThird_Vert];
    if ( !obj ) {
        obj = [IonGuideLine guideFromViewFrameSize: self
                                       usingAmount: 1.0f/3.0f
                                           andMode: IonGuideLineFrameMode_Vertical];
    [self.cachedGuideLines setObject: obj forKey: sIonGuideLine_OneThird_Vert];
    }
    return obj;
}

/**
 * Horizontal One Third Guide Line
 */
- (IonGuideLine*) oneThirdGuideHoriz {
    IonGuideLine* obj = [self.cachedGuideLines objectForKey: sIonGuideLine_OneThird_Horiz];
    if ( !obj ) {
        obj = [IonGuideLine guideFromViewFrameSize: self
                                       usingAmount: 1.0f/3.0f
                                           andMode: IonGuideLineFrameMode_Horizontal];
        [self.cachedGuideLines setObject: obj forKey: sIonGuideLine_OneThird_Horiz];
    }
    return obj;
}

#pragma mark Center

/**
 * Vertical Center Guide Line
 */
- (IonGuideLine*) centerGuideVert {
    IonGuideLine* obj = [self.cachedGuideLines objectForKey: sIonGuideLine_Center_Vert];
    if ( !obj ) {
        obj = [IonGuideLine guideFromViewFrameSize: self
                                       usingAmount: 1.0f/2.0f
                                           andMode: IonGuideLineFrameMode_Vertical];
        [self.cachedGuideLines setObject: obj forKey: sIonGuideLine_Center_Vert];
    }
    return obj;
}

/**
 * Horizontal Center Guide Line
 */
- (IonGuideLine*) centerGuideHoriz {
    IonGuideLine* obj = [self.cachedGuideLines objectForKey: sIonGuideLine_Center_Horiz];
    if ( !obj ) {
        obj = [IonGuideLine guideFromViewFrameSize: self
                                       usingAmount: 1.0f/2.0f
                                           andMode: IonGuideLineFrameMode_Horizontal];
        [self.cachedGuideLines setObject: obj forKey: sIonGuideLine_Center_Horiz];
    }
    return obj;
}

#pragma mark Two Thirds

/**
 * Vertical Two Thirds Guide Line
 */
- (IonGuideLine*) twoThirdsGuideVert {
    IonGuideLine* obj = [self.cachedGuideLines objectForKey: sIonGuideLine_TwoThirds_Vert];
    if ( !obj ) {
        obj = [IonGuideLine guideFromViewFrameSize: self
                                       usingAmount: (1.0f/3.0f) * 2.0f
                                           andMode: IonGuideLineFrameMode_Vertical];
        [self.cachedGuideLines setObject: obj forKey: sIonGuideLine_TwoThirds_Vert];
    }
    return obj;
}

/**
 * Horizontal Two Thirds Guide Line
 */
- (IonGuideLine*) twoThirdsGuideHoriz {
    IonGuideLine* obj = [self.cachedGuideLines objectForKey: sIonGuideLine_TwoThirds_Horiz];
    if ( !obj ) {
        obj = [IonGuideLine guideFromViewFrameSize: self
                                       usingAmount: (1.0f/3.0f) * 2.0f
                                           andMode: IonGuideLineFrameMode_Horizontal];
        [self.cachedGuideLines setObject: obj forKey: sIonGuideLine_TwoThirds_Horiz];
    }
    return obj;
}

#pragma mark Full Size

/**
 * Vertical Size Guide Line
 */
- (IonGuideLine*) sizeGuideVert {
    IonGuideLine* obj = [self.cachedGuideLines objectForKey: sIonGuideLine_Size_Vert];
    if ( !obj ) {
        obj = [IonGuideLine guideFromViewFrameSize: self
                                       usingAmount: 1.0f
                                           andMode: IonGuideLineFrameMode_Vertical];
        [self.cachedGuideLines setObject: obj forKey: sIonGuideLine_Size_Vert];
    }
    return obj;
}

/**
 * Horizontal Internal Orgin Guide Line
 */
- (IonGuideLine*) sizeGuideHoriz {
    IonGuideLine* obj = [self.cachedGuideLines objectForKey: sIonGuideLine_Size_Horiz];
    if ( !obj ) {
        obj = [IonGuideLine guideFromViewFrameSize: self
                                       usingAmount: 1.0f
                                           andMode: IonGuideLineFrameMode_Horizontal];
        [self.cachedGuideLines setObject: obj forKey: sIonGuideLine_Size_Horiz];
    }
    return obj;
}

#pragma mark Padding

/**
 * Left Padding Guide Line
 */
- (IonGuideLine*) leftPadding {
    IonGuideLine* obj = [self.cachedGuideLines objectForKey: sIonGuideLine_LeftPadding];
    if ( !obj ) {
        obj = [IonGuideLine guideFromViewStyleMargin: self
                                           usingMode: IonGuideLineFrameMode_Horizontal];
        
        [self.cachedGuideLines setObject: obj forKey: sIonGuideLine_LeftPadding];
    }
    return obj;
}

/**
 * Right Padding Guide Line
 */
- (IonGuideLine*) rightPadding {
    IonGuideLine* obj = [self.cachedGuideLines objectForKey: sIonGuideLine_RightPadding];
    if ( !obj ) {
        obj = [IonGuideLine guideWithGuide: self.sizeGuideHoriz
                                   modType: IonValueModType_Subtract
                            andSecondGuide: self.leftPadding];
        [self.cachedGuideLines setObject: obj forKey: sIonGuideLine_RightPadding];
    }
    return obj;
}

/**
 * Top Padding Guide Line
 */
- (IonGuideLine*) topPadding {
    IonGuideLine* obj = [self.cachedGuideLines objectForKey: sIonGuideLine_TopPadding];
    if ( !obj ) {
        obj = [IonGuideLine guideFromViewStyleMargin: self
                                           usingMode: IonGuideLineFrameMode_Vertical];
        [self.cachedGuideLines setObject: obj forKey: sIonGuideLine_TopPadding];
    }
    return obj;
}

/**
 * Bottom Padding Guide Line
 */
- (IonGuideLine*) bottomPadding {
    IonGuideLine* obj = [self.cachedGuideLines objectForKey: sIonGuideLine_BottomPadding];
    if ( !obj ) {
        obj = [IonGuideLine guideWithGuide: self.sizeGuideVert
                                   modType: IonValueModType_Subtract
                            andSecondGuide: self.topPadding];
        [self.cachedGuideLines setObject: obj forKey: sIonGuideLine_BottomPadding];
    }
    return obj;
}

#pragma mark Auto Padding


/**
 * Left Padding Guide Line
 */
- (IonGuideLine*) leftAutoPadding {
    IonGuideLine* obj = [self.cachedGuideLines objectForKey: sIonGuideLine_LeftAutoPadding];
    if ( !obj ) {
        obj = [IonGuideLine guideFromViewAutoMargin: self
                                          usingMode: IonGuideLineFrameMode_Horizontal];
        
        [self.cachedGuideLines setObject: obj forKey: sIonGuideLine_LeftAutoPadding];
    }
    return obj;
}

/**
 * Right Padding Guide Line
 */
- (IonGuideLine*) rightAutoPadding {
    IonGuideLine* obj = [self.cachedGuideLines objectForKey: sIonGuideLine_RightAutoPadding];
    if ( !obj ) {
        obj = [IonGuideLine guideWithGuide: self.sizeGuideHoriz
                                   modType: IonValueModType_Subtract
                            andSecondGuide: self.leftAutoPadding];
        [self.cachedGuideLines setObject: obj forKey: sIonGuideLine_RightAutoPadding];
    }
    return obj;
}

/**
 * Top Padding Guide Line
 */
- (IonGuideLine*) topAutoPadding {
    IonGuideLine* obj = [self.cachedGuideLines objectForKey: sIonGuideLine_TopAutoPadding];
    if ( !obj ) {
        obj = [IonGuideLine guideFromViewAutoMargin: self
                                           usingMode: IonGuideLineFrameMode_Vertical];
        [self.cachedGuideLines setObject: obj forKey: sIonGuideLine_TopAutoPadding];
    }
    return obj;
}

/**
 * Bottom Padding Guide Line
 */
- (IonGuideLine*) bottomAutoPadding {
    IonGuideLine* obj = [self.cachedGuideLines objectForKey: sIonGuideLine_BottomAutoPadding];
    if ( !obj ) {
        obj = [IonGuideLine guideWithGuide: self.sizeGuideVert
                                   modType: IonValueModType_Subtract
                            andSecondGuide: self.topAutoPadding];
        [self.cachedGuideLines setObject: obj forKey: sIonGuideLine_BottomAutoPadding];
    }
    return obj;
}


#pragma mark Margins

/**
 * Gets the left margin width
 */
- (IonGuideLine*) marginWidth {
    IonGuideLine* obj = [self.cachedGuideLines objectForKey: sIonGuideLine_MarginWidth];
    if ( !obj ) {
        obj = [IonGuideLine guideFromViewStyleMargin: self usingMode: IonGuideLineFrameMode_Horizontal];
        
        
        [self.cachedGuideLines setObject: obj forKey: sIonGuideLine_MarginWidth];
    }
    return obj;
}

/**
 * Gets the left margin height
 */
- (IonGuideLine*) marginHeight {
    IonGuideLine* obj = [self.cachedGuideLines objectForKey: sIonGuideLine_MarginHeight];
    if ( !obj ) {
        obj = [IonGuideLine guideFromViewStyleMargin: self usingMode: IonGuideLineFrameMode_Vertical];
        [self.cachedGuideLines setObject: obj forKey: sIonGuideLine_MarginHeight];
    }
    return obj;
}

/**
 * Left Margin Guide Line
 */
- (IonGuideLine*) leftMargin {
    IonGuideLine* obj = [self.cachedGuideLines objectForKey: sIonGuideLine_LeftMargin];
    if ( !obj ) {
        obj = [IonGuideLine guideWithGuide: self.originGuideHorizExternal
                                   modType: IonValueModType_Subtract
                            andSecondGuide: [self marginWidth]];
        
        
        [self.cachedGuideLines setObject: obj forKey: sIonGuideLine_LeftMargin];
    }
    return obj;
}

/**
 * Right Margin Guide Line
 */
- (IonGuideLine*) rightMargin {
    IonGuideLine* obj = [self.cachedGuideLines objectForKey: sIonGuideLine_RightMargin];
    if ( !obj ) {
        obj = [IonGuideLine guideWithGuide: self.sizeGuideHorizExternal
                                   modType: IonValueModType_Add
                            andSecondGuide: [self marginWidth]];
        [self.cachedGuideLines setObject: obj forKey: sIonGuideLine_RightMargin];
    }
    return obj;
}

/**
 * Top Margin Guide Line
 */
- (IonGuideLine*) topMargin {
    IonGuideLine* obj = [self.cachedGuideLines objectForKey: sIonGuideLine_TopMargin];
    if ( !obj ) {
        obj = [IonGuideLine guideWithGuide: self.originGuideVertExternal
                                   modType: IonValueModType_Subtract
                            andSecondGuide: [self marginHeight]];
        
        [self.cachedGuideLines setObject: obj forKey: sIonGuideLine_TopMargin];
    }
    return obj;
}

/**
 * Top Margin Guide Line
 */
- (IonGuideLine*) bottomMargin {
    IonGuideLine* obj = [self.cachedGuideLines objectForKey: sIonGuideLine_BottomMargin];
    if ( !obj ) {
        obj = [IonGuideLine guideWithGuide: self.sizeGuideVertExternal
                                   modType: IonValueModType_Add
                            andSecondGuide: [self marginHeight]];
        [self.cachedGuideLines setObject: obj forKey: sIonGuideLine_BottomMargin];
    }
    return obj;
}

@end

//
//  UIView+IonDefaultGuides.m
//  Ion
//
//  Created by Andrew Hurst on 8/23/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "UIView+IonGuideGroup.h"
#import "UIView+IonGuideLine.h"
#import "IonGuideLine+DefaultConstructors.h"

#import <IonData/IonData.h>

/**
 * Keys
 */
static NSString* sIonGuideLine_GuideGroupKey =          @"GuideGroup";

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

@implementation UIView (IonGuideGroup)
/** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = == = =
 *                                                  Guide Group
 *  = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = */

/**
 * Gets or creates the guide group object.
 * @returns {IonGuideGroup*} the group object.
 */
- (IonGuideGroup*) guideGroup {
    IonGuideGroup* group = [self.categoryVariables objectForKey: sIonGuideLine_GuideGroupKey];
    if ( !group ) {
        group = [[IonGuideGroup alloc] initWithView: self];
        [self.categoryVariables setObject: group forKey: sIonGuideLine_GuideGroupKey];
    }
    return group;
}

/* = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
 *                              Internal Guides
 * = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = */

#pragma mark Origin
/**
 * Horizontal Origin Guide Line
 */
- (IonGuideLine*) originGuideHoriz {
    return self.guideGroup.originGuideHoriz;
}

/**
 * Vertical Origin Guide Line
 */
- (IonGuideLine*) originGuideVert{
    return self.guideGroup.originGuideVert;
}

#pragma mark One Forth
/**
 * Horizontal One Forth Guide Line
 */
- (IonGuideLine*) oneForthGuideHoriz {
    return self.guideGroup.oneForthGuideHoriz;
}

/**
 * Vertical One Forth Guide Line
 */
- (IonGuideLine*) oneForthGuideVert {
    return self.guideGroup.oneForthGuideVert;
}


#pragma mark One Third
/**
 * Horizontal One Third Guide Line
 */
- (IonGuideLine*) oneThirdGuideHoriz {
    return self.guideGroup.oneThirdGuideHoriz;
}


/**
 * Vertical One Third Guide Line
 */
- (IonGuideLine*) oneThirdGuideVert {
    return self.guideGroup.originGuideVert;
}


#pragma mark Center
/**
 * Horizontal Center Guide Line
 */
- (IonGuideLine*) centerGuideHoriz {
    return self.guideGroup.centerGuideHoriz;
}


/**
 * Vertical Center Guide Line
 */
- (IonGuideLine*) centerGuideVert {
    return self.guideGroup.centerGuideVert;
}

#pragma mark Two Thirds
/**
 * Horizontal Two Thirds Guide Line
 */
- (IonGuideLine*) twoThirdsGuideHoriz {
    return self.guideGroup.twoThirdsGuideHoriz;
}


/**
 * Vertical Two Thirds Guide Line
 */
- (IonGuideLine*) twoThirdsGuideVert {
    return self.guideGroup.twoThirdsGuideVert;
}

#pragma mark Three Forths
/**
 * Horizontal Three Forths Guide Line
 */
- (IonGuideLine*) threeForthsGuideHoriz {
    return self.guideGroup.threeForthsGuideHoriz;
}

/**
 * Vertical Three Forths Guide Line
 */
- (IonGuideLine*) threeForthsGuideVert {
    return self.guideGroup.threeForthsGuideVert;
}


#pragma mark Full Size
/**
 * Horizontal  Size Guide Line
 */
- (IonGuideLine*) sizeGuideHoriz {
    return self.guideGroup.sizeGuideHoriz;
}


/**
 * Vertical Size Guide Line
 */
- (IonGuideLine*) sizeGuideVert {
    return self.guideGroup.sizeGuideVert;
}



/* = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
 *                              External Guides
 * = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = */

#pragma mark Origin External
/**
 * Horizontal External Origin Guide Line
 */
- (IonGuideLine*) originExternalGuideHoriz {
    return self.guideGroup.originExternalGuideHoriz;
}

/**
 * Vertical External Origin Guide Line
 */
- (IonGuideLine*) originExternalGuideVert {
    return self.guideGroup.originExternalGuideVert;
}

#pragma mark One Forth External
/**
 * Horizontal One Forth Guide Line
 */
- (IonGuideLine*) oneForthExternalGuideHoriz {
    return self.guideGroup.oneForthExternalGuideHoriz;
}


/**
 * Vertical One Forth Guide Line
 */
- (IonGuideLine*) oneForthExternalGuideVert {
    return self.guideGroup.oneForthExternalGuideVert;
}



#pragma mark One Third External
/**
 * Horizontal External One Third Guide Line
 */
- (IonGuideLine*) oneThirdExternalGuideHoriz {
    return self.guideGroup.oneThirdExternalGuideHoriz;
}

/**
 * Vertical External One Third Guide Line
 */
- (IonGuideLine*) oneThirdExternalGuideVert {
    return self.guideGroup.oneThirdExternalGuideVert;
}

#pragma mark Center External
/**
 * Horizontal External Center Guide Line
 */
- (IonGuideLine*) centerExternalGuideHoriz {
    return self.guideGroup.centerExternalGuideHoriz;
}

/**
 * Vertical External Center Guide Line
 */
- (IonGuideLine*) centerExternalGuideVert {
    return self.guideGroup.centerExternalGuideVert;
}

#pragma mark Two Thirds External
/**
 * Horizontal External Two Thirds Guide Line
 */
- (IonGuideLine*) twoThirdsExternalGuideHoriz {
    return self.guideGroup.twoThirdsExternalGuideHoriz;
}

/**
 * Vertical External Two Thirds Guide Line
 */
- (IonGuideLine*) twoThirdsExternalGuideVert {
    return self.guideGroup.twoThirdsExternalGuideVert;
}

#pragma mark Three Forths External
/**
 * Horizontal Three Forths Guide Line
 */
- (IonGuideLine*) threeForthsExternalGuideHoriz {
    return self.guideGroup.threeForthsExternalGuideHoriz;
}

/**
 * Vertical Three Forths Guide Line
 */
- (IonGuideLine*) threeForthsExternalGuideVert {
    return self.guideGroup.threeForthsExternalGuideVert;
}

#pragma mark Size External
/**
 * Horizontal External Size Guide Line
 */
- (IonGuideLine*) sizeExternalGuideHoriz {
    return self.guideGroup.sizeExternalGuideHoriz;
}


/**
 * Vertical External Size Guide Line
 */
- (IonGuideLine*) sizeExternalGuideVert {
    return self.guideGroup.sizeExternalGuideVert;
}



/** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = == = =
 *                                              UIView Spcific Guides
 *  = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = */

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

#pragma mark Padding

/**
 * Left Padding Guide Line
 */
- (IonGuideLine*) leftPadding {
    IonGuideLine* obj = [self.cachedGuideLines objectForKey: sIonGuideLine_LeftPadding];
    if ( !obj ) {
        obj = [IonGuideLine guideFromViewStylePadding: self
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
        obj = [IonGuideLine guideFromViewStylePadding: self
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
        
        obj.debugName = sIonGuideLine_BottomPadding;
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
        
        obj.debugName = sIonGuideLine_LeftAutoPadding;
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
        
        obj.debugName = sIonGuideLine_RightAutoPadding;
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
        
        obj.debugName = sIonGuideLine_TopAutoPadding;
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
        
        obj.debugName = sIonGuideLine_BottomAutoPadding;
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
        obj.debugName = sIonGuideLine_MarginWidth;
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
        obj.debugName = sIonGuideLine_MarginHeight;
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
        obj = [IonGuideLine guideWithGuide: self.originExternalGuideHoriz
                                   modType: IonValueModType_Subtract
                            andSecondGuide: self.marginWidth];
        obj.debugName = sIonGuideLine_LeftMargin;
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
        obj = [IonGuideLine guideWithGuide: self.marginWidth
                                   modType: IonValueModType_Add
                            andSecondGuide: self.sizeExternalGuideHoriz];
        
        obj.debugName = sIonGuideLine_RightMargin;
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
        obj = [IonGuideLine guideWithGuide: self.originExternalGuideVert
                                   modType: IonValueModType_Subtract
                            andSecondGuide: self.marginHeight];
        
        obj.debugName = sIonGuideLine_TopMargin;
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
        obj = [IonGuideLine guideWithGuide: self.marginHeight
                                   modType: IonValueModType_Add
                            andSecondGuide: self.sizeExternalGuideVert];
        
        obj.debugName = sIonGuideLine_BottomMargin;
        [self.cachedGuideLines setObject: obj forKey: sIonGuideLine_BottomMargin];
    }
    return obj;
}

@end

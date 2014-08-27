//
//  IonGuideGroup.m
//  Ion
//
//  Created by Andrew Hurst on 8/23/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonGuideGroup.h"
#import "IonGuideLine+DefaultConstructors.h"
#import <IonData/IonData.h>

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

@interface IonGuideGroup () {
    NSMutableDictionary* _cachedGuideLines;
    IonKeyValueObserver* _viewObserver;
}

@end

@implementation IonGuideGroup
#pragma mark Constructors

/**
 * Default constructor.
 */
- (instancetype) init {
    self = [super init];
    if ( self )
        self.frame = CGRectZero;
    return self;
}

/**
 * Constructs using the inputted frame.
 * @param {CGRect} the frame to construct with.
 * @returns {instancetype}
 */
- (instancetype) initWithFrame:(CGRect) frame {
    self = [super init];
    if ( self )
        self.frame = frame;
    return self;
}


/**
 * Constructs using the inputted frame.
 * @param {CGRect} the frame to construct with.
 * @returns {instancetype}
 */
- (instancetype) initWithView:(UIView *)view {
    self = [super init];
    if ( self ) {
        _viewObserver = [IonKeyValueObserver observeObject: view
                                                   keyPath: @"frame"
                                                    target: self
                                                  selector: @selector(updateFrameToMatchChange:)
                                                   options: NSKeyValueObservingOptionInitial |
                                                                NSKeyValueObservingOptionNew];
    }
    return self;
}

/**
 * Updates the frame to match the inputted change object.
 * Note: Ment for KVO
 * @param {NSDictionary*} the change dictionary
 * @returns {void}
 */
-(void) updateFrameToMatchChange:(NSDictionary*) change {
    NSValue* rect;
    NSParameterAssert( change && [change isKindOfClass:[NSDictionary class]] );
    if ( !change || ![change isKindOfClass:[NSDictionary class]] )
        return;
    
    rect = [change objectForKey: NSKeyValueChangeNewKey];
    if ( !rect || ![rect isKindOfClass:[NSValue class]] )
        return;
    
    self.frame = [rect CGRectValue];
}

/**
 * The Guide Cache
 */
- (NSMutableDictionary*) cachedGuideLines {
    if ( !_cachedGuideLines )
        _cachedGuideLines = [[NSMutableDictionary alloc] init];
    return _cachedGuideLines;
}

#pragma mark Internal Origin

/**
 * Vertical Internal Origin Guide Line
 */
- (IonGuideLine*) internalOriginGuideVert {
    IonGuideLine* obj = [self.cachedGuideLines objectForKey: sIonGuideLine_InternialOrigin_Vert];
    if ( !obj ) {
        obj = [IonGuideLine guideWithTargetRectPosition: self
                                       usingRectKeyPath: @"frame"
                                                 amount: 0.0f
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
        obj = [IonGuideLine guideWithTargetRectPosition: self
                                       usingRectKeyPath: @"frame"
                                                 amount: 0.0f
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
        obj = [IonGuideLine guideWithTargetRectPosition: self
                                       usingRectKeyPath: @"frame"
                                                 amount: 1.0f/3.0f
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
        obj = [IonGuideLine guideWithTargetRectPosition: self
                                       usingRectKeyPath: @"frame"
                                                 amount: 1.0f/3.0f
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
        obj = [IonGuideLine guideWithTargetRectPosition: self
                                       usingRectKeyPath: @"frame"
                                                 amount: 1.0f/2.0f
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
        obj = [IonGuideLine guideWithTargetRectPosition: self
                                       usingRectKeyPath: @"frame"
                                                 amount: 1.0f/2.0f
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
        obj = [IonGuideLine guideWithTargetRectPosition: self
                                       usingRectKeyPath: @"frame"
                                                 amount: (1.0f/3.0f) * 2.0f
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
        obj = [IonGuideLine guideWithTargetRectPosition: self
                                       usingRectKeyPath: @"frame"
                                                 amount: (1.0f/3.0f) * 2.0f
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
        obj = [IonGuideLine guideWithTargetRectPosition: self
                                       usingRectKeyPath: @"frame"
                                                 amount: 1.0f
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
        obj = [IonGuideLine guideWithTargetRectPosition: self
                                       usingRectKeyPath: @"frame"
                                                 amount: 1.0f
                                                andMode: IonGuideLineFrameMode_Horizontal];
        [self.cachedGuideLines setObject: obj forKey: sIonGuideLine_Size_Horiz];
    }
    return obj;
}

/**
 * Debug description
 */
- (NSString*) description {
    return NSStringFromCGRect( _frame );
}

@end

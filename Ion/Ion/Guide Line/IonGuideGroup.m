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

static NSString* sIonGuideLine_Origin_Horiz =           @"IonGuideLine_InternialOrigin_Horiz";
static NSString* sIonGuideLine_Origin_Vert =            @"IonGuideLine_InternialOrigin_Vert";

static NSString* sIonGuideLine_OneForth_Horiz =         @"IonGuideLine_OneForth_Horiz";
static NSString* sIonGuideLine_OneForth_Vert =          @"IonGuideLine_OneForth_Vert";

static NSString* sIonGuideLine_TwoThirds_Horiz =        @"IonGuideLine_TwoThirds_Horiz";
static NSString* sIonGuideLine_TwoThirds_Vert =         @"IonGuideLine_TwoThirds_Vert";

static NSString* sIonGuideLine_Center_Horiz =           @"IonGuideLine_Center_Horiz";
static NSString* sIonGuideLine_Center_Vert =            @"IonGuideLine_Center_Vert";

static NSString* sIonGuideLine_OneThird_Horiz =         @"IonGuideLine_OneThird_Horiz";
static NSString* sIonGuideLine_OneThird_Vert =          @"IonGuideLine_OneThird_Vert";

static NSString* sIonGuideLine_ThreeForths_Horiz =      @"IonGuideLine_ThreeForths_Horiz";
static NSString* sIonGuideLine_ThreeForths_Vert =       @"IonGuideLine_ThreeForths_Vert";

static NSString* sIonGuideLine_Size_Horiz =             @"IonGuideLine_Size_Horiz";
static NSString* sIonGuideLine_Size_Vert =              @"IonGuideLine_Size_Vert";

static NSString* sIonGuideLine_CornerRadius_Horiz =     @"IonGuideLine_CornerRadius_Horiz";
static NSString* sIonGuideLine_CornerRadius_Vert =      @"IonGuideLine_CornerRadius_Vert";

static NSString* sIonGuideLine_ExternalAppendedKey =    @"_External";
static NSString* sIonGuideGroup_FrameKey =              @"frame";

@interface IonGuideGroup () {
    /**
     * An ivar of the cached guidelines.
     */
    NSMutableDictionary* _cachedGuideLines;
    
    /**
     * Observes the view that we were initilized with if there was any.
     */
    IonKeyValueObserver* _viewObserver;
}

@end

@implementation IonGuideGroup
#pragma mark Constructors
/**
 * Default constructor.
 * @returns {instancetype}
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

#pragma mark View Spcific

/**
 * Updates the frame to match the inputted change object.
 * @warning Ment for KVO
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

#pragma Cached Guide Lines

/**
 * Gets or creates the guide cache.
 * @returns {NSMutableDictionary*} cache of guides.
 */
- (NSMutableDictionary*) cachedGuideLines {
    if ( !_cachedGuideLines )
        _cachedGuideLines = [[NSMutableDictionary alloc] init];
    return _cachedGuideLines;
}

#pragma mark Utilities

/**
 * Creates a copy of the inputed guide for the parent context.
 * @param {IonGuideLine*} the guideline to get in the parent context.
 * @param {IonGuideLineFrameMode} the mode to use.
 * @returns {IonGuideLine*} the guide in the parent context.
 */
- (IonGuideLine*) guideInParentContext:(IonGuideLine*) guide usingMode:(IonGuideLineFrameMode) mode {
    IonGuideLine* originGuide;
    originGuide = (mode == IonGuideLineFrameMode_Horizontal ? self.originExternalGuideHoriz :
                                                              self.originExternalGuideVert);
    return [IonGuideLine guideWithGuide: guide
                                modType: IonValueModType_Add
                         andSecondGuide: originGuide];
}

/**
 * Gets the inputed key for the external value.
 * @param {NSString*} the key to convert to its external equivalent.
 * @returns {NSString*} the external key.
 */
- (NSString*) keyToExternal:(NSString*) key {
    NSParameterAssert( key && [key isKindOfClass:[NSString class]] );
    if ( !key || ![key isKindOfClass:[NSString class]] )
        return NULL;
    return [key stringByAppendingString: sIonGuideLine_ExternalAppendedKey];
}

/**
 * Gets the guide for the specified key from the guide cache.
 * @param {NSString*} the key for the guide.
 * @returns {IonGuideLine*} the guide, or NULL.
 */
- (IonGuideLine*) guideForKey:(NSString*) key {
    NSParameterAssert( key && [key isKindOfClass:[NSString class]] );
    if ( !key || ![key isKindOfClass:[NSString class]] )
        return NULL;
    return [self.cachedGuideLines objectForKey: key];
}

/**
 * Gets the external guide for the specified key.
 * @param {NSString*} the base key to get the external guide from.
 * @returns {IonGuideLine*} the guide, or NULL.
 */
- (IonGuideLine*) externalGuideForKey:(NSString*) key {
    return [self guideForKey: [self keyToExternal: key]];
}

/**
 * Caches the guide for the specified key.
 * @param {IonGuideLine*} the guide to cache.
 * @param {NSString*} the key to cache the guide with.
 * @returns {void}
 */
- (void) cacheGuide:(IonGuideLine*) guide withKey:(NSString*) key {
    NSParameterAssert( key && [key isKindOfClass:[NSString class]] );
    NSParameterAssert( guide && [guide isKindOfClass:[IonGuideLine class]] );
    if ( !key || ![key isKindOfClass:[NSString class]] ||
         !guide || ![guide isKindOfClass:[IonGuideLine class]] )
        return;
    [self.cachedGuideLines setObject: guide forKey: key];
}

/**
 * Caches the external guide for the specified key.
 * @param {IonGuideLine*} the guide to cache.
 * @param {NSString*} the base key to cache the guide with.
 * @returns {void}
 */
- (void) cacheExternalGuide:(IonGuideLine*) guide withKey:(NSString*) key {
    [self cacheGuide: guide withKey: [self keyToExternal: key]];
}

#pragma mark Guides

/* = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
 *                              Internal Guides
 * = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = */
#pragma mark Origin
/**
 * Horizontal Origin Guide Line
 */
- (IonGuideLine*) originGuideHoriz {
    IonGuideLine* obj = [self guideForKey: sIonGuideLine_Origin_Horiz];
    if ( !obj ) {
        obj = [IonGuideLine guideWithStaticValue: 0];
        [self cacheGuide: obj withKey: sIonGuideLine_Origin_Horiz];
    }
    return obj;
}

/**
 * Vertical Origin Guide Line
 */
- (IonGuideLine*) originGuideVert {
    IonGuideLine* obj = [self guideForKey: sIonGuideLine_Origin_Vert];
    if ( !obj ) {
        obj = [IonGuideLine guideWithStaticValue: 0];
        [self cacheGuide: obj withKey: sIonGuideLine_Origin_Vert];
    }
    return obj;
}

#pragma mark One Forth
/**
 * Horizontal One Forth Guide Line
 */
- (IonGuideLine*) oneForthGuideHoriz {
    IonGuideLine* obj = [self guideForKey: sIonGuideLine_OneForth_Horiz];
    if ( !obj ) {
        obj = [IonGuideLine guideWithTargetRectSize: self
                                   usingRectKeyPath: sIonGuideGroup_FrameKey
                                             amount: 1.0f / 4.0f
                                            andMode: IonGuideLineFrameMode_Horizontal];
        [self cacheGuide: obj withKey: sIonGuideLine_OneForth_Horiz];
    }
    return obj;
}

/**
 * Vertical One Forth Guide Line
 */
- (IonGuideLine*) oneForthGuideVert {
    IonGuideLine* obj = [self guideForKey: sIonGuideLine_OneForth_Vert];
    if ( !obj ) {
        obj = [IonGuideLine guideWithTargetRectSize: self
                                   usingRectKeyPath: sIonGuideGroup_FrameKey
                                             amount: 1.0f / 4.0f
                                            andMode: IonGuideLineFrameMode_Vertical];
        [self cacheGuide: obj withKey: sIonGuideLine_OneForth_Vert];
    }
    return obj;
}

#pragma mark One Third
/**
 * Horizontal One Third Guide Line
 */
- (IonGuideLine*) oneThirdGuideHoriz {
    IonGuideLine* obj = [self guideForKey: sIonGuideLine_OneThird_Horiz];
    if ( !obj ) {
        obj = [IonGuideLine guideWithTargetRectSize:self
                                   usingRectKeyPath: sIonGuideGroup_FrameKey
                                             amount: 1.0f / 3.0f
                                            andMode:IonGuideLineFrameMode_Horizontal];
        [self cacheGuide: obj withKey: sIonGuideLine_OneThird_Horiz];
    }
    return obj;
}

/**
 * Vertical One Third Guide Line
 */
- (IonGuideLine*) oneThirdGuideVert {
    IonGuideLine* obj = [self guideForKey: sIonGuideLine_OneThird_Vert];
    if ( !obj ) {
        obj = [IonGuideLine guideWithTargetRectSize:self
                                   usingRectKeyPath: sIonGuideGroup_FrameKey
                                             amount: 1.0f / 3.0f
                                            andMode:IonGuideLineFrameMode_Vertical];
        [self cacheGuide: obj withKey: sIonGuideLine_OneThird_Vert];
    }
    return obj;
}

#pragma mark Center
/**
 * Horizontal Center Guide Line
 */
- (IonGuideLine*) centerGuideHoriz {
    IonGuideLine* obj = [self guideForKey: sIonGuideLine_Center_Horiz];
    if ( !obj ) {
        obj = [IonGuideLine guideWithTargetRectSize: self
                                   usingRectKeyPath: sIonGuideGroup_FrameKey
                                             amount: 1.0f / 2.0f
                                            andMode: IonGuideLineFrameMode_Horizontal];
        [self cacheGuide: obj withKey: sIonGuideLine_Center_Horiz];
    }
    return obj;
}

/**
 * Vertical Center Guide Line
 */
- (IonGuideLine*) centerGuideVert {
    IonGuideLine* obj = [self guideForKey: sIonGuideLine_Center_Vert];
    if ( !obj ) {
        obj = [IonGuideLine guideWithTargetRectSize: self
                                   usingRectKeyPath: sIonGuideGroup_FrameKey
                                             amount: 1.0f / 2.0f
                                            andMode: IonGuideLineFrameMode_Vertical];
        [self cacheGuide: obj withKey: sIonGuideLine_Center_Vert];
    }
    return obj;
}

#pragma mark Two Thirds
/**
 * Horizontal Two Thirds Guide Line
 */
- (IonGuideLine*) twoThirdsGuideHoriz {
    IonGuideLine* obj = [self guideForKey: sIonGuideLine_TwoThirds_Horiz];
    if ( !obj ) {
        obj = [IonGuideLine guideWithTargetRectSize: self
                                   usingRectKeyPath: sIonGuideGroup_FrameKey
                                             amount: 2.0f / 3.0f
                                            andMode: IonGuideLineFrameMode_Horizontal];
        [self cacheGuide: obj withKey: sIonGuideLine_TwoThirds_Horiz];
    }
    return obj;
}

/**
 * Vertical Two Thirds Guide Line
 */
- (IonGuideLine*) twoThirdsGuideVert {
    IonGuideLine* obj = [self guideForKey: sIonGuideLine_TwoThirds_Vert];
    if ( !obj ) {
        obj = [IonGuideLine guideWithTargetRectSize: self
                                   usingRectKeyPath: sIonGuideGroup_FrameKey
                                             amount: 2.0f / 3.0f
                                            andMode: IonGuideLineFrameMode_Vertical];
        [self cacheGuide: obj withKey: sIonGuideLine_TwoThirds_Vert];
    }
    return obj;
}

#pragma mark Three Forths
/**
 * Horizontal Three Forths Guide Line
 */
- (IonGuideLine*) threeForthsGuideHoriz {
    IonGuideLine* obj = [self guideForKey: sIonGuideLine_ThreeForths_Horiz];
    if ( !obj ) {
        obj = [IonGuideLine guideWithTargetRectSize: self
                                   usingRectKeyPath: sIonGuideGroup_FrameKey
                                             amount: 3.0f / 4.0f
                                            andMode: IonGuideLineFrameMode_Horizontal];
        [self cacheGuide: obj withKey: sIonGuideLine_ThreeForths_Horiz];
    }
    return obj;
}

/**
 * Vertical Three Forths Guide Line
 */
- (IonGuideLine*) threeForthsGuideVert {
    IonGuideLine* obj = [self guideForKey: sIonGuideLine_ThreeForths_Vert];
    if ( !obj ) {
        obj = [IonGuideLine guideWithTargetRectSize: self
                                   usingRectKeyPath: sIonGuideGroup_FrameKey
                                             amount: 3.0f / 4.0f
                                            andMode: IonGuideLineFrameMode_Vertical];
        [self cacheGuide: obj withKey: sIonGuideLine_ThreeForths_Vert];
    }
    return obj;
}

#pragma mark Size
/**
 * Horizontal  Size Guide Line
 */
- (IonGuideLine*) sizeGuideHoriz {
    IonGuideLine* obj = [self guideForKey: sIonGuideLine_Size_Horiz];
    if ( !obj ) {
        obj = [IonGuideLine guideWithTargetRectSize: self
                                   usingRectKeyPath: sIonGuideGroup_FrameKey
                                             amount: 1.0f
                                            andMode: IonGuideLineFrameMode_Horizontal];
        [self cacheGuide: obj withKey: sIonGuideLine_Size_Horiz];
    }
    return obj;
}

/**
 * Vertical Size Guide Line
 */
- (IonGuideLine*) sizeGuideVert {
    IonGuideLine* obj = [self guideForKey: sIonGuideLine_Size_Vert];
    if ( !obj ) {
        obj = [IonGuideLine guideWithTargetRectSize: self
                                   usingRectKeyPath: sIonGuideGroup_FrameKey
                                             amount: 1.0f
                                            andMode: IonGuideLineFrameMode_Vertical];
        [self cacheGuide: obj withKey: sIonGuideLine_Size_Vert];
    }
    return obj;
}


/* = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
 *                              External Guides
 * = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = */

#pragma mark Origin External
/**
 * Horizontal External Origin Guide Line
 */
- (IonGuideLine*) originExternalGuideHoriz {
    IonGuideLine* obj = [self externalGuideForKey: sIonGuideLine_Origin_Horiz];
    if ( !obj ) {
        obj = [IonGuideLine guideWithTargetRectPosition: self
                                       usingRectKeyPath: sIonGuideGroup_FrameKey
                                                 amount: 0.0f
                                                andMode: IonGuideLineFrameMode_Horizontal];
        [self cacheExternalGuide: obj withKey: sIonGuideLine_Origin_Horiz];
    }
    return obj;
}

/**
 * Vertical External Origin Guide Line
 */
- (IonGuideLine*) originExternalGuideVert {
    IonGuideLine* obj = [self externalGuideForKey: sIonGuideLine_Origin_Vert];
    if ( !obj ) {
        obj = [IonGuideLine guideWithTargetRectPosition: self
                                       usingRectKeyPath: sIonGuideGroup_FrameKey
                                                 amount: 0.0f
                                                andMode: IonGuideLineFrameMode_Vertical];
        [self cacheGuide: obj withKey: sIonGuideLine_Origin_Vert];
    }
    return obj;
}

#pragma mark One Forth External
/**
 * Horizontal One Forth Guide Line
 */
- (IonGuideLine*) oneForthExternalGuideHoriz {
    IonGuideLine* obj = [self externalGuideForKey: sIonGuideLine_OneForth_Horiz];
    if ( !obj ) {
        obj = [self guideInParentContext: self.oneForthGuideHoriz
                                usingMode: IonGuideLineFrameMode_Horizontal];
        [self cacheExternalGuide: obj withKey: sIonGuideLine_OneForth_Horiz];
    }
    return obj;
}

/**
 * Vertical One Forth Guide Line
 */
- (IonGuideLine*) oneForthExternalGuideVert {
    IonGuideLine* obj = [self externalGuideForKey: sIonGuideLine_OneForth_Vert];
    if ( !obj ) {
        obj = [self guideInParentContext: self.oneForthGuideVert
                               usingMode: IonGuideLineFrameMode_Vertical];
        [self cacheExternalGuide: obj withKey: sIonGuideLine_OneForth_Vert];
    }
    return obj;
}


#pragma mark One Third External
/**
 * Horizontal External One Third Guide Line
 */
- (IonGuideLine*) oneThirdExternalGuideHoriz {
    IonGuideLine* obj = [self externalGuideForKey: sIonGuideLine_OneThird_Horiz];
    if ( !obj ) {
        obj = [self guideInParentContext: self.oneThirdGuideHoriz
                               usingMode: IonGuideLineFrameMode_Horizontal];
        [self cacheExternalGuide: obj withKey: sIonGuideLine_OneThird_Horiz];
    }
    return obj;
}

/**
 * Vertical External One Third Guide Line
 */
- (IonGuideLine*) oneThirdExternalGuideVert {
    IonGuideLine* obj = [self externalGuideForKey: sIonGuideLine_OneThird_Vert];
    if ( !obj ) {
        obj = [self guideInParentContext: self.oneThirdGuideVert
                               usingMode: IonGuideLineFrameMode_Vertical];
        [self cacheExternalGuide: obj withKey: sIonGuideLine_OneThird_Vert];
    }
    return obj;
}


#pragma mark Center External
/**
 * Horizontal External Center Guide Line
 */
- (IonGuideLine*) centerExternalGuideHoriz {
    IonGuideLine* obj = [self externalGuideForKey: sIonGuideLine_Center_Horiz];
    if ( !obj ) {
        obj = [self guideInParentContext: self.centerGuideHoriz
                               usingMode: IonGuideLineFrameMode_Horizontal];
        [self cacheExternalGuide: obj withKey: sIonGuideLine_Center_Horiz];
    }
    return obj;
}

/**
 * Vertical External Center Guide Line
 */
- (IonGuideLine*) centerExternalGuideVert {
    IonGuideLine* obj = [self externalGuideForKey: sIonGuideLine_Center_Vert];
    if ( !obj ) {
        obj = [self guideInParentContext: self.centerGuideVert
                               usingMode: IonGuideLineFrameMode_Vertical];
        [self cacheExternalGuide: obj withKey: sIonGuideLine_Center_Vert];
    }
    return obj;
}


#pragma mark Two Thirds External
/**
 * Horizontal External Two Thirds Guide Line
 */
- (IonGuideLine*) twoThirdsExternalGuideHoriz {
    IonGuideLine* obj = [self externalGuideForKey: sIonGuideLine_TwoThirds_Horiz];
    if ( !obj ) {
        obj = [self guideInParentContext: self.twoThirdsGuideHoriz
                               usingMode: IonGuideLineFrameMode_Horizontal];
        [self cacheExternalGuide: obj withKey: sIonGuideLine_TwoThirds_Horiz];
    }
    return obj;
}

/**
 * Vertical External Two Thirds Guide Line
 */
- (IonGuideLine*) twoThirdsExternalGuideVert {
    IonGuideLine* obj = [self externalGuideForKey: sIonGuideLine_TwoThirds_Vert];
    if ( !obj ) {
        obj = [self guideInParentContext: self.twoThirdsGuideVert
                               usingMode: IonGuideLineFrameMode_Vertical];
        [self cacheExternalGuide: obj withKey: sIonGuideLine_TwoThirds_Vert];
    }
    return obj;
}

#pragma mark Three Forths External
/**
 * Horizontal Three Forths Guide Line
 */
- (IonGuideLine*) threeForthsExternalGuideHoriz {
    IonGuideLine* obj = [self externalGuideForKey: sIonGuideLine_ThreeForths_Horiz];
    if ( !obj ) {
        obj = [self guideInParentContext: self.threeForthsGuideHoriz
                               usingMode: IonGuideLineFrameMode_Horizontal];
        [self cacheExternalGuide: obj withKey: sIonGuideLine_ThreeForths_Horiz];
    }
    return obj;
}

/**
 * Vertical Three Forths Guide Line
 */
- (IonGuideLine*) threeForthsExternalGuideVert {
    IonGuideLine* obj = [self externalGuideForKey: sIonGuideLine_ThreeForths_Vert];
    if ( !obj ) {
        obj = [self guideInParentContext: self.threeForthsGuideVert
                               usingMode: IonGuideLineFrameMode_Vertical];
        [self cacheExternalGuide: obj withKey: sIonGuideLine_ThreeForths_Vert];
    }
    return obj;
}


#pragma mark Size External
/**
 * Horizontal External Size Guide Line
 */
- (IonGuideLine*) sizeExternalGuideHoriz {
    IonGuideLine* obj = [self externalGuideForKey: sIonGuideLine_Size_Horiz];
    if ( !obj ) {
        obj = [self guideInParentContext: self.sizeGuideHoriz
                               usingMode: IonGuideLineFrameMode_Horizontal];
        [self cacheExternalGuide: obj withKey: sIonGuideLine_Size_Horiz];
    }
    return obj;
}


/**
 * Vertical External Size Guide Line
 */
- (IonGuideLine*) sizeExternalGuideVert {
    IonGuideLine* obj = [self externalGuideForKey: sIonGuideLine_Size_Vert];
    if ( !obj ) {
        obj = [self guideInParentContext: self.sizeGuideVert
                               usingMode: IonGuideLineFrameMode_Vertical];
        [self cacheExternalGuide: obj withKey: sIonGuideLine_Size_Vert];
    }
    return obj;
}


#pragma mark Debug

/**
 * Description of the object
 * @returns {NSString*}
 */
- (NSString*) description {
    return [NSString stringWithFormat: @"Active Guides: \"%i\", Current Frame: \"%@\"", [self.cachedGuideLines count], NSStringFromCGRect( _frame )];
}

@end

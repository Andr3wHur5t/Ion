//
//  IonGuideGroup.h
//  Ion
//
//  Created by Andrew Hurst on 8/23/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IonViewGuideSet.h"

@interface IonGuideGroup : NSObject
#pragma mark Constructors
/**
 * Constructs using the inputted frame.
 * @param {CGRect} the frame to construct with.
 * @returns {instancetype}
 */
- (instancetype) initWithFrame:(CGRect) frame;

/**
 * Constructs using the inputted view.
 * @param {UIView*} the view to construct with.
 * @returns {instancetype}
 */
- (instancetype) initWithView:(UIView*) view;

#pragma mark States & Caches

/**
 * The frame of the group
 */
@property (assign, nonatomic) CGRect frame;

/**
 * The Guide Cache
 */
@property (strong, nonatomic, readonly) NSMutableDictionary* cachedGuideLines;

#pragma mark Utilities

/**
 * Creates a copy of the inputed guide for the parent context.
 * @param {IonGuideLine*} the guideline to get in the parent context.
 * @param {IonGuideLineFrameMode} the mode to use.
 * @returns {IonGuideLine*} the guide in the parent context.
 */
- (IonGuideLine*) guideInParentContext:(IonGuideLine*) guide usingMode:(IonGuideLineFrameMode) mode;

/**
 * Gets the inputed key for the external value.
 * @param {NSString*} the key to convert to its external equivelant.
 * @returns {NSString*} the external key.
 */
- (NSString*) keyToExternal:(NSString*) key;

/**
 * Gets the guide for the specified key from the guide cache.
 * @param {NSString*} the key for the guide.
 * @returns {IonGuideLine*} the guide, or NULL.
 */
- (IonGuideLine*) guideForKey:(NSString*) key;

/**
 * Gets the external guide for the specified key.
 * @param {NSString*} the base key to get the external guide from.
 * @returns {IonGuideLine*} the guide, or NULL.
 */
- (IonGuideLine*) externalGuideForKey:(NSString*) key;

/**
 * Caches the guide for the specified key.
 * @param {IonGuideLine*} the guide to cache.
 * @param {NSString*} the key to cache the guide with.
 
 */
- (void) cacheGuide:(IonGuideLine*) guide withKey:(NSString*) key;

/**
 * Caches the external guide for the specified key.
 * @param {IonGuideLine*} the guide to cache.
 * @param {NSString*} the base key to cache the guide with.
 
 */
- (void) cacheExternalGuide:(IonGuideLine*) guide withKey:(NSString*) key;


#pragma mark Guides

/* = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
 *                              Internal Guides
 * = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = */

#pragma mark Origin
/**
 * Horizontal Origin Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* originGuideHoriz;

/**
 * Vertical Origin Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* originGuideVert;

#pragma mark One Forth
/**
 * Horizontal One Forth Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* oneForthGuideHoriz;

/**
 * Vertical One Forth Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* oneForthGuideVert;

#pragma mark One Third
/**
 * Horizontal One Third Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* oneThirdGuideHoriz;

/**
 * Vertical One Third Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* oneThirdGuideVert;

#pragma mark Center
/**
 * Horizontal Center Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* centerGuideHoriz;

/**
 * Vertical Center Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* centerGuideVert;

#pragma mark Two Thirds
/**
 * Horizontal Two Thirds Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* twoThirdsGuideHoriz;

/**
 * Vertical Two Thirds Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* twoThirdsGuideVert;

#pragma mark Three Forths
/**
 * Horizontal Three Forths Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* threeForthsGuideHoriz;

/**
 * Vertical Three Forths Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* threeForthsGuideVert;

#pragma mark Full Size
/**
 * Horizontal  Size Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* sizeGuideHoriz;

/**
 * Vertical Size Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* sizeGuideVert;



/* = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
 *                              External Guides
 * = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = */

#pragma mark Origin External
/**
 * Horizontal External Origin Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* originExternalGuideHoriz;

/**
 * Vertical External Origin Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* originExternalGuideVert;

#pragma mark One Forth External
/**
 * Horizontal One Forth Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* oneForthExternalGuideHoriz;

/**
 * Vertical One Forth Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* oneForthExternalGuideVert;

#pragma mark One Third External
/**
 * Horizontal External One Third Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* oneThirdExternalGuideHoriz;

/**
 * Vertical External One Third Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* oneThirdExternalGuideVert;

#pragma mark Center External
/**
 * Horizontal External Center Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* centerExternalGuideHoriz;

/**
 * Vertical External Center Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* centerExternalGuideVert;

#pragma mark Two Thirds External
/**
 * Horizontal External Two Thirds Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* twoThirdsExternalGuideHoriz;

/**
 * Vertical External Two Thirds Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* twoThirdsExternalGuideVert;

#pragma mark Three Forths External
/**
 * Horizontal Three Forths Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* threeForthsExternalGuideHoriz;

/**
 * Vertical Three Forths Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* threeForthsExternalGuideVert;

#pragma mark Size External
/**
 * Horizontal External Size Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* sizeExternalGuideHoriz;

/**
 * Vertical External Size Guide Line
 */
@property (strong, nonatomic, readonly) IonGuideLine* sizeExternalGuideVert;

@end

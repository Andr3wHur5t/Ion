//
//  IonGuideGroup+GuidePositioning.m
//  Ion
//
//  Created by Andrew Hurst on 8/27/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonGuideGroup+GuidePositioning.h"
#import <objc/runtime.h>
#import <IonData/IonData.h>

static char* sIonGuideSetKey = "IonGuideSet";
static NSString* sIonAutoUpdateLogKey = @"IonAutoUpdateLog";

@implementation IonGuideGroup (GuidePositioning)

#pragma mark Guide Set

/**
 * The guide set setter.
 */
- (void) setGuideSet:(IonViewGuideSet *)guideSet {
    objc_setAssociatedObject(self, sIonGuideSetKey, guideSet, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/**
 * The guide set getter, creates it if it dosn't exsist
 * @returns {IonViewGuideSet*} the guide set.
 */
- (IonViewGuideSet*) guideSet {
    IonViewGuideSet* set = objc_getAssociatedObject(self, sIonGuideSetKey);
    if ( !set ) {
        set = [[IonViewGuideSet alloc] init];
        [set setTarget: self andAction: @selector(updateFrameToMatchGuideSet)];
        self.guideSet = set;
    }
    
    return set;
}

#pragma mark Debuging

/**
 * Logs frame auto updating for the view, with the specified string.
 */
- (void) setLogAutoFrameUpdatesWithString:(NSString*) logAutoFrameUpdatesWithString {
    if ( logAutoFrameUpdatesWithString )
        [self.catagoryVariables setObject: logAutoFrameUpdatesWithString forKey: sIonAutoUpdateLogKey];
    else
        [self.catagoryVariables removeObjectForKey: sIonAutoUpdateLogKey];
}

/**
 * Gets the auto update log key.
 */
- (NSString*) logAutoFrameUpdatesWithString {
    return [self.catagoryVariables objectForKey: sIonAutoUpdateLogKey];
}

/**
 * Logs the guide set if aplicable
 */
- (void) logAutoFrameChange {
    NSString* logKey;
    
    logKey = self.logAutoFrameUpdatesWithString;
    if ( logKey )
        NSLog( @"%@: %@", logKey, self.guideSet);
}

#pragma mark Local Vert Guide

/**
 * Sets the local vert guide, and updates the frame.
 * @returns {void}
 */
- (void) setLocalVertGuide:(IonGuideLine*) localVertGuide {
    self.guideSet.localVertGuide = localVertGuide;
    [self updateFrameToMatchGuideSet];
}

/**
 * Gets the local vert guide.
 * @returns {IonGuideLine}
 */
- (IonGuideLine*) localVertGuide {
    return self.guideSet.localVertGuide;
}

#pragma mark Local Horiz Guide

/**
 * Sets the local horiz guide, and updates the frame.
 * @returns {void}
 */
- (void) setLocalHorizGuide:(IonGuideLine*) localHorizGuide {
    self.guideSet.localHorizGuide = localHorizGuide;
    [self updateFrameToMatchGuideSet];
}

/**
 * Gets the local horiz guide.
 * @returns {IonGuideLine}
 */
- (IonGuideLine*) localHorizGuide {
    return self.guideSet.localVertGuide;
}

#pragma mark Super Vert Guide

/**
 * Sets the local vert guide, and updates the frame.
 * @returns {void}
 */
- (void) setSuperVertGuide:(IonGuideLine*) superVertGuide __attribute__((deprecated)){
    self.guideSet.superVertGuide = superVertGuide;
    [self updateFrameToMatchGuideSet];
}

/**
 * Gets the local vert guide.
 * @returns {IonGuideLine}
 */
- (IonGuideLine*) superVertGuide {
    return self.guideSet.localVertGuide;
}

#pragma mark Super Horiz Guide

/**
 * Sets the local horiz guide, and updates the frame.
 * @returns {void}
 */
- (void) setSuperHorizGuide:(IonGuideLine*) superHorizGuide {
    self.guideSet.superHorizGuide = superHorizGuide;
    [self updateFrameToMatchGuideSet];
}

/**
 * Gets the local horiz guide.
 * @returns {IonGuideLine}
 */
- (IonGuideLine*) superHorizGuide {
    return self.guideSet.localVertGuide;
}

#pragma mark Left Size Guide

/**
 * Sets the local horiz guide, and updates the frame.
 * @returns {void}
 */
- (void) setLeftSizeGuide:(IonGuideLine*) leftSizeGuide {
    self.guideSet.leftSizeGuide = leftSizeGuide;
    [self updateFrameToMatchGuideSet];
}

/**
 * Gets the local horiz guide.
 * @returns {IonGuideLine}
 */
- (IonGuideLine*) leftSizeGuide {
    return self.guideSet.leftSizeGuide;
}

#pragma mark Right Size Guide

/**
 * Sets the local horiz guide, and updates the frame.
 * @returns {void}
 */
- (void) setRightSizeGuide:(IonGuideLine*) rightSizeGuide{
    self.guideSet.rightSizeGuide = rightSizeGuide;
    [self updateFrameToMatchGuideSet];
}

/**
 * Gets the local horiz guide.
 * @returns {IonGuideLine}
 */
- (IonGuideLine*) rightSizeGuide {
    return self.guideSet.rightSizeGuide;
}

#pragma mark Top Size Guide

/**
 * Sets the local horiz guide, and updates the frame.
 * @returns {void}
 */
- (void) setTopSizeGuide:(IonGuideLine*) topSizeGuide{
    self.guideSet.topSizeGuide = topSizeGuide;
    [self updateFrameToMatchGuideSet];
}

/**
 * Gets the local horiz guide.
 * @returns {IonGuideLine}
 */
- (IonGuideLine*) topSizeGuide {
    return self.guideSet.topSizeGuide;
}

#pragma mark Bottom Size Guide

/**
 * Sets the local horiz guide, and updates the frame.
 * @returns {void}
 */
- (void) setBottomSizeGuide:(IonGuideLine*) bottomSizeGuide{
    self.guideSet.bottomSizeGuide = bottomSizeGuide;
    [self updateFrameToMatchGuideSet];
}

/**
 * Gets the local horiz guide.
 * @returns {IonGuideLine}
 */
- (IonGuideLine*) bottomSizeGuide {
    return self.guideSet.bottomSizeGuide;
}

#pragma mark Setters

/**
 * Sets the local guides.
 * @param {IonGuideLine*} the vertical guide line.
 * @param {IonGuideLine*} the horizontal guide line.
 * @returns {void}
 */
- (void) setLocalGuidesWithVert:(IonGuideLine*) vert andHoriz:(IonGuideLine*) horiz __attribute__((deprecated)){
    NSParameterAssert( vert && [vert isKindOfClass:[IonGuideLine class]] );
    NSParameterAssert( horiz && [horiz isKindOfClass:[IonGuideLine class]] );
    if ( !vert || ![vert isKindOfClass:[IonGuideLine class]] ||
        !horiz || ![horiz isKindOfClass:[IonGuideLine class]] )
        return;
    
    self.guideSet.localVertGuide = vert;
    self.guideSet.localHorizGuide = horiz;
    [self updateFrameToMatchGuideSet];
}

/**
 * Sets the super guides.
 * @param {IonGuideLine*} the vertical guide line.
 * @param {IonGuideLine*} the horizontal guide line.
 * @returns {void}
 */
- (void) setSuperGuidesWithVert:(IonGuideLine*) vert andHoriz:(IonGuideLine*) horiz __attribute__((deprecated)){
    NSParameterAssert( vert && [vert isKindOfClass:[IonGuideLine class]] );
    NSParameterAssert( horiz && [horiz isKindOfClass:[IonGuideLine class]] );
    if ( !vert || ![vert isKindOfClass:[IonGuideLine class]] ||
        !horiz || ![horiz isKindOfClass:[IonGuideLine class]] )
        return;
    
    self.guideSet.superVertGuide = vert;
    self.guideSet.superHorizGuide = horiz;
    [self updateFrameToMatchGuideSet];
}

/**
 * Sets all guides.
 * @param {IonGuideLine*} the local vertical guide line.
 * @param {IonGuideLine*} the local horizontal guide line.
 * @param {IonGuideLine*} the super vertical guide line.
 * @param {IonGuideLine*} the super horizontal guide line.
 * @returns {void}
 */
- (void) setGuidesWithLocalVert:(IonGuideLine*) lVert
                     localHoriz:(IonGuideLine*) lHoriz
                      superVert:(IonGuideLine*) sVert
                  andSuperHoriz:(IonGuideLine*) sHoriz __attribute__((deprecated)){
    NSParameterAssert( sVert  && [sVert isKindOfClass:[IonGuideLine class]] );
    NSParameterAssert( sHoriz && [sHoriz isKindOfClass:[IonGuideLine class]] );
    NSParameterAssert( lVert  && [lVert isKindOfClass:[IonGuideLine class]] );
    NSParameterAssert( lHoriz && [lHoriz isKindOfClass:[IonGuideLine class]] );
    if ( !sVert  || ![sVert isKindOfClass:[IonGuideLine class]] ||
        !sHoriz || ![sHoriz isKindOfClass:[IonGuideLine class]] ||
        !lVert  || ![lVert isKindOfClass:[IonGuideLine class]] ||
        !lHoriz || ![lHoriz isKindOfClass:[IonGuideLine class]])
        return;
    
    self.guideSet.superVertGuide  = sVert;
    self.guideSet.superHorizGuide = sHoriz;
    self.guideSet.localVertGuide  = lVert;
    self.guideSet.localHorizGuide = lHoriz;
    [self updateFrameToMatchGuideSet];
}

#pragma mark Size Functions


#pragma mark Update Functions

/**
 * Updates the position of the current frame to match the guide set.
 * @returns {void}
 */
- (void) updateFrameToMatchGuideSet {
    CGRect frame = [self.guideSet toRect];
    
    // Check sizing rules
    if ( CGSizeEqualToSize( frame.size , CGSizeZero ) )
        frame.size = self.frame.size;
    
    [self logAutoFrameChange];
    // Update frame
    self.frame = frame;
}


@end

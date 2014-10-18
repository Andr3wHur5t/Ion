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
 * @return {IonViewGuideSet*} the guide set.
 */
- (IonViewGuideSet *)guideSet {
    IonViewGuideSet *guideSet = objc_getAssociatedObject(self, sIonGuideSetKey);
    if ( !guideSet ) {
        guideSet = [[IonViewGuideSet alloc] init];
        [guideSet addTarget: self andAction: @selector(updateFrameToMatchGuideSet)];
        self.guideSet = guideSet;
    }
    return guideSet;
}

#pragma mark Debuging
/**
 * Logs frame auto updating for the view, with the specified string.
 */
- (void) setLogAutoFrameUpdatesWithString:(NSString*) logAutoFrameUpdatesWithString {
    if ( logAutoFrameUpdatesWithString )
        [self.categoryVariables setObject: logAutoFrameUpdatesWithString forKey: sIonAutoUpdateLogKey];
    else
        [self.categoryVariables removeObjectForKey: sIonAutoUpdateLogKey];
}

/**
 * Gets the auto update log key.
 */
- (NSString*) logAutoFrameUpdatesWithString {
    return [self.categoryVariables objectForKey: sIonAutoUpdateLogKey];
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
 * Sets the local vert guide.
 */
- (void) setLocalVertGuide:(IonGuideLine*) localVertGuide {
    self.guideSet.localVertGuide = localVertGuide;
}

/**
 * Gets the local vert guide.
 * @return {IonGuideLine}
 */
- (IonGuideLine*) localVertGuide {
    return self.guideSet.localVertGuide;
}

#pragma mark Local Horiz Guide
/**
 * Sets the local horiz guide.
 */
- (void) setLocalHorizGuide:(IonGuideLine*) localHorizGuide {
    self.guideSet.localHorizGuide = localHorizGuide;
}

/**
 * Gets the local horiz guide.
 * @return {IonGuideLine}
 */
- (IonGuideLine*) localHorizGuide {
    return self.guideSet.localVertGuide;
}

#pragma mark Super Vert Guide
/**
 * Sets the local vert guide.
 */
- (void) setSuperVertGuide:(IonGuideLine*) superVertGuide __attribute__((deprecated)){
    self.guideSet.superVertGuide = superVertGuide;
}

/**
 * Gets the local vert guide.
 * @return {IonGuideLine}
 */
- (IonGuideLine*) superVertGuide {
    return self.guideSet.localVertGuide;
}

#pragma mark Super Horiz Guide
/**
 * Sets the local horiz guide.
 */
- (void) setSuperHorizGuide:(IonGuideLine*) superHorizGuide {
    self.guideSet.superHorizGuide = superHorizGuide;
}

/**
 * Gets the local horiz guide.
 * @return {IonGuideLine}
 */
- (IonGuideLine*) superHorizGuide {
    return self.guideSet.localVertGuide;
}

#pragma mark Left Size Guide
/**
 * Sets the local horiz guide.
 */
- (void) setLeftSizeGuide:(IonGuideLine*) leftSizeGuide {
    self.guideSet.leftSizeGuide = leftSizeGuide;
}

/**
 * Gets the local horiz guide.
 * @return {IonGuideLine}
 */
- (IonGuideLine*) leftSizeGuide {
    return self.guideSet.leftSizeGuide;
}

#pragma mark Right Size Guide
/**
 * Sets the local horiz guide.
 */
- (void) setRightSizeGuide:(IonGuideLine*) rightSizeGuide{
    self.guideSet.rightSizeGuide = rightSizeGuide;
}

/**
 * Gets the local horiz guide.
 * @return {IonGuideLine}
 */
- (IonGuideLine*) rightSizeGuide {
    return self.guideSet.rightSizeGuide;
}

#pragma mark Top Size Guide
/**
 * Sets the local horiz guide.
 */
- (void) setTopSizeGuide:(IonGuideLine*) topSizeGuide{
    self.guideSet.topSizeGuide = topSizeGuide;
}

/**
 * Gets the local horiz guide.
 * @return {IonGuideLine}
 */
- (IonGuideLine*) topSizeGuide {
    return self.guideSet.topSizeGuide;
}

#pragma mark Bottom Size Guide
/**
 * Sets the local horiz guide.
 */
- (void) setBottomSizeGuide:(IonGuideLine*) bottomSizeGuide{
    self.guideSet.bottomSizeGuide = bottomSizeGuide;
}

/**
 * Gets the local horiz guide.
 * @return {IonGuideLine}
 */
- (IonGuideLine*) bottomSizeGuide {
    return self.guideSet.bottomSizeGuide;
}

#pragma mark Setter Utilities
/**
 * Sets the local guides.
 * @param horiz - the horizontal guide line.
 * @param vert - the vertical guide line.
 */
- (void) setLocalGuidesWithHorz:(IonGuideLine *)horiz andVert:(IonGuideLine *)vert {
    [self.guideSet setLocalGuidesWithHorz: horiz andVert: vert];
}

/**
 * Sets the super guides.
 * @param horiz - the horizontal guide line.
 * @param vert - the vertical guide line.
 */
- (void) setSuperGuidesWithHorz:(IonGuideLine *)horiz andVert:(IonGuideLine *)vert {
    [self.guideSet setSuperGuidesWithHorz: horiz andVert: vert];
}

/**
 * Sets all position guides.
 * @param lHoriz - the local horizontal guide line.
 * @param lVert - the local vertical guide line.
 * @param sHoriz- the super horizontal guide line.
 * @param sVert - the super vertical guide line.
 */
- (void) setGuidesWithLocalHoriz:(IonGuideLine *)lHoriz
                       localVert:(IonGuideLine *)lVert
                      superHoriz:(IonGuideLine *)sHoriz
                    andSuperVert:(IonGuideLine *)sVert {
    [self.guideSet setGuidesWithLocalHoriz: lHoriz localVert: lVert superHoriz: sHoriz andSuperVert: sVert];
}

/**
 * Sets the horizontal size guides.
 * @param left - the left size guide.
 * @param right - the right size guide.
 */
- (void) setSizeHorizontalWithLeft:(IonGuideLine *)left andRight:(IonGuideLine *)right {
    [self.guideSet setSizeHorizontalWithLeft: left andRight: right];
}

/**
 * Sets the horizontal size guides.
 * @param top - the top size guide.
 * @param bottom - the bottom size guide.
 */
- (void) setSizeVerticalyWithTop:(IonGuideLine *)top andBottom:(IonGuideLine *)bottom {
    [self.guideSet setSizeVerticalyWithTop: top andBottom: bottom];
}

/**
 * Sets all size guides.
 * @param left - the left size guide.
 * @param right - the right size guide.
 * @param top - the top size guide.
 * @param bottom - the bottom size guide.
 */
- (void) setSizeGuidesWithLeft:(IonGuideLine *)left
                         right:(IonGuideLine *)right
                           top:(IonGuideLine *)top
                     andBottom:(IonGuideLine *)bottom {
    [self.guideSet setSizeGuidesWithLeft: left
                                   right: right
                                     top: top
                               andBottom: bottom];
}

/**
 * Sets both size, and positioning guides.
 * @param lHoriz - the local horizontal guide line.
 * @param lVert - the local vertical guide line.
 * @param sHoriz- the super horizontal guide line.
 * @param sVert - the super vertical guide line.
 * @param left - the left size guide.
 * @param right - the right size guide.
 * @param top - the top size guide.
 * @param bottom - the bottom size guide.
 */
- (void) setGuidesWithLocalHoriz:(IonGuideLine *)lHoriz
                       localVert:(IonGuideLine *)lVert
                      superHoriz:(IonGuideLine *)sHoriz
                       superVert:(IonGuideLine *)sVert
                            left:(IonGuideLine *)left
                           right:(IonGuideLine *)right
                             top:(IonGuideLine *)top
                       andBottom:(IonGuideLine *)bottom {
    [self.guideSet setGuidesWithLocalHoriz: lHoriz
                                 localVert: lVert
                                superHoriz: sHoriz
                                 superVert: sVert
                                      left: left
                                     right: right
                                       top: top
                                 andBottom: bottom];
}

#pragma mark Update Functions
/**
 * Updates the position of the current frame to match the guide set.
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

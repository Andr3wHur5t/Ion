//
//  UIView+IonGuideLine.m
//  Ion
//
//  Created by Andrew Hurst on 8/22/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "UIView+IonGuideLine.h"
#import "UIView+IonGuideGroup.h"
#import <IonData/IonData.h>
#import <objc/runtime.h>


static char* sIonCachedGuideLineKey = "IonCachedGuideLines";
static NSString* sIonAutoUpdateLogKey = @"IonAutoUpdateLog";

@implementation UIView (IonGuideLine)
#pragma mark Guide Set

- (void) setCachedGuideLines:(NSMutableDictionary *)cachedGuideLines {
    objc_setAssociatedObject( self, sIonCachedGuideLineKey, cachedGuideLines, OBJC_ASSOCIATION_RETAIN_NONATOMIC );
}

- (NSMutableDictionary *)cachedGuideLines {
    NSMutableDictionary *set = objc_getAssociatedObject( self, sIonCachedGuideLineKey );
    if ( !set ) {
        set = [[NSMutableDictionary alloc] init];
        self.cachedGuideLines = set;
    }
    return set;
}


#pragma mark Debuging

- (void) setDebuggingName:(NSString *)debuggingName {
    if ( debuggingName )
        [self.categoryVariables setObject: debuggingName forKey: sIonAutoUpdateLogKey];
    else
        [self.categoryVariables removeObjectForKey: sIonAutoUpdateLogKey];
}


- (NSString *)debuggingName {
    return [self.categoryVariables objectForKey: sIonAutoUpdateLogKey];
}

- (void) logAutoFrameChange {
    if ( self.debuggingName )
        NSLog( @"%@: %@", self.debuggingName, self.guideSet);
}

#pragma mark Guide Set

- (IonViewGuideSet *)guideSet {
    if ( ![self.categoryVariables objectForKey: @"GuideSetConfigured"] ) {
        [self.guideGroup.guideSet addTarget: self andAction: @selector(updateFrameToMatchGuideSet)];
        [self.categoryVariables setObject: @1 forKey:@"GuideSetConfigured"];
    }
    return self.guideGroup.guideSet;
}

#pragma mark Local Vert Guide

- (void) setLocalVertGuide:(IonGuideLine *)localVertGuide {
    self.guideSet.localVertGuide = localVertGuide;
}

- (IonGuideLine *)localVertGuide {
    return self.guideSet.localVertGuide;
}

#pragma mark Local Horiz Guide

- (void) setLocalHorizGuide:(IonGuideLine *)localHorizGuide {
    self.guideSet.localHorizGuide = localHorizGuide;
}

- (IonGuideLine *)localHorizGuide {
    return self.guideSet.localVertGuide;
}

#pragma mark Super Vert Guide

- (void) setSuperVertGuide:(IonGuideLine *)superVertGuide {
    self.guideSet.superVertGuide = superVertGuide;
}

- (IonGuideLine *)superVertGuide {
    return self.guideSet.localVertGuide;
}

#pragma mark Super Horiz Guide

- (void) setSuperHorizGuide:(IonGuideLine *)superHorizGuide {
    self.guideSet.superHorizGuide = superHorizGuide;
}

- (IonGuideLine *)superHorizGuide {
    return self.guideSet.localVertGuide;
}

#pragma mark Left Size Guide

- (void) setLeftSizeGuide:(IonGuideLine *)leftSizeGuide{
    self.guideSet.leftSizeGuide = leftSizeGuide;
}

- (IonGuideLine *)leftSizeGuide {
    return self.guideSet.leftSizeGuide;
}

#pragma mark Right Size Guide

- (void) setRightSizeGuide:(IonGuideLine *)rightSizeGuide{
    self.guideSet.rightSizeGuide = rightSizeGuide;
}

- (IonGuideLine *)rightSizeGuide {
    return self.guideSet.rightSizeGuide;
}

#pragma mark Top Size Guide

- (void) setTopSizeGuide:(IonGuideLine*) topSizeGuide{
    self.guideSet.topSizeGuide = topSizeGuide;
}

- (IonGuideLine*) topSizeGuide {
    return self.guideSet.topSizeGuide;
}

#pragma mark Bottom Size Guide

- (void) setBottomSizeGuide:(IonGuideLine *)bottomSizeGuide{
    self.guideSet.bottomSizeGuide = bottomSizeGuide;
}

- (IonGuideLine *)bottomSizeGuide {
    return self.guideSet.bottomSizeGuide;
}

#pragma mark Manual Size Mode

- (void) setManualSizeMode:(BOOL)manualSizeMode {
    self.guideSet.manualSizeMode = manualSizeMode;
}

- (BOOL) manualSizeMode {
    return self.guideSet.manualSizeMode;
}


#pragma mark Setter Utilities

- (void) setLocalGuidesWithHorz:(IonGuideLine *)horiz andVert:(IonGuideLine *)vert {
    [self.guideSet setLocalGuidesWithHorz: horiz andVert: vert];
}

- (void) setSuperGuidesWithHorz:(IonGuideLine *)horiz andVert:(IonGuideLine *)vert {
    [self.guideSet setSuperGuidesWithHorz: horiz andVert: vert];
}

- (void) setGuidesWithLocalHoriz:(IonGuideLine *)lHoriz
                       localVert:(IonGuideLine *)lVert
                      superHoriz:(IonGuideLine *)sHoriz
                    andSuperVert:(IonGuideLine *)sVert {
    [self.guideSet setGuidesWithLocalHoriz: lHoriz localVert: lVert superHoriz: sHoriz andSuperVert: sVert];
}

- (void) setSizeHorizontalWithLeft:(IonGuideLine *)left andRight:(IonGuideLine *)right {
    [self.guideSet setSizeHorizontalWithLeft: left andRight: right];
}

- (void) setSizeVerticalyWithTop:(IonGuideLine *)top andBottom:(IonGuideLine *)bottom {
    [self.guideSet setSizeVerticalyWithTop: top andBottom: bottom];
}

- (void) setSizeGuidesWithLeft:(IonGuideLine *)left
                         right:(IonGuideLine *)right
                           top:(IonGuideLine *)top
                     andBottom:(IonGuideLine *)bottom {
    [self.guideSet setSizeGuidesWithLeft: left
                                   right: right
                                     top: top
                               andBottom: bottom];
}

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

- (void) updateFrameToMatchGuideSet {
    CGRect frame = [self.guideSet toRect];
    
    // Check sizing rules
    if ( CGSizeEqualToSize( frame.size , CGSizeZero ) )
        frame.size = self.frame.size;
    
//    NSLog( @"%i", self.manualSizeMode );
    [self logAutoFrameChange];
    // Update frame
    self.frame = frame;
}
@end

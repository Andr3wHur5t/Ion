//
//  IonViewGuideSet.m
//  Ion
//
//  Created by Andrew Hurst on 8/22/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonViewGuideSet.h"
#import "IonGuideLine+DefaultConstructors.h"
#import <IonData/IonData.h>

@interface IonViewGuideSet () {
    FOTargetActionSet *frameChangeResponseSet;
}

@end

@implementation IonViewGuideSet

@synthesize frame = _frame;

#pragma mark Bulk Setters

- (void) setLocalGuidesWithHorz:(IonGuideLine *)horiz andVert:(IonGuideLine *)vert {
    self.localHorizGuide = horiz;
    self.localVertGuide = vert;
}

- (void) setSuperGuidesWithHorz:(IonGuideLine *)horiz andVert:(IonGuideLine *)vert {
    self.superHorizGuide = horiz;
    self.superVertGuide = vert;
}

- (void) setGuidesWithLocalHoriz:(IonGuideLine*) lHoriz
                       localVert:(IonGuideLine*) lVert
                      superHoriz:(IonGuideLine*) sHoriz
                    andSuperVert:(IonGuideLine*) sVert {
    [self setLocalGuidesWithHorz: lHoriz andVert: lVert];
    [self setSuperGuidesWithHorz: sHoriz andVert: sVert];
}

- (void) setSizeHorizontalWithLeft:(IonGuideLine *)left andRight:(IonGuideLine *)right {
    self.leftSizeGuide = left;
    self.rightSizeGuide = right;
}

- (void) setSizeVerticalyWithTop:(IonGuideLine *)top andBottom:(IonGuideLine *)bottom {
    self.topSizeGuide = top;
    self.bottomSizeGuide = bottom;
}

- (void) setSizeGuidesWithLeft:(IonGuideLine *)left
                         right:(IonGuideLine *)right
                           top:(IonGuideLine *)top
                     andBottom:(IonGuideLine *)bottom {
    [self setSizeHorizontalWithLeft: left andRight: right];
    [self setSizeVerticalyWithTop: top andBottom: bottom];
}

- (void) setGuidesWithLocalHoriz:(IonGuideLine *)lHoriz
                       localVert:(IonGuideLine *)lVert
                      superHoriz:(IonGuideLine *)sHoriz
                       superVert:(IonGuideLine *)sVert
                            left:(IonGuideLine *)left
                           right:(IonGuideLine *)right
                             top:(IonGuideLine *)top
                       andBottom:(IonGuideLine *)bottom {
    [self setGuidesWithLocalHoriz: lHoriz localVert: lVert superHoriz: sHoriz andSuperVert: sVert];
    [self setSizeGuidesWithLeft: left right: right top: top andBottom: bottom];
}

#pragma mark Super Vert

+ (BOOL) automaticallyNotifiesObserversOfSuperVertGuide{ return FALSE; }

- (void) setSuperVertGuide:(IonGuideLine*) guide {
    [self setGuide: guide forKey: @"superVertGuide"];
}

- (IonGuideLine *)superVertGuide {
    return [self.guides objectForKey: @"superVertGuide"];
}

#pragma mark Super Horiz

+ (BOOL) automaticallyNotifiesObserversOfSuperHorizGuide { return FALSE; }

- (void) setSuperHorizGuide:(IonGuideLine*) guide {
    [self setGuide: guide forKey: @"superHorizGuide"];
}

- (IonGuideLine *)superHorizGuide {
    return [self.guides objectForKey: @"superHorizGuide"];
}

#pragma mark Local Vert

+ (BOOL) automaticallyNotifiesObserversOfLocalVertGuide { return FALSE; }

- (void) setLocalVertGuide:(IonGuideLine*) guide {
    [self setGuide: guide forKey: @"localVertGuide"];
}

- (IonGuideLine *)localVertGuide {
    IonGuideLine *localGuide = [self.guides objectForKey: @"localVertGuide"];
    if ( !localGuide )
        self.localVertGuide = localGuide = [IonGuideLine guideWithStaticValue: 0.0f];
    return localGuide;
}

#pragma mark Local Horiz

+ (BOOL) automaticallyNotifiesObserversOfLocalHorizGuide { return FALSE; }

- (void) setLocalHorizGuide:(IonGuideLine*) guide {
     [self setGuide: guide forKey: @"localHorizGuide"];
}

- (IonGuideLine *)localHorizGuide {
    IonGuideLine *localGuide = [self.guides objectForKey: @"localHorizGuide"];
    if ( !localGuide )
        self.localHorizGuide = localGuide = [IonGuideLine guideWithStaticValue: 0.0f];
    return localGuide;
}

#pragma mark Size

+ (BOOL) automaticallyNotifiesObserversOfLeftSizeGuide { return FALSE; }

- (void) setLeftSizeGuide:(IonGuideLine*) guide {
    [self setGuide: guide forKey: @"leftSizeGuide"];
}

- (IonGuideLine *)leftSizeGuide {
    return [self.guides objectForKey: @"leftSizeGuide"];
}


+ (BOOL) automaticallyNotifiesObserversOfRightSizeGuide{ return FALSE; }

- (void) setRightSizeGuide:(IonGuideLine*) guide {
     [self setGuide: guide forKey: @"rightSizeGuide"];
}

- (IonGuideLine *)rightSizeGuide {
    return [self.guides objectForKey: @"rightSizeGuide"];
}


+ (BOOL) automaticallyNotifiesObserversOfTopSizeGuide{ return FALSE; }

- (void) setTopSizeGuide:(IonGuideLine*) guide {
    [self setGuide: guide forKey: @"topSizeGuide"];
}

- (IonGuideLine *)topSizeGuide {
    return [self.guides objectForKey: @"topSizeGuide"];
}


+ (BOOL) automaticallyNotifiesObserversOfBottomSizeGuide { return FALSE; }

- (void) setBottomSizeGuide:(IonGuideLine*) guide {
    [self setGuide: guide forKey: @"bottomSizeGuide"];
}

- (IonGuideLine *)bottomSizeGuide {
    return [self.guides objectForKey: @"bottomSizeGuide"];
}

#pragma mark Change Updates

- (void) guideDidUpdate {
    // If a guide updates we need to update our frame.
    [self updateFrame];
    
    // Inform our observers via super
    [super guideDidUpdate];
}

- (void) updateFrame {
    [self willChangeValueForKey: @"frame"];
    _frame = [self toRect];
    [self didChangeValueForKey: @"frame"];
}

#pragma mark Retrieval

- (CGPoint) toPoint {
    CGFloat x, y;
    x = y = 0.0f;
    
    // Get X
    if ( self.superHorizGuide && [self.superHorizGuide isKindOfClass:[IonGuideLine class]] &&
        self.localHorizGuide && [self.localHorizGuide isKindOfClass:[IonGuideLine class]] )
        x = self.superHorizGuide.position - self.localHorizGuide.position;
    
    // Get Y
    if ( self.superVertGuide && [self.superVertGuide isKindOfClass:[IonGuideLine class]] &&
        self.localVertGuide && [self.localVertGuide isKindOfClass:[IonGuideLine class]] )
        y = self.superVertGuide.position - self.localVertGuide.position;
    
    // Calc and return
    return (CGPoint){ x, y };
}

- (CGSize) toSize {
    CGFloat width, height;
    width = height = 0.0f;
    
    // Get Width
    if ( self.leftSizeGuide && [self.leftSizeGuide isKindOfClass:[IonGuideLine class]] &&
        self.rightSizeGuide && [self.rightSizeGuide isKindOfClass:[IonGuideLine class]] )
        width = self.rightSizeGuide.position - self.leftSizeGuide.position;
    
    // Get Y
    if ( self.topSizeGuide && [self.topSizeGuide isKindOfClass:[IonGuideLine class]] &&
        self.bottomSizeGuide && [self.bottomSizeGuide isKindOfClass:[IonGuideLine class]] )
        height = self.bottomSizeGuide.position - self.topSizeGuide.position;
    
    // Calc and return
    return (CGSize){ ABS(width), ABS(height) };
}

- (CGRect) toRect {
    return (CGRect){ [self toPoint], [self toSize] };
}

- (NSString *)description {
    CGPoint point = [self toPoint];
    CGSize  size = [self toSize];
    return [NSString stringWithFormat: @"\nSuperMount  {X: %@, Y: %@}\nlocalMount  {X: %@, Y: %@}\nResultPoint {X: %.2f, Y: %.2f}\nSizePoints  {L: %@, R: %@, T: %@, B: %@ }\nResultSize  {W: %.2f, H: %.2f}\n\n",
                                    self.superHorizGuide, self.superVertGuide,
                                    self.localHorizGuide, self.localVertGuide,
                                    point.x, point.y,
                                    self.leftSizeGuide, self.rightSizeGuide, self.topSizeGuide, self.bottomSizeGuide,
                                    size.width, size.height ];
}

@end

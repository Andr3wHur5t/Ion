//
//  IonViewGuideSet.m
//  Ion
//
//  Created by Andrew Hurst on 8/22/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonViewGuideSet.h"
#import "IonTargetActionList.h"
#import "IonGuideLine+DefaultConstructors.h"
#import <IonData/IonData.h>

@interface IonViewGuideSet () {
    IonTargetActionSet *frameChangeResponseSet;
}

/**
 * Our currently observed guides.
 */
@property (strong, nonatomic, readonly) NSMutableDictionary *guides;

/**
 * A list of localy managed observers.
 */
@property (strong, nonatomic, readonly) IonTargetActionList *localObservers;

@end

@implementation IonViewGuideSet

@synthesize frame = _frame;
@synthesize guides = _guides;
@synthesize localObservers = _localObservers;

#pragma mark Guides
/**
 * Gets or constructs the the guides map.
 */
- (NSMutableDictionary *)guides {
    if ( !_guides )
        _guides = [[NSMutableDictionary alloc] init];
    return _guides;
}

/**
 * Sets the guide for the specified key.
 * @param newGuide - the new guide to set.
 * @param key - the key of the guide to set.
 * @param resultLocation - the local retained ivar of the guide.
 */
- (void) setGuide:(IonGuideLine *)guide forKey:(NSString *)key {
    IonGuideLine *object;
    NSParameterAssert( key && [key isKindOfClass: [NSString class]] );
    if ( !key || ![key isKindOfClass: [NSString class]] )
        return;
    
    // Was there a change?
    object = [self.guides objectForKey: key];
    if ( [guide isEqual: object] )
        return; // Nope don't do anything
  
    // Was there a previous object?
    if ( object ) // Yep, unregister this guide set from it.
        [object removeLocalObserverTarget: self andAction: @selector(updateFrame)];
    
    // Inform KVO of incoming change
    [self willChangeValueForKey: key];
    
    if ( guide ) // Are we setting the guide or removing it?
        [self.guides setObject: guide forKey: key];
    else
        [self.guides removeObjectForKey: key];
    
    // Inform KVO of change completion
    [self didChangeValueForKey: key];
    
    // Register the guide with our self.
    if ( guide && [guide isKindOfClass: [IonGuideLine class]] )
        [guide addLocalObserverTarget: self andAction: @selector(updateFrame)];
    
    // Force an update
    [self updateFrame];
}


#pragma mark Bulk Setters
/**
 * Sets the local guides.
 * @param horiz - the horizontal guide line.
 * @param vert - the vertical guide line.
 */
- (void) setLocalGuidesWithHorz:(IonGuideLine *)horiz andVert:(IonGuideLine *)vert {
    self.localHorizGuide = horiz;
    self.localVertGuide = vert;
}

/**
 * Sets the super guides.
 * @param horiz - the horizontal guide line.
 * @param vert - the vertical guide line.
 */
- (void) setSuperGuidesWithHorz:(IonGuideLine *)horiz andVert:(IonGuideLine *)vert {
    self.superHorizGuide = horiz;
    self.superVertGuide = vert;
}

/**
 * Sets all position guides.
 * @param lHoriz - the local horizontal guide line.
 * @param lVert - the local vertical guide line.
 * @param sHoriz- the super horizontal guide line.
 * @param sVert - the super vertical guide line.
 */
- (void) setGuidesWithLocalHoriz:(IonGuideLine*) lHoriz
                       localVert:(IonGuideLine*) lVert
                      superHoriz:(IonGuideLine*) sHoriz
                    andSuperVert:(IonGuideLine*) sVert {
    [self setLocalGuidesWithHorz: lHoriz andVert: lVert];
    [self setSuperGuidesWithHorz: sHoriz andVert: sVert];
}

/**
 * Sets the horizontal size guides.
 * @param left - the left size guide.
 * @param right - the right size guide.
 */
- (void) setSizeHorizontalWithLeft:(IonGuideLine *)left andRight:(IonGuideLine *)right {
    self.leftSizeGuide = left;
    self.rightSizeGuide = right;
}

/**
 * Sets the horizontal size guides.
 * @param top - the top size guide.
 * @param bottom - the bottom size guide.
 */
- (void) setSizeVerticalyWithTop:(IonGuideLine *)top andBottom:(IonGuideLine *)bottom {
    self.topSizeGuide = top;
    self.bottomSizeGuide = bottom;
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
    [self setSizeHorizontalWithLeft: left andRight: right];
    [self setSizeVerticalyWithTop: top andBottom: bottom];
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
    [self setGuidesWithLocalHoriz: lHoriz localVert: lVert superHoriz: sHoriz andSuperVert: sVert];
    [self setSizeGuidesWithLeft: left right: right top: top andBottom: bottom];
}

#pragma mark Super Vert

/**
 * Switch guide to manual KVO observation mode
 */
+ (BOOL) automaticallyNotifiesObserversOfSuperVertGuide{ return FALSE; }

/**
 * Sets the vertical guide in the super pair.
 * @param guide - the new guide.
 */
- (void) setSuperVertGuide:(IonGuideLine*) guide {
    [self setGuide: guide forKey: @"superVertGuide"];
}

/**
 * Gets the super vert guide.
 * @returns {IonGuideLine*}
 */
- (IonGuideLine *)superVertGuide {
    return [self.guides objectForKey: @"superVertGuide"];
}

#pragma mark Super Horiz

/**
 * Switch guide to manual KVO observation mode
 */
+ (BOOL) automaticallyNotifiesObserversOfSuperHorizGuide { return FALSE; }

/**
 * Sets the horizontal guide in the super pair.
 * @param guide - the new guide.
 */
- (void) setSuperHorizGuide:(IonGuideLine*) guide {
    [self setGuide: guide forKey: @"superHorizGuide"];
}

/**
 * Gets the super horiz guide.
 * @returns {IonGuideLine*}
 */
- (IonGuideLine *)superHorizGuide {
    return [self.guides objectForKey: @"superHorizGuide"];
}

#pragma mark Local Vert

/**
 * Switch guide to manual KVO observation mode
 */
+ (BOOL) automaticallyNotifiesObserversOfLocalVertGuide { return FALSE; }

/**
 * Sets the vertical guide in the local pair.
 * @param guide - the new guide.
 */
- (void) setLocalVertGuide:(IonGuideLine*) guide {
    [self setGuide: guide forKey: @"localVertGuide"];
}

/**
 * The getter for local vert guide, if null it will return a static guide.
 */
- (IonGuideLine *)localVertGuide {
    IonGuideLine *localGuide = [self.guides objectForKey: @"localVertGuide"];
    if ( !localGuide )
        self.localVertGuide = localGuide = [IonGuideLine guideWithStaticValue: 0.0f];
    return localGuide;
}

#pragma mark Local Horiz

/**
 * Switch guide to manual KVO observation mode
 */
+ (BOOL) automaticallyNotifiesObserversOfLocalHorizGuide { return FALSE; }

/**
 * Sets the horizontal guide in the local pair.
 * @param guide - the new guide.
 */
- (void) setLocalHorizGuide:(IonGuideLine*) guide {
     [self setGuide: guide forKey: @"localHorizGuide"];
}

/**
 * The getter for local vert guide, if null it will return a static guide.
 */
- (IonGuideLine *)localHorizGuide {
    IonGuideLine *localGuide = [self.guides objectForKey: @"localHorizGuide"];
    if ( !localGuide )
        self.localHorizGuide = localGuide = [IonGuideLine guideWithStaticValue: 0.0f];
    return localGuide;
}

#pragma mark Size
/**
 * Switch guide to manual KVO observation mode
 */
+ (BOOL) automaticallyNotifiesObserversOfLeftSizeGuide { return FALSE; }

/**
 * Sets the left size guide.
 * @param guide - the new guide.
 */
- (void) setLeftSizeGuide:(IonGuideLine*) guide {
    [self setGuide: guide forKey: @"leftSizeGuide"];
}

/**
 * Gets the left size guide.
 * @returns {IonGuideLine*}
 */
- (IonGuideLine *)leftSizeGuide {
    return [self.guides objectForKey: @"leftSizeGuide"];
}

/**
 * Switch guide to manual KVO observation mode
 */
+ (BOOL) automaticallyNotifiesObserversOfRightSizeGuide{ return FALSE; }

/**
 * Sets the right size guide.
 * @param guide - the new guide.
 */
- (void) setRightSizeGuide:(IonGuideLine*) guide {
     [self setGuide: guide forKey: @"rightSizeGuide"];
}

/**
 * Gets the right size guide.
 * @returns {IonGuideLine*}
 */
- (IonGuideLine *)rightSizeGuide {
    return [self.guides objectForKey: @"rightSizeGuide"];
}

/**
 * Switch guide to manual KVO observation mode
 */
+ (BOOL) automaticallyNotifiesObserversOfTopSizeGuide{ return FALSE; }

/**
 * Sets the top size guide.
 * @param guide - the new guide.
 */
- (void) setTopSizeGuide:(IonGuideLine*) guide {
    [self setGuide: guide forKey: @"topSizeGuide"];
}

/**
 * Gets the top size guide.
 * @returns {IonGuideLine*}
 */
- (IonGuideLine *)topSizeGuide {
    return [self.guides objectForKey: @"topSizeGuide"];
}

/**
 * Switch guide to manual KVO observation mode
 */
+ (BOOL) automaticallyNotifiesObserversOfBottomSizeGuide { return FALSE; }

/**
 * Sets the bottom size guide.
 * @param guide - the new guide.
 */
- (void) setBottomSizeGuide:(IonGuideLine*) guide {
    [self setGuide: guide forKey: @"bottomSizeGuide"];
}

/**
 * Gets the bottom size guide.
 * @returns {IonGuideLine*}
 */
- (IonGuideLine *)bottomSizeGuide {
    return [self.guides objectForKey: @"bottomSizeGuide"];
}

#pragma mark Change Updates
/**
 * Updates the frame to match the current guides values.
 */
- (void) updateFrame {
    [self willChangeValueForKey: @"frame"];
    _frame = [self toRect];
    [self didChangeValueForKey: @"frame"];
    [self.localObservers invokeActionSetsInGroup: 0];
}

#pragma mark Local Observers
/**
 * Gets, or constructs the local observers list.
 */
- (IonTargetActionList *)localObservers {
    if ( !_localObservers )
        _localObservers = [[IonTargetActionList alloc] init];
    return _localObservers;
}

/**
 * Adds the target and action for guides position change updates.
 * @param target - the target to call the action on.
 * @param action the action to call on the target.
 */
- (void) addTarget:(id) target andAction:(SEL) action {
    [self.localObservers addTarget: target andAction: action toGroup: 0];
}

/**
 * Removes the target and action for guides position change updates.
 * @param target - the target to call the action on.
 * @param action - the action to call on the target.
 */
- (void) removeTarget:(id) target andAction:(SEL) action {
    [self.localObservers removeTarget: target andAction: action fromGroup: 0];
}



#pragma mark Retrieval

/**
 * Gets the origin position using the current guide pairs.
 * @returns {CGPoint}
 */
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

/**
 * Gets the size position using size current guides.
 * @returns {CGSize}
 */
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

/**
 * Gets the resulting rect for the inputted view, and current guides.
 * @returns {CGRect} the resulting rect
 */
- (CGRect) toRect {
    return (CGRect){ [self toPoint], [self toSize] };
}

/**
 * Debug description.
 */
- (NSString*) description {
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

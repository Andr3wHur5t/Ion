//
//  IonViewGuideSet.m
//  Ion
//
//  Created by Andrew Hurst on 8/22/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonViewGuideSet.h"
#import <IonData/IonData.h>

@interface IonViewGuideSet () {
    IonKeyValueObserver *sxObserver, *syObserver, *lxObserver, *lyObserver;
    
    IonGuideLine* _localVertGuide;
    IonGuideLine* _localHorizGuide;
    
    // Target action pair
    id _target;
    SEL _action;
}

@end

@implementation IonViewGuideSet


#pragma mark Super

/**
 * Sets the super pair to match the inputted guides.
 * @param {IonGuideLine*} the vertical guide line.
 * @param {IonGuideLine*} the horizontal guide line.
 * @returns {void}
 */
- (void) setSuperPairWithVert:(IonGuideLine*) vert andHoriz:(IonGuideLine*) horiz {
    NSParameterAssert( vert && [vert isKindOfClass: [IonGuideLine class]] );
    NSParameterAssert( horiz && [horiz isKindOfClass: [IonGuideLine class]] );
    if ( !vert || ! [vert isKindOfClass: [IonGuideLine class]] ||
        !horiz || ! [horiz isKindOfClass: [IonGuideLine class]])
        return;
    self.superVertGuide = vert;
    self.superHorizGuide = horiz;
}

#pragma mark Super Vert

/**
 * Switch guide to maual KVO observation mode
 */
+ (BOOL) automaticallyNotifiesObserversOfSuperVertGuide{ return FALSE; }

/**
 * Sets the vertical guide in the super pair.
 * @param {IonGuideLine*} the new guide.
 * @returne {void}
 */
- (void) setSuperVertGuide:(IonGuideLine*) guide {
    NSParameterAssert( guide && [guide isKindOfClass: [IonGuideLine class]] );
    if ( !guide || ! [guide isKindOfClass: [IonGuideLine class]])
        return;
    
    [self willChangeValueForKey: @"superVertGuide"];
    _superVertGuide = guide;
    [self didChangeValueForKey: @"superVertGuide"];
    
    syObserver = [IonKeyValueObserver observeObject: _superVertGuide
                                            keyPath: @"position"
                                             target: self
                                           selector: @selector(didChangeGuidePosition)];
}

#pragma mark Super Horiz

/**
 * Switch guide to maual KVO observation mode
 */
+ (BOOL) automaticallyNotifiesObserversOfSuperHorizGuide { return FALSE; }

/**
 * Sets the horizontal guide in the super pair.
 * @param {IonGuideLine*} the new guide.
 * @returne {void}
 */
- (void) setSuperHorizGuide:(IonGuideLine*) guide {
    NSParameterAssert( guide && [guide isKindOfClass: [IonGuideLine class]] );
    if ( !guide || ! [guide isKindOfClass: [IonGuideLine class]])
        return;
    
    [self willChangeValueForKey: @"superHorizGuide"];
    _superHorizGuide = guide;
    [self didChangeValueForKey: @"superHorizGuide"];
    
    sxObserver = [IonKeyValueObserver observeObject: _superHorizGuide
                                            keyPath: @"position"
                                             target: self
                                           selector: @selector(didChangeGuidePosition)];
}

#pragma mark Local

/**
 * Sets the local pair to match the inputted guides.
 * @param {IonGuideLine*} the vertical guide line.
 * @param {IonGuideLine*} the horizontal guide line.
 * @returns {void}
 */
- (void) setLocalPairWithVert:(IonGuideLine*) vert andHoriz:(IonGuideLine*) horiz {
    NSParameterAssert( vert && [vert isKindOfClass: [IonGuideLine class]] );
    NSParameterAssert( horiz && [horiz isKindOfClass: [IonGuideLine class]] );
    if ( !vert || ! [vert isKindOfClass: [IonGuideLine class]] ||
        !horiz || ! [horiz isKindOfClass: [IonGuideLine class]])
        return;
    
    self.localVertGuide = vert;
    self.localHorizGuide = horiz;
}

#pragma mark Local Vert

/**
 * Switch guide to maual KVO observation mode
 */
+ (BOOL) automaticallyNotifiesObserversOfLocalVertGuide { return FALSE; }

/**
 * Sets the vertical guide in the local pair.
 * @param {IonGuideLine*} the new guide.
 * @returne {void}
 */
- (void) setLocalVertGuide:(IonGuideLine*) guide {
    NSParameterAssert( guide && [guide isKindOfClass: [IonGuideLine class]] );
    if ( !guide || ! [guide isKindOfClass: [IonGuideLine class]])
        return;
    
    [self willChangeValueForKey: @"localVertGuide"];
    _localVertGuide = guide;
    [self didChangeValueForKey: @"localVertGuide"];
    
    lyObserver = [IonKeyValueObserver observeObject: _localVertGuide
                                            keyPath: @"position"
                                             target: self
                                           selector: @selector(didChangeGuidePosition)];
}

/**
 * The getter for local vert guide, if null it will retrun a static guide.
 */
- (IonGuideLine*) localVertGuide {
    if ( !_localVertGuide )
        self.localVertGuide = [IonGuideLine guideWithStaticValue:0.0];
    return _localVertGuide;
}

#pragma mark Local Horiz

/**
 * Switch guide to maual KVO observation mode
 */
+ (BOOL) automaticallyNotifiesObserversOfLocalHorizGuide { return FALSE; }

/**
 * Sets the horizontal guide in the local pair.
 * @param {IonGuideLine*} the new guide.
 * @returne {void}
 */
- (void) setLocalHorizGuide:(IonGuideLine*) guide {
    NSParameterAssert( guide && [guide isKindOfClass: [IonGuideLine class]] );
    if ( !guide || ! [guide isKindOfClass: [IonGuideLine class]])
        return;
    
    [self willChangeValueForKey: @"localHorizGuide"];
    _localHorizGuide = guide;
    [self didChangeValueForKey: @"localHorizGuide"];
    
    lxObserver = [IonKeyValueObserver observeObject: _localHorizGuide
                                            keyPath: @"position"
                                             target: self
                                           selector: @selector(didChangeGuidePosition)];
    
}

/**
 * The getter for local horiz guide, if null it will retrun a static guide.
 */
- (IonGuideLine*) localHorizGuide {
    if ( !_localHorizGuide )
        self.localHorizGuide = [IonGuideLine guideWithStaticValue:0.0];
    return _localHorizGuide;
}

#pragma mark Change Callback

/**
 * Sets the target and action for guides position change.
 * @param {id} the target to call the action on.
 * @param {SEL} the action to call on the target.
 * @returns {void}
 */
- (void) setTarget:(id) target andAction:(SEL) action {
    NSParameterAssert([target respondsToSelector: action]);
    if ( ![target respondsToSelector: action] )
        return;
    
    _target = target;
    _action = action;
}

/**
 * Respond to changes in guides' position
 * @returns {void}
 */
- (void) didChangeGuidePosition {
    // Call the target pair if it exsists
    if ( !_target || !_action )
        return;
    
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    if ( [_target respondsToSelector: _action] )
        [_target performSelector: _action];
    #pragma clang diagnostic pop
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
 * Gets the resulting rect for the inputted view, and current guides.
 * @param {UIView*} the view to get the rect for.
 * @returns {CGRect} the resulting rect
 */
- (CGRect) rectForView:(UIView*) view {
    NSParameterAssert( view && [view isKindOfClass:[UIView class]] );
    if ( !view || ![view isKindOfClass:[UIView class]] )
        return CGRectZero;
    return (CGRect){ [self toPoint], view.frame.size };
}

/**
 * Debug description.
 */
- (NSString*) description {
    CGPoint point = [self toPoint];
    return [NSString stringWithFormat: @"\nSup {X: %@, Y: %@}\nloc {X: %@, Y: %@}\nCalc {X: %f, Y: %f}\n",
                                    self.superHorizGuide, self.superVertGuide,
                                    self.localHorizGuide, self.localVertGuide,
                                    point.x, point.y];
}

@end

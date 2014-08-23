//
//  IonViewGuideSet.m
//  Ion
//
//  Created by Andrew Hurst on 8/22/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonViewGuideSet.h"


@implementation IonViewGuideSet


#pragma mark Setter Utilities.
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
}

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
}


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
}

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

@end

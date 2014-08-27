//
//  UIView+IonExternalGuides.m
//  Ion
//
//  Created by Andrew Hurst on 8/25/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "UIView+IonExternalGuides.h"
#import "UIView+IonGuideLine.h"

/**
 * Keys
 */
static NSString* sIonGuideLine_ExternalGuideGroup =   @"IonGuideLine_ExtarnalGuideGroup";

@implementation UIView (IonExternalGuides)
#pragma mark External Guide Group

/**
 * The External Guide Group.
 */
- (IonGuideGroup*) externalGuides {
    IonGuideGroup* obj = [self.cachedGuideLines objectForKey: sIonGuideLine_ExternalGuideGroup];
    if ( !obj ) {
        obj = [[IonGuideGroup alloc] initWithView: self];
        [self.cachedGuideLines setObject: obj forKey: sIonGuideLine_ExternalGuideGroup];
    }
    return obj;
}

#pragma mark  Origin
/**
 * External Vertical Internal Origin Guide Line
 */
- (IonGuideLine*) originGuideVertExternal {
    return self.externalGuides.internalOriginGuideVert;
}

/**
 * External Horizontal Internal Origin Guide Line
 */
- (IonGuideLine*) originGuideHorizExternal {
    return self.externalGuides.internalOriginGuideHoriz;
}
#pragma mark One Third
/**
 * External Vertical One Third Guide Line
 */
- (IonGuideLine*) oneThirdGuideVertExternal {
    return self.externalGuides.oneThirdGuideVert;
}

/**
 * External Horizontal One Third Guide Line
 */
- (IonGuideLine*) oneThirdGuideHorizExternal {
    return self.externalGuides.oneThirdGuideHoriz;
}

#pragma mark Center
/**
 * External Vertical Center Guide Line
 */
- (IonGuideLine*) centerGuideVertExternal {
    return self.externalGuides.centerGuideVert;
}

/**
 * External Horizontal Center Guide Line
 */
- (IonGuideLine*) centerGuideHorizExternal {
    return self.externalGuides.centerGuideHoriz;
}

#pragma mark Two Thirds
/**
 * External Vertical Two Thirds Guide Line
 */
- (IonGuideLine*) twoThirdsGuideVertExternal {
    return self.externalGuides.twoThirdsGuideVert;
}

/**
 * External Horizontal Two Thirds Guide Line
 */
- (IonGuideLine*) twoThirdsGuideHorizExternal {
    return self.externalGuides.twoThirdsGuideHoriz;
}

#pragma mark Full Size
/**
 * External Vertical Size Guide Line
 */
- (IonGuideLine*) sizeGuideVertExternal {
    return self.externalGuides.sizeGuideVert;
}

/**
 * External Horizontal  Size Guide Line
 */
- (IonGuideLine*) sizeGuideHorizExternal {
    return self.externalGuides.sizeGuideHoriz;
}



@end

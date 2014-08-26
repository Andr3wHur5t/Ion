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
        obj = [IonGuideGroup alloc]; // todo: set to observe the views frame
        [self.cachedGuideLines setObject: obj forKey: sIonGuideLine_ExternalGuideGroup];
    }
    return obj;
}

#pragma mark Guides

@end

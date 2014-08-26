//
//  UIView+IonExternalGuides.h
//  Ion
//
//  Created by Andrew Hurst on 8/25/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IonGuideGroup.h"

@interface UIView (IonExternalGuides)
#pragma mark External Guide Group

/**
 * The External Guide Group.
 */
@property (weak, nonatomic, readonly) IonGuideGroup* externalGuides;

#pragma mark Guides
@end

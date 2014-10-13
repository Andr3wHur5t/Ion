//
//  UIImage+IonImage.m
//  Ion
//
//  Created by Andrew Hurst on 8/7/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "UIImage+IonImage.h"
#import <objc/runtime.h>

static const char* sIonImageInfoObjectKey = "sIonImageInfoObject";

@implementation UIImage (IonImage)
#pragma mark Constructors
/**
 * Connivence constructor.
 * @param {NSDictionary*} the info associated with the image.
 */
- (instancetype) initWithInfo:(NSDictionary*) info {
    self = [self init];
    if ( self )
        [self setInfo: info];
    return self;
}

#pragma mark Loading Routines


#pragma mark Info object
/**
 * Sets arbitrary information pertaining to the image.
 * @param {NSDictionary*} info the info object to set.
 
 */
- (void) setInfo:(NSDictionary*) info {
    objc_setAssociatedObject( self, sIonImageInfoObjectKey, info, OBJC_ASSOCIATION_RETAIN_NONATOMIC );
}

/**
 * Gets arbitrary information pertaining to the image.
 * @returns {NSDictionary*}
 */
- (NSDictionary*) info {
    return objc_getAssociatedObject( self, sIonImageInfoObjectKey );
}

@end

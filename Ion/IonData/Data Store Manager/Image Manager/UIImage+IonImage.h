//
//  UIImage+IonImage.h
//  Ion
//
//  Created by Andrew Hurst on 8/7/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (IonImage)
#pragma mark Constructors
/**
 * Connivence constructor.
 * @param {NSDictionary*} the info associated with the image.
 */
- (instancetype) initWithInfo:(NSDictionary*) info;

#pragma mark Loading Routines


#pragma mark Properties
/**
 * Arbitrary information pertaining to the image.
 */
@property (strong, nonatomic) NSDictionary* info;

@end

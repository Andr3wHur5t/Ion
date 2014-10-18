//
//  IonIcon.h
//  Ion
//
//  Created by Andrew Hurst on 9/12/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonView.h"

static NSString *sIonIconViewKey = @"icon";
static NSString *sIonIconView_IconImage = @"iconImage";
static NSString *sIonIconView_IconSize = @"iconSize";

@interface IonIcon : IonView
#pragma mark Constructors
/**
 * Constructs the icon view with the specified image.
 * @param {UIImage*} the icon.
 */
- (instancetype) initWithImage:(UIImage *)image;

/**
 * Constructs the icon view with the specified image.
 * @param {NSString*} the key for the image.
 */
- (instancetype) initWithImageKey:(NSString *)imageKey;

@end

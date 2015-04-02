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
/*!
 @brief Constructs the the icon view with the inputted image.

 @param image The image to set the Icon to.

 @return The resulting icon view.
 */
- (instancetype)initWithImage:(UIImage *)image;

/*!
 @brief Constructs the the icon view with the image for the inputted key.

 @param imageKey The key to set the icon to.

 @return The resulting icon view.
 */
- (instancetype)initWithImageKey:(NSString *)imageKey;

#pragma mark Configuration

/*!
 @brief The image to be used in the icon, This will be prioritized during style
 application.
 */
@property(strong, nonatomic, readwrite) UIImage *image;

/*!
 @brief The image key to be used for style application.
 */
@property(strong, nonatomic, readwrite) NSString *imageKey;

/*!
 @brief States if the style can set the size of the icon.
 */
@property(assign, nonatomic, readwrite) BOOL styleCanSetSize;

@end

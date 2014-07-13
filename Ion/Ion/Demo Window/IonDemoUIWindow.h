//
//  IonDemoUIWindow.h
//  Ion
//
//  Created by Andrew Hurst on 7/10/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IonDemoUIWindow : UIWindow


/**
 * This returns the singleton of the image that will be used for touch point representation.
 * @returns {UIImage*}
 */
+ (id)imageForTouchRepresentation;

@end

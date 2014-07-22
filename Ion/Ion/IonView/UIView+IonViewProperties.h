//
//  UIView+IonViewproperties.h
//  Ion
//
//  Created by Andrew Hurst on 7/20/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (IonViewProperties)

/**
 * This sets the corner radius of the view note this can cause "off screen render calls"
 * @param {CGFloat} the radius of the view to be masked out
 * @returns {void}
 */
- (void) setCornerRadius:(CGFloat) radius;

/**
 * This sets the drop shadow of the view.
 * @param {UIColor} the color of the drop shadow.
 * @param {CGFloat} the radius of the drop shadow.
 * @param {CGSize} the offset position of the drop shadow.
 * @return {void}
 */
- (void) setDropShadowWithColor:(UIColor*) color
                         radius:(CGFloat) radius
              andOffsetPosition:(CGSize) offset;

/**
 * This sets the border color, and width inline.
 * @param {UIColor*} the color to set the border
 * @param {CGFloat} the width to set the border
 * @returns {void}
 */
- (void) setBorderColor:(UIColor*) color andWidth:(CGFloat) width;
@end

//
//  UITouch + IonDemoWindowTouchRepresentation.h
//  Ion
//
//  Created by Andrew Hurst on 7/10/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITouch (IonDemoTouch)

/**
 * This is the view which represents the position of the touch point.
 */
@property (nonatomic, strong) UIView *touchRepresentationView;

/**
 * This centers the representitive view on the center of the touch point
 * @returns {void}
 */
- (void) centerRepresentation;

@end
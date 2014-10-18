//
//  UIView+IonViewproperties.h
//  Ion
//
//  Created by Andrew Hurst on 7/20/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (IonViewProperties)
#pragma mark Theme Attributes
/**
 * Holds our arbritary theme parameters.
 */
@property (strong, nonatomic, readonly) NSMutableDictionary* themeAttributes;

#pragma mark Corner Radius

/**
 * The corner radius of the view.
 * @warning Can cause "off screen render calls", will turn on is masking, and will remove drop shadow.
 */
@property (assign, nonatomic) CGFloat cornerRadius;

#pragma mark Drop Shadow

/**
 * The drop shadow color.
 * @warning won't work with corer radius, or masking.
 */
@property (weak, nonatomic) UIColor* shadowColor;

/**
 * The drop shadow offset.
 * @warning won't work with corer radius, or masking.
 */
@property (assign, nonatomic) CGSize shadowOffset;

/**
 * The drop shadow radius.
 * @warning won't work with corer radius, or masking.
 */
@property (assign, nonatomic) CGFloat shadowRadius;

#pragma mark Border Property

/**
 * The color of the border.
 */
@property (weak, nonatomic) UIColor* borderColor;

/**
 * The width of the border.
 */
@property (assign, nonatomic) CGFloat borderWidth;

@end

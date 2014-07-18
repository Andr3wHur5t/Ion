//
//  IonColorWeight.h
//  Ion
//
//  Created by Andrew Hurst on 7/13/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IonThemeAttributes.h"

/**
 * ==================== Ion Color Weight ====================
 */

@interface IonColorWeight : NSObject

- (instancetype) initWithColor:(UIColor*) color andWeight:(CGFloat) weight;

@property (strong, nonatomic) UIColor* color;
@property (assign, nonatomic) CGFloat weight;

@end


/**
 * ==================== Ion Gradient Configuration ====================
 */

@interface IonGradientConfiguration : NSObject

+ (IonGradientConfiguration*) resolveWithMap:(NSDictionary*) map andAttrubutes:(IonThemeAttributes*) attributes;

- (instancetype) initWithColorWeights:(NSArray*) colorWeights;

@property (strong, nonatomic) NSArray* colorWeights;

@end

/**
 * ==================== Ion Linear Gradient Configuration ====================
 */

@interface IonLinearGradientConfiguration : IonGradientConfiguration

- (instancetype) initWithColor:(NSArray*) colorWeights andAngel:(CGFloat) angle;

@property (assign, nonatomic) CGFloat angle;

@end
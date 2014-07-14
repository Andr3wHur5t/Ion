//
//  IonColorWeight.m
//  Ion
//
//  Created by Andrew Hurst on 7/13/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonGradientConfiguration.h"
#import "IonMath.h"


/**
 * ==================== Ion Color Weight ====================
 */

@implementation IonColorWeight

- (instancetype)init {
    self = [super init];
    if (self) {
        self.color = [UIColor purpleColor];
        self.weight = 0.0f;
    }
    return self;
}

- (instancetype) initWithColor:(UIColor*)color andWeight:(CGFloat)weight {
    self = [super init];
    if( self ) {
        self.color = color;
        self.weight = weight;
    }
    return self;
}

/**
 * This is the setter for weight, this claps the value between 0.0f and 1.0f
 * @param {CGFloat} the new weight
 * @returns {void}
 */
- (void) setWeight:(CGFloat)weight {
    _weight = CLAMP(weight, 0.0f, 1.0f);
}

@end

/**
 * ==================== Ion Gradient Configuration ====================
 */

@implementation IonGradientConfiguration

- (instancetype)init {
    return [self initWithColorWeights:[IonGradientConfiguration defaultColorConfiguration]];
}

- (instancetype) initWithColorWeights:(NSArray*)colorWeights {
    self = [super init];
    if (self)
        self.colorWeights = colorWeights;
    return self;
}


/**
 * This is the default color configuration we will start with.
 * @returns {NSArray*} of color weights
 */
+ (NSArray*) defaultColorConfiguration {
    NSMutableArray* arr = [[NSMutableArray alloc] init];
    
    [arr addObject:[[IonColorWeight alloc] initWithColor:[UIColor redColor] andWeight:0.0]];
    [arr addObject:[[IonColorWeight alloc] initWithColor:[UIColor blackColor] andWeight:0.5]];
    [arr addObject:[[IonColorWeight alloc] initWithColor:[UIColor purpleColor] andWeight:1.0]];
    
    return arr;
}

@end

/**
 * ==================== Ion Linear Gradient Configuration ====================
 */


@implementation IonLinearGradientConfiguration

- (instancetype)init {
    self = [super init];
    
    if (self)
        self.angle = M_PI/2;
    
    return self;
}

- (instancetype) initWithColor:(NSArray*)colorWeights andAngel:(CGFloat)angle {
    self = [super initWithColorWeights:colorWeights];
    if (self)
        self.angle = angle;
    
    return self;
}

@end



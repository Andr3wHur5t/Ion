//
//  IonColorWeight.m
//  Ion
//
//  Created by Andrew Hurst on 7/13/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonGradientConfiguration.h"
#import "IonMath.h"
#import "UIColor+IonColor.h"


/**
 * ==================== Ion Color Weight ====================
 */

static const NSString* sColorKey =  @"color";
static const NSString* sWeightKey = @"weight";

@implementation IonColorWeight

- (instancetype) init {
    self = [super init];
    if (self) {
        self.color = [UIColor purpleColor];
        self.weight = 0.0f;
    }
    return self;
}

- (instancetype) initWithColor:(UIColor*) color andWeight:(CGFloat) weight {
    self = [super init];
    if( self ) {
        self.color = color;
        self.weight = weight;
    }
    return self;
}

/**
 * This creates a color weight set using a NSDictionary configuration.
 * if any data is invalid it will return NULL.
 */
- (instancetype) initWithConfiguration:(NSDictionary*) config {
    id unverifiedColor, unverifiedWeight;
    UIColor* color;
    CGFloat weight;
    
    if ( !unverifiedColor || !unverifiedWeight )
        return NULL;
    
    if ( [unverifiedColor isKindOfClass:[UIColor class]] ) {
        color = (UIColor*) unverifiedColor;
    } else {
        return NULL;
    }
    
    if ( [unverifiedWeight isKindOfClass:[NSNumber class]] ) {
        weight = [(NSNumber*)unverifiedWeight floatValue];
    } else {
        return NULL;
    }
    
    return [self initWithColor:color andWeight:weight];
}

/**
 * This is the setter for weight, this claps the value between 0.0f and 1.0f
 * @param {CGFloat} the new weight
 * @returns {void}
 */
- (void) setWeight:(CGFloat) weight {
    _weight = CLAMP(weight, 0.0f, 1.0f);
}

- (NSString*) description {
    return [NSString stringWithFormat:@"{Color: %@, Weight:%f}",[_color toHex],_weight];
}


@end

/**
 * ==================== Ion Gradient Configuration ====================
 */

@implementation IonGradientConfiguration

- (instancetype)init {
    return [self initWithColorWeights:[IonGradientConfiguration defaultColorConfiguration]];
}

- (instancetype) initWithColorWeights:(NSArray*) colorWeights {
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

- (NSString*) description {
    return [NSString stringWithFormat:@"ColorWeights: %@",_colorWeights];
}

@end

/**
 * ==================== Ion Linear Gradient Configuration ====================
 */


@implementation IonLinearGradientConfiguration

- (instancetype) init {
    self = [super init];
    
    if (self)
        self.angle = M_PI/2;
    
    return self;
}

- (instancetype) initWithColor:(NSArray*) colorWeights andAngel:(CGFloat) angle {
    self = [super initWithColorWeights:colorWeights];
    
    if (self)
        self.angle = angle;
    
    return self;
}

- (NSString*) description {
    return [NSString stringWithFormat:@"\n{Angle:%f, %@}\n",RadiansToDegrees( _angle ), [super description]];
}

@end



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



/** Gradient Sub Keys
 */
static const NSString* sGradientTypeKey = @"type";

static const NSString* sGradientColorWeightsKey = @"colorWeights";
static const NSString* sGradientColorKey = @"color";
static const NSString* sGradientWeightKey = @"weight";

static const NSString* sGradientLinearKey = @"linear";
static const NSString* sGradientLinearAngleKey = @"angle";
static const CGFloat   sGradientLinearAngleDefault = 90.0f;


/**
 * ==================== Ion Color Weight ====================
 */

@implementation IonColorWeight

/**
 * This generates the color weight array from the inputted gradient map.
 * @param {NSDictionary*} the gradient map.
 * @returns {NSArray} the resulting color weight array, or NULL if invalid.
 */
+ (NSArray*) colorWeightArrayFromMap:(NSDictionary*) map andAttrubutes:(IonThemeAttributes*) attributes {
    NSMutableArray* resultArray;
    IonColorWeight* colorWeight;
    NSArray* kvpColorWeightsUnverified;
    if ( !map )
        return NULL;
    // Get Values
    resultArray = [[NSMutableArray alloc] init];
    kvpColorWeightsUnverified = [map objectForKey:sGradientColorWeightsKey];
    
    // Verify status of kvpColorWeightsUnverified
    if ( !kvpColorWeightsUnverified )
        return NULL;
    
    
    // Go through each map item to verify them, and add them.
    for ( NSDictionary* map in kvpColorWeightsUnverified ) {
        colorWeight = [IonColorWeight colorWeightFromMap: map andAttrubutes: attributes];
        if ( !colorWeight )
            break;
        
        [resultArray addObject: colorWeight];
    }
    
    return resultArray;
}


/**
 * This generates the color weight array from the inputted gradient map.
 * @param {NSDictionary*} the gradient map.
 * @returns {NSArray} the resulting color weight array, or NULL if invalid.
 */
+ (IonColorWeight*) colorWeightFromMap:(NSDictionary*) map andAttrubutes:(IonThemeAttributes*) attributes {
    IonColorWeight* result;
    NSString* colorString;
    NSNumber* weight;
    UIColor* color;
    
    if ( !map )
        return NULL;
    
    // Get values
    colorString = [map objectForKey:sGradientColorKey];
    weight = [map objectForKey:sGradientWeightKey];
    if ( !colorString || !weight )
        return NULL;
    
    color = [attributes resolveColorAttrubute: colorString];
    if ( !color )
        return NULL;
    
    result = [[IonColorWeight alloc] initWithColor: color andWeight: [weight floatValue]];
    
    return result;
}




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

+ (IonGradientConfiguration*) resolveWithMap:(NSDictionary*) map andAttrubutes:(IonThemeAttributes*) attributes {
    IonGradientConfiguration* result;
    NSString* type;
    
    if ( !map )
        return NULL;
    
    if ( ![map isKindOfClass:[NSDictionary class]] )
        return NULL;
    
    // Get the Keys
    type = [map objectForKey:sGradientTypeKey] ;
    if ( !type )
        return NULL;
    if ( ![type isKindOfClass:[NSString class]] )
        return NULL;
    
    
    // Add More Gradients here
    if ( [type.lowercaseString isEqualToString: sGradientLinearKey.lowercaseString] )
        result =  [IonLinearGradientConfiguration resolveWithMap: map andAttrubutes: attributes];
    else
        result = [IonLinearGradientConfiguration resolveWithMap: map andAttrubutes: attributes];
    if ( !result )
        return NULL;
    
    return result;
}




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

+ (IonLinearGradientConfiguration*) resolveWithMap:(NSDictionary*) map
                                     andAttrubutes:(IonThemeAttributes*) attributes {
    IonLinearGradientConfiguration* result;
    NSNumber* intermedeateAngle;
    NSArray* colorWeights;
    if ( !map )
        return NULL;
    
    result = [[IonLinearGradientConfiguration alloc] init];
    if ( !result )
        return NULL;
    
    // Get the angle
    intermedeateAngle = [map objectForKey: sGradientLinearAngleKey];
    if ( !intermedeateAngle )
        result.angle = DegreesToRadians( sGradientLinearAngleDefault );
    else
        result.angle = DegreesToRadians( [intermedeateAngle floatValue] );
    
    colorWeights = [IonColorWeight colorWeightArrayFromMap: map andAttrubutes: attributes];
    if ( !colorWeights )
        return NULL;
    
    // Set the color weights
    result.colorWeights = colorWeights;
    
    return result;
}

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



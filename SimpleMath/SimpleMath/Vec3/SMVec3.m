//
//  SMVec3.m
//  SimpleMath
//
//  Created by Andrew Hurst on 10/10/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "SMVec3.h"
#import <FOUtilities/FOUtilities.h>
#import "SMUtilities.h"

@implementation SMVec3
#pragma mark Constructors

- (instancetype) initWithX:(CGFloat) x Y:(CGFloat) y andZ:(CGFloat) z {
    self = [super init];
    if ( self ) {
        _x = x;
        _y = y;
        _z = z;
    }
    return self;
}

- (instancetype) initWithVector:(SMVec3 *)vector {
    NSParameterAssert( [vector isKindOfClass: [SMVec3 class]] );
    if ( ![vector isKindOfClass: [SMVec3 class]] )
        return NULL;
    return [self initWithX: vector.x Y: vector.y andZ: vector.z];
}

- (instancetype) initWithDictionary:(NSDictionary *)configuration {
    NSParameterAssert( [configuration isKindOfClass: [NSDictionary class]] );
    if ( ![configuration isKindOfClass: [NSDictionary class]] )
        return NULL;
    
    NSNumber *x, *y, *z;
    self = [self init];
    if ( self ) {
        // Get X
        x = [configuration numberForKey: sSMVec3_XKey];
        if ( !x )
            x = [configuration numberForKey: sSMVec3_PitchKey];
        if ( !x )
            return NULL;
        
        // Get Y
        y = [configuration numberForKey: sSMVec3_YKey];
        if ( !y )
            y = [configuration numberForKey: sSMVec3_YawKey];
        if ( !y )
            return NULL;
        
        // Get Z
        z = [configuration numberForKey: sSMVec3_ZKey];
        if ( !z )
            z = [configuration numberForKey: sSMVec3_RollKey];
        if ( !z )
            return NULL;
        
        // Set
        _x = [x floatValue];
        _y = [y floatValue];
        _z = [z floatValue];
    }
    return self;
}

+ (instancetype) vectorWithX:(CGFloat)x Y:(CGFloat)y andZ:(CGFloat)z {
    return [[SMVec3 alloc] initWithX: x Y: y andZ: z];
}

+ (instancetype) vectorWithRoll:(CGFloat) roll pitch:(CGFloat) pitch andYaw:(CGFloat) yaw {
    return [[SMVec3 alloc] initWithX: pitch Y: yaw andZ: roll];
}



+ (instancetype) vectorWithRoll:(CGFloat) roll andYaw:(CGFloat) yaw {
    return [SMVec3 vectorWithRoll: roll pitch: 0.0f andYaw: yaw];
}

+ (instancetype) vectorWithRoll:(CGFloat) roll {
    return [SMVec3 vectorWithRoll: roll pitch: 0.0f andYaw: 0.0f];
}

+ (instancetype) vectorWithYaw:(CGFloat) yaw  {
    return [SMVec3 vectorWithRoll: 0.0f pitch: 0.0f andYaw: yaw];
}

+ (instancetype) vectorWithPitch:(CGFloat) pitch  {
    return [SMVec3 vectorWithRoll: 0.0f pitch: pitch andYaw: 0.0f];
}

#pragma mark Constants

+ (instancetype) vectorZero {
    return [[SMVec3 alloc] initWithX: 0.0f Y: 0.0f andZ: 0.0f];
}

+ (instancetype) vectorOne {
    return [[SMVec3 alloc] initWithX: 1.0f Y: 1.0f andZ: 1.0f];
}

#pragma mark Arithmetic

- (instancetype) addedBy:(SMVec3 *)otherVector {
    NSParameterAssert( [otherVector isKindOfClass: [SMVec3 class]] );
    if ( ![otherVector isKindOfClass: [SMVec3 class]] )
        return NULL;
    return [[SMVec3 alloc] initWithX: self.x + otherVector.x
                                   Y: self.y + otherVector.y
                                andZ: self.z + otherVector.z];
}

- (instancetype) subtractedBy:(SMVec3 *)otherVector {
    NSParameterAssert( [otherVector isKindOfClass: [SMVec3 class]] );
    if ( ![otherVector isKindOfClass: [SMVec3 class]] )
        return NULL;
    return [[SMVec3 alloc] initWithX: self.x - otherVector.x
                                   Y: self.y - otherVector.y
                                    andZ: self.z - otherVector.z];
}

- (instancetype) multiplyBy:(SMVec3 *)otherVector {
    NSParameterAssert( [otherVector isKindOfClass: [SMVec3 class]] );
    if ( ![otherVector isKindOfClass: [SMVec3 class]] )
        return NULL;
    return [[SMVec3 alloc] initWithX: self.x * otherVector.x
                                   Y: self.y * otherVector.y
                                andZ: self.z * otherVector.z];
}

- (instancetype) divideBy:(SMVec3 *)otherVector {
    NSParameterAssert( [otherVector isKindOfClass: [SMVec3 class]] );
    if ( ![otherVector isKindOfClass: [SMVec3 class]] )
        return NULL;
    return [[SMVec3 alloc] initWithX: self.x / otherVector.x
                                   Y: self.y / otherVector.y
                                andZ: self.z / otherVector.z];
}


#pragma mark Comparison

- (BOOL) isEqualToVector:(SMVec3 *)otherVector {
    if ( ![otherVector isKindOfClass: [SMVec3 class]] )
        return FALSE;
    return self.x == otherVector.x && self.y == otherVector.y && self.z == otherVector.z;
}

#pragma mark Normalization

- (instancetype) normalizedRotationalVector {
    return [[SMVec3 alloc] initWithX: DegreesToRadians([SMUtilities normalizeRadialFloat: self.x])
                                   Y: DegreesToRadians([SMUtilities normalizeRadialFloat: self.y])
                                andZ: DegreesToRadians([SMUtilities normalizeRadialFloat: self.z])];
}

#pragma mark Transform Conversion

- (CATransform3D) toRotationTransform {
    CATransform3D transform;
    
    // Add perspective
    transform = [SMUtilities setTransformPerspective: transform];
    
    // Make the transform
    transform = CATransform3DMakeRotation(     DegreesToRadians(_x), 1.0f, 0.0f, 0.0f);
    transform = CATransform3DRotate(transform, DegreesToRadians(_y), 0.0f, 1.0f, 0.0f);
    transform = CATransform3DRotate(transform, DegreesToRadians(_z), 0.0f, 0.0f, 1.0f);
    
    // Return the result
    return transform;
}

- (CATransform3D) toPositionTransform {
    CATransform3D transform;
    
    // Add perspective
    transform = [SMUtilities setTransformPerspective: transform];
    
    // Make the transform
    transform = CATransform3DMakeTranslation( _x, _y, _z);
    
    // Return the result
    return transform;
}

- (CATransform3D) toScaleTransform {
    CATransform3D transform;
    
    // Add perspective
    transform = [SMUtilities setTransformPerspective: transform];
    
    // Make the transform
    transform = CATransform3DMakeScale( _x, _y, _z );
    
    // Return the result
    return transform;
}

#pragma mark Conversion

- (NSString *)toString {
    return [[self toDictionary] toJSON];
}

- (NSString *)toRotationalString {
    return [[self toRotationalDictionary] toJSON];
}

- (NSDictionary *)toRotationalDictionary {
    return @{
             sSMVec3_PitchKey:  [NSNumber numberWithDouble: _x],
             sSMVec3_YawKey:    [NSNumber numberWithDouble: _y],
             sSMVec3_RollKey:   [NSNumber numberWithDouble: _z]
             };
}

- (NSDictionary *)toDictionary {
    return @{
             sSMVec3_XKey:  [NSNumber numberWithDouble: _x],
             sSMVec3_YKey:  [NSNumber numberWithDouble: _y],
             sSMVec3_ZKey:  [NSNumber numberWithDouble: _z]
             };
}

#pragma mark Debug

- (NSString*) description {
    return [self toString];
}


@end



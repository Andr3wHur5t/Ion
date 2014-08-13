//
//  IonVec3.m
//  Ion
//
//  Created by Andrew Hurst on 8/11/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonVec3.h"
#import "NSDictionary+IonTypeExtension.h"

@implementation IonVec3

#pragma mark Constructors

/**
 * Constructs a Vec3 using the inputed XYZ axis.
 * @param {CGFloat} X the x axis of the vector.
 * @param {CGFloat} Y the y axis of the vector.
 * @param {CGFloat} Z the z axis of the vector.
 * @returns {instancetype}
 */
- (instancetype) initWithX:(CGFloat)x Y:(CGFloat)y andZ:(CGFloat)z {
    self = [super init];
    if ( self ) {
        _x = x;
        _y = y;
        _z = z;
    }
    return self;
}

/**
 * Constructs a Vec3 Using the inputed vector.
 * @param {IonVec3*} the vector to base our self off of.
 * @returns {instancetype}
 */
- (instancetype) initWithVector:(IonVec3*) vector {
    if ( !vector || ![vector isKindOfClass: [IonVec3 class]] )
        return NULL;
    return [self initWithX: vector.x Y: vector.y andZ: vector.z];
}

/**
 * Constructs a Vec3 from the inputted dictionary.
 * @param {NSDictionary*} the dictionary to create with.
 * @retutns {instancetype}
 */
- (instancetype) initWithDictionary:(NSDictionary*) configuration {
    NSNumber *x, *y, *z;
    self = [self init];
    if ( self ) {
        // Get X
        x = [configuration numberForKey: sIonVec3_XKey];
        if ( !x )
            x = [configuration numberForKey: sIonVec3_PitchKey];
        if ( !x )
            return NULL;
        
        // Get Y
        y = [configuration numberForKey: sIonVec3_YKey];
        if ( !y )
            y = [configuration numberForKey: sIonVec3_YawKey];
        if ( !y )
            return NULL;
        
        // Get Z
        z = [configuration numberForKey: sIonVec3_ZKey];
        if ( !z )
            z = [configuration numberForKey: sIonVec3_RollKey];
        if ( !z )
            return NULL;
        
        // Set
        _x = [x floatValue];
        _y = [y floatValue];
        _z = [z floatValue];
    }
    return self;
}

/**
 * Constructs a Vec3 using the inputed XYZ axis.
 * @param {CGFloat} X the x axis of the vector.
 * @param {CGFloat} Y the y axis of the vector.
 * @param {CGFloat} Z the z axis of the vector.
 * @returns {IonVec3*}
 */
+ (IonVec3*) vectorWithX:(CGFloat)x Y:(CGFloat)y andZ:(CGFloat)z {
    return [[IonVec3 alloc] initWithX: x Y: y andZ: z];
}

/**
 * Constructs a Vec3 using the inputed roll, pitch, and yaw.
 * @param {CGFloat} roll axis of the vector.
 * @param {CGFloat} pitch axis of the vector.
 * @param {CGFloat} yaw axis of the vector.
 * @returns {IonVec3*}
 */
+ (IonVec3*) vectorWithRoll:(CGFloat) roll pitch:(CGFloat) pitch andYaw:(CGFloat) yaw {
    return [[IonVec3 alloc] initWithX: pitch Y: yaw andZ: roll];
}


/**
 * Constructs a Vec3 using the inputed roll, and yaw.
 * @param {CGFloat} roll axis of the vector.
 * @param {CGFloat} yaw axis of the vector.
 * @returns {IonVec3*}
 */
+ (IonVec3*) vectorWithRoll:(CGFloat) roll andYaw:(CGFloat) yaw {
    return [IonVec3 vectorWithRoll: roll pitch: 0.0f andYaw: yaw];
}

/**
 * Constructs a Vec3 using the inputed roll.
 * @param {CGFloat} roll axis of the vector.
 * @returns {IonVec3*}
 */
+ (IonVec3*) vectorWithRoll:(CGFloat) roll {
    return [IonVec3 vectorWithRoll: roll pitch: 0.0f andYaw: 0.0f];
}

/**
 * Constructs a Vec3 using the inputed yaw.
 * @param {CGFloat} yaw axis of the vector.
 * @returns {IonVec3*}
 */
+ (IonVec3*) vectorWithYaw:(CGFloat) yaw  {
    return [IonVec3 vectorWithRoll: 0.0f pitch: 0.0f andYaw: yaw];
}

/**
 * Constructs a Vec3 using the inputed pitch.
 * @param {CGFloat} pitch axis of the vector.
 * @returns {IonVec3*}
 */
+ (IonVec3*) vectorWithPitch:(CGFloat) pitch  {
    return [IonVec3 vectorWithRoll: 0.0f pitch: pitch andYaw: 0.0f];
}

#pragma mark Constants

/**
 * Constructs a Vec3 which is zeroed out.
 * @return {IonVec3*}
 */
+ (IonVec3*) vectorZero {
    return [[IonVec3 alloc] initWithX: 0.0f Y: 0.0f andZ: 0.0f];
}

/**
 * Constructs a Vec3 representing a all one values.
 * @return {IonVec3*}
 */
+ (IonVec3*) vectorOne {
    return [[IonVec3 alloc] initWithX: 1.0f Y: 1.0f andZ: 1.0f];
}

#pragma mark Arithmetic

/**
 * Adds the current vector, and the other vector together.
 * @param {IonVec3*} the other vector to add
 * @returns {IonVec3*}
 */
- (IonVec3*) addedBy:(IonVec3 *)otherVector {
    if ( !otherVector || ![otherVector isKindOfClass: [IonVec3 class]] )
        return NULL;
    return [[IonVec3 alloc] initWithX: self.x + otherVector.x
                                    Y: self.y + otherVector.y
                                 andZ: self.z + otherVector.z];
}

/**
 * Subtracts the current vector with the other vector.
 * @param {IonVec3*} the other vector to subtract by.
 * @returns {IonVec3*}
 */
- (IonVec3*) subtractedBy:(IonVec3 *)otherVector {
    if ( !otherVector || ![otherVector isKindOfClass: [IonVec3 class]] )
        return NULL;
    return [[IonVec3 alloc] initWithX: self.x - otherVector.x
                                    Y: self.y - otherVector.y
                                 andZ: self.z - otherVector.z];
}

/**
 * Multiplies the current vector with the other vector.
 * @param {IonVec3*} the other vector to multiply by.
 * @returns {IonVec3*}
 */
- (IonVec3*) multiplyBy:(IonVec3 *)otherVector {
    if ( !otherVector || ![otherVector isKindOfClass: [IonVec3 class]] )
        return NULL;
    return [[IonVec3 alloc] initWithX: self.x * otherVector.x
                                    Y: self.y * otherVector.y
                                 andZ: self.z * otherVector.z];
}

/**
 * Divides the current vector with the other vector.
 * @param {IonVec3*} the other vector to divide by.
 * @returns {IonVec3*}
 */
- (IonVec3*) divideBy:(IonVec3*)otherVector {
    if ( !otherVector || ![otherVector isKindOfClass: [IonVec3 class]] )
        return NULL;
    return [[IonVec3 alloc] initWithX: self.x / otherVector.x
                                    Y: self.y / otherVector.y
                                 andZ: self.z / otherVector.z];
}


#pragma mark Comparison

/**
 * Compares the current vector with the other vector.
 * @param {IonVec3*} the vector to compare to.
 * @returns {BOOL} true if the are equal.
 */
- (BOOL) isEqualToVector:(IonVec3*)otherVector {
    if ( !otherVector || ![otherVector isKindOfClass: [IonVec3 class]] )
        return FALSE;
    return self.x == otherVector.x && self.y == otherVector.y && self.z == otherVector.z;
}

#pragma mark Normalization

/**
 * Gets the normalized rotational vector, in radians from the current degree vector.
 * @returns {IonVec3*} the normalized rotational vector.
 */
- (IonVec3*) normalizedRotationalVector {
    return [[IonVec3 alloc] initWithX: DegreesToRadians([IonMath normalizeRadialFloat: self.x])
                                    Y: DegreesToRadians([IonMath normalizeRadialFloat: self.y])
                                 andZ: DegreesToRadians([IonMath normalizeRadialFloat: self.z])];
}

#pragma mark Transform Conversion

/**
 * Creates a transform which represents the the vectors' rotational value.
 * @returns {CATransform3D}
 */
- (CATransform3D) toRotationTransform {
    CATransform3D transform;
    
    // Add perspective
    transform = [IonMath setTransformPerspective: transform];
    
    // Make the transform
    transform = CATransform3DMakeRotation(     DegreesToRadians(_x), 1.0f, 0.0f, 0.0f);
    transform = CATransform3DRotate(transform, DegreesToRadians(_y), 0.0f, 1.0f, 0.0f);
    transform = CATransform3DRotate(transform, DegreesToRadians(_z), 0.0f, 0.0f, 1.0f);
    
    // Return the result
    return transform;
}

/**
 * Creates a transform which represents the the vectors' positional value.
 * @returns {CATransform3D}
 */
- (CATransform3D) toPositionTransform {
    CATransform3D transform;
    
    // Add perspective
    transform = [IonMath setTransformPerspective: transform];
    
    // Make the transform
    transform = CATransform3DMakeTranslation( _x, _y, _z);
    
    // Return the result
    return transform;
}

/**
 * Creates a transform which represents the the vectors' value as a scale.
 * @returns {CATransform3D}
 */
- (CATransform3D) toScaleTransform {
    CATransform3D transform;
    
    // Add perspective
    transform = [IonMath setTransformPerspective: transform];
    
    // Make the transform
    transform = CATransform3DMakeScale( _x, _y, _z);
    
    // Return the result
    return transform;
}

#pragma mark Conversion

/**
 * Gets the string representation of the vector.
 * @returns {NSString*}
 */
- (NSString*) toString {
    return [[self toDictionary] toJSON];
}

/**
 * Gets the rotational string representation of the vector.
 * @returns {NSString*}
 */
- (NSString*) toRotationalString {
    return [[self toRotationalDictionary] toJSON];
}

/**
 * Gets the rotational dictionary representation of the vector.
 * @returns {NSDictionary*}
 */
- (NSDictionary*) toRotationalDictionary {
    return @{
             sIonVec3_PitchKey: [NSNumber numberWithFloat: _x],
             sIonVec3_YawKey: [NSNumber numberWithFloat: _y],
             sIonVec3_RollKey: [NSNumber numberWithFloat: _z]
             };
}

/**
 * Gets the dictionary representation of the vector.
 * @returns {NSDictionary*}
 */
- (NSDictionary*) toDictionary {
    return @{
      sIonVec3_XKey: [NSNumber numberWithFloat: _x],
      sIonVec3_YKey: [NSNumber numberWithFloat: _y],
      sIonVec3_ZKey: [NSNumber numberWithFloat: _z]
      };
}

#pragma mark Debug

/**
 * The debug description.
 */
- (NSString*) description {
    return [self toString];
}

@end

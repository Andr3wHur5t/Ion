//
//  SMVec3.h
//  SimpleMath
//
//  Created by Andrew Hurst on 10/10/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMVec3 : NSObject
#pragma mark Constructors
/**
 * Constructs a Vec3 using the inputed XYZ axis. 
 * @param x - X the x axis of the vector.
 * @param y - Y the y axis of the vector.
 * @param z - Z the z axis of the vector.
 */
- (instancetype) initWithX:(CGFloat)x Y:(CGFloat)y andZ:(CGFloat)z;

/**
 * Constructs a Vec3 Using the inputed vector.
 * @param vector - the vector to base our self off of.
 */
- (instancetype) initWithVector:(SMVec3 *)vector;

/**
 * Constructs a Vec3 from the inputted dictionary.
 * @param configuration - the dictionary to create with.
 */
- (instancetype) initWithDictionary:(NSDictionary *)configuration;
/**
 * Constructs a Vec3 using the inputed XYZ axis.
 * @param x - X the x axis of the vector.
 * @param y - Y the y axis of the vector.
 * @param z - Z the z axis of the vector.
 */
+ (instancetype) vectorWithX:(CGFloat)x Y:(CGFloat)y andZ:(CGFloat)z;

/**
 * Constructs a Vec3 using the inputed roll, pitch, and yaw.
 * @param roll - roll axis of the vector.
 * @param pitch - pitch axis of the vector.
 * @param yaw - yaw axis of the vector.
 */
+ (instancetype) vectorWithRoll:(CGFloat) roll pitch:(CGFloat) pitch andYaw:(CGFloat) yaw;


/**
 * Constructs a Vec3 using the inputed roll, and yaw.
 * @param roll - roll axis of the vector.
 * @param yaw - yaw axis of the vector.
 */
+ (instancetype) vectorWithRoll:(CGFloat) roll andYaw:(CGFloat) yaw;

/**
 * Constructs a Vec3 using the inputed roll.
 * @param roll - roll axis of the vector.
 */
+ (instancetype) vectorWithRoll:(CGFloat) roll;

/**
 * Constructs a Vec3 using the inputed yaw.
 * @param yaw - yaw axis of the vector.
 */
+ (instancetype) vectorWithYaw:(CGFloat) yaw;

/**
 * Constructs a Vec3 using the inputed pitch.
 * @param pitch - pitch axis of the vector.
 */
+ (instancetype) vectorWithPitch:(CGFloat) pitch;

#pragma mark Constants

/**
 * Constructs a Vec3 which is zeroed out.
 * @return {IonVec3*}
 */
+ (instancetype) vectorZero;
/**
 * Constructs a Vec3 representing a all one values.
 * @return {IonVec3*}
 */
+ (instancetype) vectorOne;

#pragma mark proprieties
/**
 * The x axis of the vector.
 */
@property (assign, readonly) CGFloat x;

/**
 * The y axis of the vector.
 */
@property (assign, readonly) CGFloat y;

/**
 * The z axis of the vector.
 */
@property (assign, readonly) CGFloat z;

#pragma mark Arithmetic

/**
 * Adds the current vector, and the other vector together.
 * @param otherVector - the other vector to add
 */
- (instancetype) addedBy:(SMVec3 *)otherVector;

/**
 * Subtracts the current vector with the other vector.
 * @param otherVector - the other vector to subtract by.
 */
- (instancetype) subtractedBy:(SMVec3 *)otherVector;

/**
 * Multiplies the current vector with the other vector.
 * @param otherVector - the other vector to multiply by.
 */
- (instancetype) multiplyBy:(SMVec3 *)otherVector;

/**
 * Divides the current vector with the other vector.
 * @param otherVector - the other vector to divide by.
 */
- (instancetype) divideBy:(SMVec3 *)otherVector;


#pragma mark Comparison

/**
 * Compares the current vector with the other vector.
 * @param otherVector - the vector to compare to.
 * @returns TRUE if the are equal, otherwise FALSE.
 */
- (BOOL) isEqualToVector:(SMVec3 *)otherVector;

#pragma mark Normalization

/**
 * Gets the normalized rotational vector, in radians from the current degree vector.
 * @returns {IonVec3*} the normalized rotational vector.
 */
- (instancetype) normalizedRotationalVector;

#pragma mark Transform Conversion

/**
 * Creates a transform which represents the the vectors' rotational value.
 */
- (CATransform3D) toRotationTransform;

/**
 * Creates a transform which represents the the vectors' positional value.
 */
- (CATransform3D) toPositionTransform;
/**
 * Creates a transform which represents the the vectors' value as a scale.
 */
- (CATransform3D) toScaleTransform;

#pragma mark Conversion
/**
 * Gets the string representation of the vector.
 */
- (NSString *)toString;

/**
 * Gets the rotational string representation of the vector.
 */
- (NSString *)toRotationalString;

/**
 * Gets the rotational dictionary representation of the vector.
 */
- (NSDictionary *)toRotationalDictionary;

/**
 * Gets the dictionary representation of the vector.
 */
- (NSDictionary *)toDictionary;

@end

#pragma mark Keys
static NSString *sSMVec3_XKey = @"x";
static NSString *sSMVec3_YKey = @"y";
static NSString *sSMVec3_ZKey = @"z";

static NSString *sSMVec3_PitchKey = @"pitch";
static NSString *sSMVec3_RollKey = @"roll";
static NSString *sSMVec3_YawKey = @"yaw";

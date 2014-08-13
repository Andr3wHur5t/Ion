//
//  IonVec3.h
//  Ion
//
//  Created by Andrew Hurst on 8/11/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonMath.h"

/**
 * Keys
 */
static NSString* sIonVec3_XKey = @"x";
static NSString* sIonVec3_YKey = @"y";
static NSString* sIonVec3_ZKey = @"z";

static NSString* sIonVec3_PitchKey = @"pitch";
static NSString* sIonVec3_RollKey = @"roll";
static NSString* sIonVec3_YawKey = @"yaw";

@interface IonVec3 : NSObject
#pragma mark Constructors
/**
 * Constructs a Vec3 using the inputed XYZ axis.
 * @param {CGFloat} X the x axis of the vector.
 * @param {CGFloat} Y the y axis of the vector.
 * @param {CGFloat} Z the z axis of the vector.
 * @returns {instancetype}
 */
- (instancetype) initWithX:(CGFloat)x Y:(CGFloat)y andZ:(CGFloat)z;

/**
 * Constructs a Vec3 Using the inputed vector.
 * @param {IonVec3*} the vector to base our self off of.
 * @returns {instancetype}
 */
- (instancetype) initWithVector:(IonVec3*) vector;

/**
 * Constructs a Vec3 from the inputted dictionary.
 * @param {NSDictionary*} the dictionary to create with.
 * @retutns {instancetype}
 */
- (instancetype) initWithDictionary:(NSDictionary*) configuration;
/**
 * Constructs a Vec3 using the inputed XYZ axis.
 * @param {CGFloat} X the x axis of the vector.
 * @param {CGFloat} Y the y axis of the vector.
 * @param {CGFloat} Z the z axis of the vector.
 * @returns {IonVec3*}
 */
+ (IonVec3*) vectorWithX:(CGFloat)x Y:(CGFloat)y andZ:(CGFloat)z;

/**
 * Constructs a Vec3 using the inputed roll, pitch, and yaw.
 * @param {CGFloat} roll axis of the vector.
 * @param {CGFloat} pitch axis of the vector.
 * @param {CGFloat} yaw axis of the vector.
 * @returns {IonVec3*}
 */
+ (IonVec3*) vectorWithRoll:(CGFloat) roll pitch:(CGFloat) pitch andYaw:(CGFloat) yaw;


/**
 * Constructs a Vec3 using the inputed roll, and yaw.
 * @param {CGFloat} roll axis of the vector.
 * @param {CGFloat} yaw axis of the vector.
 * @returns {IonVec3*}
 */
+ (IonVec3*) vectorWithRoll:(CGFloat) roll andYaw:(CGFloat) yaw;

/**
 * Constructs a Vec3 using the inputed roll.
 * @param {CGFloat} roll axis of the vector.
 * @returns {IonVec3*}
 */
+ (IonVec3*) vectorWithRoll:(CGFloat) roll;

/**
 * Constructs a Vec3 using the inputed yaw.
 * @param {CGFloat} yaw axis of the vector.
 * @returns {IonVec3*}
 */
+ (IonVec3*) vectorWithYaw:(CGFloat) yaw;

/**
 * Constructs a Vec3 using the inputed pitch.
 * @param {CGFloat} pitch axis of the vector.
 * @returns {IonVec3*}
 */
+ (IonVec3*) vectorWithPitch:(CGFloat) pitch;

#pragma mark Constants

/**
 * Constructs a Vec3 which is zeroed out.
 * @return {IonVec3*}
 */
+ (IonVec3*) vectorZero;
/**
 * Constructs a Vec3 representing a all one values.
 * @return {IonVec3*}
 */
+ (IonVec3*) vectorOne;

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
 * @param {IonVec3*} the other vector to add
 * @returns {IonVec3*}
 */
- (IonVec3*) addedBy:(IonVec3 *)otherVector;

/**
 * Subtracts the current vector with the other vector.
 * @param {IonVec3*} the other vector to subtract by.
 * @returns {IonVec3*}
 */
- (IonVec3*) subtractedBy:(IonVec3 *)otherVector;

/**
 * Multiplies the current vector with the other vector.
 * @param {IonVec3*} the other vector to multiply by.
 * @returns {IonVec3*}
 */
- (IonVec3*) multiplyBy:(IonVec3 *)otherVector;

/**
 * Divides the current vector with the other vector.
 * @param {IonVec3*} the other vector to divide by.
 * @returns {IonVec3*}
 */
- (IonVec3*) divideBy:(IonVec3*)otherVector;


#pragma mark Comparison

/**
 * Compares the current vector with the other vector.
 * @param {IonVec3*} the vector to compare to.
 * @returns {BOOL} true if the are equal.
 */
- (BOOL) isEqualToVector:(IonVec3*)otherVector;

#pragma mark Normalization

/**
 * Gets the normalized rotational vector, in radians from the current degree vector.
 * @returns {IonVec3*} the normalized rotational vector.
 */
- (IonVec3*) normalizedRotationalVector;

#pragma mark Transform Conversion

/**
 * Creates a transform which represents the the vectors' rotational value.
 * @returns {CATransform3D}
 */
- (CATransform3D) toRotationTransform;

/**
 * Creates a transform which represents the the vectors' positional value.
 * @returns {CATransform3D}
 */
- (CATransform3D) toPositionTransform;
/**
 * Creates a transform which represents the the vectors' value as a scale.
 * @returns {CATransform3D}
 */
- (CATransform3D) toScaleTransform;

#pragma mark Conversion

/**
 * Gets the string representation of the vector.
 * @returns {NSString*}
 */
- (NSString*) toString;
/**
 * Gets the rotational string representation of the vector.
 * @returns {NSString*}
 */
- (NSString*) toRotationalString;
/**
 * Gets the rotational dictionary representation of the vector.
 * @returns {NSDictionary*}
 */
- (NSDictionary*) toRotationalDictionary;

/**
 * Gets the dictionary representation of the vector.
 * @returns {NSDictionary*}
 */
- (NSDictionary*) toDictionary;

@end

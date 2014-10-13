//
//  PHProfile.h
//  PHData
//
//  Created by Andrew Hurst on 10/7/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    PHProfileGender_Masculine = 0,
    PHProfileGender_Feminine = 1
} PHProfileGender;


@interface PHProfile : NSObject
#pragma mark Meta
/**
 * The name of the profile.
 */
@property (strong, nonatomic, readwrite) NSString *name;

/**
 * The gender of the person.
 */
@property (assign, nonatomic, readwrite) PHProfileGender gender;

/**
 * The profile image name.
 */
@property (strong, nonatomic, readwrite) NSString* profileImageName;

#pragma mark Generation
/**
 * Constructs a random profile, with a random gender.
 */
+ (instancetype) randomProfile;

/**
 * Constructs a random profile using the inputted gender.
 */
+ (instancetype) randomProfileUsingGender:(PHProfileGender) gender;

/**
 * Creates an array of random profiles.
 * @param count - the number of profiles to generate.
 */
+ (NSArray *)randomProfilesWithCount:(NSUInteger) count;

#pragma mark Profile Image Names

/**
 * Registeres the inputted image names as masculine profile images so they can be used in random profile generation.
 * @param array - an array of profile images.
 */
+ (void) registerMasculineProfileImagesWithNames:(NSArray *)array;

/**
 * Registeres the inputted image names as feminine profile images so they can be used in random profile generation.
 * @param array - an array of profile images.
 */
+ (void) registerFeminineProfileImagesWithNames:(NSArray *)array;

#pragma mark Data

/**
 * Registered facebox profile image names.
 */
+ (void) registerFaceboxProfileImageNames;
/**
 * an array representing profile images for facebox masculine images.
 */
+ (NSArray *)faceboxMasculineProfilePictureNames;

/**
 * an array representing profile images for facebox masculine images.
 */
+ (NSArray *)faceboxFeminineProfilePictureNames;
@end

//
//  PHProfile.m
//  PHData
//
//  Created by Andrew Hurst on 10/7/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "PHProfile.h"
#import "PHName.h"
#import "NSArray+PHGetters.h"

@implementation PHProfile
#pragma mark Consturction

- (instancetype) initWithGender:(PHProfileGender) gender {
    self = [super init];
    if ( self ) {
        _name = gender == PHProfileGender_Masculine ? [PHName randomMasculineName] : [PHName randomFeminineName];
        _gender = gender;
        _profileImageName =  gender == PHProfileGender_Masculine ?
        [[[self class] masculineProfileImageNames] randomObject] : [[[self class] feminineProfileImageNames] randomObject];
        if ( !_profileImageName )
            _profileImageName = @"";
    }
    return self;
}

- (instancetype) init {
    return [self initWithGender: [[self class] randomGender]];
}
#pragma mark Generation
/**
 * Constructs a random profile, with a random gender.
 */
+ (instancetype) randomProfile {
    return [[[self class] alloc] init];
}

/**
 * Constructs a random profile using the inputted gender.
 */
+ (instancetype) randomProfileUsingGender:(PHProfileGender) gender {
    return [[[self class] alloc] initWithGender: gender];
}

/**
 * Creates an array of random profiles.
 * @param count - the number of profiles to generate.
 */
+ (NSArray *)randomProfilesWithCount:(NSUInteger) count {
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for ( NSUInteger i = 0; i < count; ++i )
        [items addObject: [[self class] randomProfile]];
    return [[NSArray alloc] initWithArray: items];
}


#pragma mark Utilties

+ (PHProfileGender) randomGender {
    return (arc4random_uniform( 10 )) >= 5 ? PHProfileGender_Feminine : PHProfileGender_Masculine;
}

#pragma mark Profile Image Names

+ (NSMutableArray *)masculineProfileImageNames {
    static NSMutableArray *_masculineProfileImageNames;
    static dispatch_once_t _masculineProfileImageNames_onceToken;
    dispatch_once( &_masculineProfileImageNames_onceToken, ^{
        _masculineProfileImageNames = [[NSMutableArray alloc] init];
    });
    return _masculineProfileImageNames;
}

+ (void) registerMasculineProfileImagesWithNames:(NSArray *)array {
    [[[self class] masculineProfileImageNames] addObjectsFromArray: array];
}

+ (NSMutableArray *)feminineProfileImageNames {
    static NSMutableArray *_feminineProfileImageNames;
    static dispatch_once_t _feminineProfileImageNames_onceToken;
    dispatch_once( &_feminineProfileImageNames_onceToken, ^{
        _feminineProfileImageNames = [[NSMutableArray alloc] init];
    });
    return _feminineProfileImageNames;
}

+ (void) registerFeminineProfileImagesWithNames:(NSArray *)array {
    [[[self class] feminineProfileImageNames] addObjectsFromArray: array];
}


#pragma mark Data

+ (void) registerFaceboxProfileImageNames {
    [[self class] registerFeminineProfileImagesWithNames: [[self class] faceboxFeminineProfilePictureNames]];
    [[self class] registerMasculineProfileImagesWithNames: [[self class] faceboxMasculineProfilePictureNames]];
}

+ (NSArray *)faceboxMasculineProfilePictureNames {
    return @[
             @"model-002.jpg",
             @"model-003.jpg",
             @"model-004.jpg",
             @"model-006.jpg",
             @"model-007.jpg",
             @"model-010.jpg",
             @"model-012.jpg",
             @"model-014.jpg",
             @"model-016.jpg",
             @"model-017.jpg",
             @"model-019.jpg",
             @"model-021.jpg",
             @"model-023.jpg",
             @"model-025.jpg",
             @"model-026.jpg",
             @"model-027.jpg",
             @"model-031.jpg",
             @"model-032.jpg",
             @"model-033.jpg",
             @"model-035.jpg",
             @"model-036.jpg",
             @"model-041.jpg",
             @"model-043.jpg",
             @"model-044.jpg",
             @"model-045.jpg",
             @"model-047.jpg",
             @"model-049.jpg",
             @"model-050.jpg"
             ];
}

+ (NSArray *)faceboxFeminineProfilePictureNames {
    return @[
             @"model-001.jpg",
             @"model-005.jpg",
             @"model-008.jpg",
             @"model-009.jpg",
             @"model-011.jpg",
             @"model-013.jpg",
             @"model-015.jpg",
             @"model-018.jpg",
             @"model-020.jpg",
             @"model-022.jpg",
             @"model-024.jpg",
             @"model-028.jpg",
             @"model-029.jpg",
             @"model-030.jpg",
             @"model-024.jpg",
             @"model-037.jpg",
             @"model-038.jpg",
             @"model-039.jpg",
             @"model-040.jpg",
             @"model-042.jpg",
             @"model-046.jpg",
             @"model-048.jpg"
             ];
}

@end

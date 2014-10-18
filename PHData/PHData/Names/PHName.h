//
//  PHName.h
//  PHData
//
//  Created by Andrew Hurst on 10/7/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <Foundation/Foundation.h>

const static NSUInteger sPHNameDefaultGenerationOptions = 0;

@interface PHName : NSObject
#pragma mark Generators
/**
 * Gets a random name from the placeholder name array.
 */
+ (NSString *)randomName;

/**
 * Gets a random name from the masculine placeholder name array.
 */
+ (NSString *)randomMasculineName;

/**
 * Gets a random name from the feminine placeholder name array.
 */
+ (NSString *)randomFeminineName;

/**
 * Gets a random masculine name using the specified options.
 */
+ (NSString *)randomMasculineNameWithOptions:(NSUInteger) options;

/**
 * Gets a random Feminine name using the specified options.
 */
+ (NSString *)randomFeminineNameWithOptions:(NSUInteger) options;

/**
 * Gets a random name using the specified options.
 */
+ (NSString *)randomNameWithOptions:(NSUInteger) options;

#pragma mark Name Segment Getters
/**
 * Gets a random feminine first name.
 */
+ (NSString *)randomFeminineFirstName;

/**
 * Gets a random Masculine first name.
 */
+ (NSString *)randomMasculineFirstName;

/**
 * Gets a random first name.
 */
+ (NSString *)randomFirstName;

/**
 * Gets a random last name.
 */
+ (NSString *)randomLastName;

@end

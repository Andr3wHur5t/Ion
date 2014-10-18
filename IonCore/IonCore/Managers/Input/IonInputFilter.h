//
//  IonInputFilter.h
//  Ion
//
//  Created by Andrew Hurst on 9/10/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <Foundation/Foundation.h>

static const NSInteger sIonInputFilter_DefaultMin = 1;
static const NSInteger sIonInputFilter_DefaultMax = 255;
static NSString *sIonInputFilter_DefaultExpressionString = @"";

/** Keys */
static NSString *sIonInputFilter_FilterExpressionKey = @"filterExpression";
static NSString *sIonInputFilter_MinKey = @"minChars";
static NSString *sIonInputFilter_MaxKey = @"maxChars";



@interface IonInputFilter : NSObject
#pragma mark Constructors
/**
 * Constructs from the inputted min, max, and expression string.
 * @param min - minimum length for the string to be considered valid.
 * @param max - maximum size for the string to be considered valid.
 * @param expression - the regular expression used to determine if input is valid.
 */
- (instancetype) initWithMin:(NSInteger) min max:(NSInteger) max andExpression:(NSRegularExpression *)expression;

/**
 * Constructs from the inputted dictionary.
 * @param configuration - the configuration dictionary.
 */
- (instancetype) initWithDictionary:(NSDictionary *)configuration;

/**
 * Constructs from the inputted min, max, and expression string.
 * @param min - minimum length for the string to be considered valid.
 * @param max - maximum size for the string to be considered valid.
 * @param expression - the regular expression used to determine if input is valid.
 */
+ (instancetype) filterWithMin:(NSInteger) min max:(NSInteger) max andExpression:(NSRegularExpression *)expression;

/**
 * Constructs from the inputted dictionary.
 * @param configuration - the configuration dictionary.
 */
+ (instancetype) filterWithDictionary:(NSDictionary *)configuration;

#pragma mark Configuration
/**
 * The maximum amount of characters allowed.
 */
@property (assign, nonatomic, readwrite) NSInteger max;

/**
 * The minimum amount of characters required for return to be enabled.
 */
@property (assign, nonatomic, readwrite) NSInteger min;

/**
 * The regular expression string to filter content with.
 */
@property (strong, nonatomic, readwrite) NSRegularExpression* expression;

#pragma mark Conformity Checks
/**
 * Gets if the range, and the string conform to the filter.
 * @param range - the range to compare the max to.
 * @param string - the string to check.
 */
- (BOOL) string:(NSString *)string ConformsWithRange:(NSRange) range;

/**
 * Gets if the inputted string conforms to our specifications.
 * @param string - the string to check.
 */
- (BOOL) stringConformsToFilter:(NSString *)string;

/**
 * Gets if the current text conforms to the current min size.
 * @param string - the string to check conformity on.
 */
- (BOOL) stringIsValidForFilter:(NSString *)string;

@end

#pragma mark Dictionary interface
@interface NSDictionary (IonInputFilter)

/**
 * Gets the input filter value for the specified key.
 * @param key - the key to get the input filter for.
 */
- (IonInputFilter *)inputFilterForKey:(id) key;

/**
 * Converts the dictionarys current state into a IonInputFilter.
 */
- (IonInputFilter *)toInputFilter;

@end

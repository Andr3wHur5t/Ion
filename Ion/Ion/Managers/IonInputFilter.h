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
 * @param {NSInteger} minimum length for the string to be considered valid.
 * @param {NSInteger} maximum size for the string to be considered valid.
 * @param {NSRegularExpression*} the regular expression used to determine if input is valid.
 * @returns {instancetype}
 */
- (instancetype) initWithMin:(NSInteger) min max:(NSInteger) max andExpression:(NSRegularExpression *)expression;

/**
 * Constructs from the inputted dictionary.
 * @param {NSDictionary*} the configuration dictionary.
 * @returns {instancetype}
 */
- (instancetype) initWithDictionary:(NSDictionary *)configuration;

/**
 * Constructs from the inputted min, max, and expression string.
 * @param {NSInteger} minimum length for the string to be considered valid.
 * @param {NSInteger} maximum size for the string to be considered valid.
 * @param {NSRegularExpression*} the regular expression used to determine if input is valid.
 * @returns {instancetype}
 */
+ (instancetype) filterWithMin:(NSInteger) min max:(NSInteger) max andExpression:(NSRegularExpression *)expression;

/**
 * Constructs from the inputted dictionary.
 * @param {NSDictionary*} the configuration dictionary.
 * @returns {instancetype}
 */
+ (instancetype) filterWithDictionary:(NSDictionary *)configuration;

#pragma Configuration

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
 * @param {NSRange} the range to compare the max to.
 * @param {NSString*} the string to check.
 * @returns {BOOL}
 */
- (BOOL) string:(NSString *)string ConformsWithRange:(NSRange) range;

/**
 * Gets if the inputted string conforms to our specifications.
 * @param {NSString*} the string to check.
 * @returns {BOOL}
 */
- (BOOL) stringConformsToFilter:(NSString *)string;

/**
 * Gets if the current text conforms to the current min size.
 * @param {NSString*} the string to check conformity on.
 * @returns {BOOL}
 */
- (BOOL) stringIsValidForFilter:(NSString *)string;

@end

#pragma mark Dictionary interface
@interface NSDictionary (IonInputFilter)

/**
 * Gets the input filter value for the specified key.
 * @param {id} the key to get the input filter for.
 * @returns {IonInputFilter*}
 */
- (IonInputFilter *)inputFilterForKey:(id) key;

/**
 * Converts the dictionarys current state into a IonInputFilter.
 * @returns {IonInputFilter*}
 */
- (IonInputFilter *)toInputFilter;

@end

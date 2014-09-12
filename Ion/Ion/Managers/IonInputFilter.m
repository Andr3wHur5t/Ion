//
//  IonInputFilter.m
//  Ion
//
//  Created by Andrew Hurst on 9/10/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonInputFilter.h"
#import <IonData/IonData.h>

@interface IonInputFilter ()

/**
 * The regexp we will check conformity to.
 */
@end

@implementation IonInputFilter
#pragma mark Construction
/**
 * Default Constructor.
 * @returns {instancetype}
 */
- (instancetype) init {
    return [self initWithMin: sIonInputFilter_DefaultMin
                         max: sIonInputFilter_DefaultMax
               andExpression: [sIonInputFilter_DefaultExpressionString toExpresion]];
}

/**
 * Constructs from the inputted min, max, and expression string.
 * @param {NSInteger} minimum length for the string to be considered valid.
 * @param {NSInteger} maximum size for the string to be considered valid.
 * @param {NSRegularExpression*} the regular expression used to determine if input is valid.
 * @returns {instancetype}
 */
- (instancetype) initWithMin:(NSInteger) min max:(NSInteger) max andExpression:(NSRegularExpression *)expression {
    self = [super init];
    if ( self ) {
        self.min = min;
        self.max = max;
        self.expression = expression ? expression : [sIonInputFilter_DefaultExpressionString toExpresion];
    }
    return self;
}

/**
 * Constructs from the inputted dictionary.
 * @param {NSDictionary*} the configuration dictionary.
 * @returns {instancetype}
 */
- (instancetype) initWithDictionary:(NSDictionary *)configuration {
    NSRegularExpression *expression;
    NSNumber *min, *max;
    NSParameterAssert( configuration && [configuration isKindOfClass: [NSDictionary class]] );
    if ( !configuration || ![configuration isKindOfClass: [NSDictionary class]] )
        return NULL;
    
    min = [configuration numberForKey: sIonInputFilter_MinKey];
    if ( !min )
        min = [NSNumber numberWithInteger: sIonInputFilter_DefaultMin];
    
    max = [configuration numberForKey: sIonInputFilter_MaxKey];
    if ( !max )
        max = [NSNumber numberWithInteger: sIonInputFilter_DefaultMax];
    
    expression = [configuration expressionForKey: sIonInputFilter_FilterExpressionKey];
    if ( !expression )
        expression= [sIonInputFilter_DefaultExpressionString toExpresion];
    
    return [self initWithMin: [min integerValue]
                         max: [max integerValue]
               andExpression: expression];
}

/**
 * Constructs from the inputted min, max, and expression string.
 * @param {NSInteger} minimum length for the string to be considered valid.
 * @param {NSInteger} maximum size for the string to be considered valid.
 * @param {NSRegularExpression*} the regular expression used to determine if input is valid.
 * @returns {instancetype}
 */
+ (instancetype) filterWithMin:(NSInteger) min max:(NSInteger) max andExpression:(NSRegularExpression *)expression {
    return [[[self class] alloc] initWithMin: min max: max andExpression: expression];
}

/**
 * Constructs from the inputted dictionary.
 * @param {NSDictionary*} the configuration dictionary.
 * @returns {instancetype}
 */
+ (instancetype) filterWithDictionary:(NSDictionary *)configuration {
    return [[[self class] alloc] initWithDictionary: configuration];
}
#pragma mark Conformity Checks
/**
 * Gets if the inputted string conforms to our specifications.
 * @param {NSString*} the string to check.
 * @returns {BOOL}
 */
- (BOOL) stringConformsToFilter:(NSString *)string {
    // Only Check if the expresion is valid.
    if ( self.expression )
        return [string conformsToExpression: self.expression];
    else
        return TRUE;
}

/**
 * Gets if the range, and the string conform to the filter.
 * @param {NSRange} the range to compare the max to.
 * @param {NSString*} the string to check.
 * @returns {BOOL}
 */
- (BOOL) string:(NSString *)string ConformsWithRange:(NSRange) range {
    // Don't run checks if deleting.
    if ( string.length != 0 ) // Check max size, and content. Note: Max size of 0 disabled range check.
        return  !(![self stringConformsToFilter: string] || !(self.max == 0 ? TRUE :
                                                              range.location + (range.length + 1) <= self.max));
    else
        return TRUE;
}

/**
 * Gets if the current text conforms to the current min size.
 * @param {NSString*} the string to check conformity on.
 * @returns {BOOL}
 */
- (BOOL) stringIsValidForFilter:(NSString *)string {
    return string.length >= self.min && string.length <= self.max;
}

@end

@implementation NSDictionary (IonInputFilter)

/**
 * Gets the input filter value for the specified key.
 * @param {id} the key to get the input filter for.
 * @returns {IonInputFilter*}
 */
- (IonInputFilter *)inputFilterForKey:(id) key {
    NSDictionary *value;
    NSParameterAssert( key );
    if ( !key )
        return NULL;
    
    value = [self dictionaryForKey: key];
    if ( !value )
        return NULL;
    
    return [value toInputFilter];
}

/**
 * Converts the dictionarys current state into a IonInputFilter.
 * @returns {IonInputFilter*}
 */
- (IonInputFilter *)toInputFilter {
    return [IonInputFilter filterWithDictionary: self];
}

@end
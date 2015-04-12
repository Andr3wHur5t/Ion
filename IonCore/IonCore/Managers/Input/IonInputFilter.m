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
 */
- (instancetype)init {
  return
      [self initWithMin:sIonInputFilter_DefaultMin
                    max:sIonInputFilter_DefaultMax
          andExpression:[sIonInputFilter_DefaultExpressionString toExpresion]];
}

/**
 * Constructs from the inputted min, max, and expression string.
 * @param min - minimum length for the string to be considered valid.
 * @param max - maximum size for the string to be considered valid.
 * @param expression - the regular expression used to determine if input is
 * valid.
 */
- (instancetype)initWithMin:(NSInteger)min
                        max:(NSInteger)max
              andExpression:(NSRegularExpression *)expression {
  self = [super init];
  if (self) {
    self.min = min;
    self.max = max;
    self.expression =
        expression ? expression
                   : [sIonInputFilter_DefaultExpressionString toExpresion];
    self.acceptsInput = true;
  }
  return self;
}

/**
 * Constructs from the inputted dictionary.
 * @param configuration - the configuration dictionary.
 */
- (instancetype)initWithDictionary:(NSDictionary *)configuration {
  NSRegularExpression *expression;
  NSNumber *min, *max;
  NSParameterAssert(configuration &&
                    [configuration isKindOfClass:[NSDictionary class]]);
  if (!configuration || ![configuration isKindOfClass:[NSDictionary class]])
    return NULL;

  min = [configuration numberForKey:sIonInputFilter_MinKey];
  if (!min) min = [NSNumber numberWithInteger:sIonInputFilter_DefaultMin];

  max = [configuration numberForKey:sIonInputFilter_MaxKey];
  if (!max) max = [NSNumber numberWithInteger:sIonInputFilter_DefaultMax];

  expression =
      [configuration expressionForKey:sIonInputFilter_FilterExpressionKey];
  if (!expression)
    expression = [sIonInputFilter_DefaultExpressionString toExpresion];

  return [self initWithMin:[min integerValue]
                       max:[max integerValue]
             andExpression:expression];
}

/**
 * Constructs from the inputted min, max, and expression string.
 * @param min - minimum length for the string to be considered valid.
 * @param max - maximum size for the string to be considered valid.
 * @param expression - the regular expression used to determine if input is
 * valid.
 */
+ (instancetype)filterWithMin:(NSInteger)min
                          max:(NSInteger)max
                andExpression:(NSRegularExpression *)expression {
  return
      [[[self class] alloc] initWithMin:min max:max andExpression:expression];
}

/**
 * Constructs from the inputted dictionary.
 * @param configuration the configuration dictionary.
 */
+ (instancetype)filterWithDictionary:(NSDictionary *)configuration {
  return [[[self class] alloc] initWithDictionary:configuration];
}
#pragma mark Conformity Checks
/**
 * Gets if the inputted string conforms to our specifications.
 * @param string - string to check.
 * @return {BOOL}
 */
- (BOOL)stringConformsToFilter:(NSString *)string {
  // Only Check if the expression is valid.
  if (self.expression)
    return [string conformsToExpression:self.expression];
  else
    return TRUE;
}

/**
 * Gets if the range, and the string conform to the filter.
 * @param string - range to compare the max to.
 * @param range - string to check.
 * @return {BOOL}
 */
- (BOOL)string:(NSString *)string ConformsWithRange:(NSRange)range {
  // Don't run checks if deleting.
  if (string.length != 0)  // Check max size, and content. Note: Max size of 0
                           // disabled range check.
    return (!(![self stringConformsToFilter:string] ||
              !(self.max == 0 ? TRUE : (NSInteger)(range.location +
                                                   (range.length + 1)) <=
                                           self.max))) &&
           self.acceptsInput;
  else
    return self.acceptsInput;
}

/**
 * Gets if the current text conforms to the current min size.
 * @param string - string to check conformity on.
 * @return {BOOL}
 */
- (BOOL)stringIsValidForFilter:(NSString *)string {
  return string.length >= (NSUInteger)self.min &&
         string.length <= (NSUInteger)self.max;
}

@end

@implementation NSDictionary (IonInputFilter)

/**
 * Gets the input filter value for the specified key.
 * @param key - key to get the input filter for.
 * @return {IonInputFilter*}
 */
- (IonInputFilter *)inputFilterForKey:(id)key {
  NSDictionary *value;
  NSParameterAssert(key);
  if (!key) return NULL;

  value = [self dictionaryForKey:key];
  if (!value) return NULL;

  return [value toInputFilter];
}

/**
 * Converts the dictionaries current state into a IonInputFilter.
 * @return {IonInputFilter*}
 */
- (IonInputFilter *)toInputFilter {
  return [IonInputFilter filterWithDictionary:self];
}

@end
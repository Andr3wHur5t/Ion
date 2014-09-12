//
//  NSString+Utilities.h
//  Ion
//
//  Created by Andrew Hurst on 9/10/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RegularExpresion)
/**
 * Gets if the string contains a non whitespace character.
 * @returns {BOOL}
 */
- (BOOL) containsNonWhiteSpaceCharacters;

#pragma mark Regular Expression Utilities
/**
 * Gets if the string conforms to the inputted regular expression.
 * @param {NSRegularExpression*} the expression to check with.
 * @returns {BOOL}
 */
- (BOOL) conformsToExpression:(NSRegularExpression *)expression;

/**
 * Replaces Items in the string matching the inputted expression.
 * @param {NSRegularExpression*} the expression to check with.
 * @param {NSString*} the substring to replace with.
 * @returns {NSString*}
 */
- (NSString *)replaceMatches:(NSRegularExpression *)expression withString:(NSString *)string;

/**
 * Deletes substrings matching the expression.
 * @param {NSRegularExpression*} the expression to check with
 * @returns {NSString*}
 */
- (NSString *)deleteMatches:(NSRegularExpression *)expression;

#pragma mark Regular Expression Pattern Generation
/**
 * Converts the current string to an inclusive pattern.
 * @returns {NSString*} the inclusive pattern.
 */
- (NSString *)toInclusivePattern;

/**
 * Constructs a regular expression pattern which will only match values not provided.
 * @param {NSString*} the included values to allow.
 * @returns {NSString*} the resulting pattern.
 */
+ (NSString *)patternUsingInclusiveMatch:(NSString *)match;

/**
 * Converts the current string to an exclusive pattern.
 * @returns {NSString*} the inclusive pattern.
 */
- (NSString *)toExclusivePattern;

/**
 * Constructs a regular expression pattern which will only match values provided.
 * @param {NSString*} the excluded values.
 * @returns {NSString*} the resulting pattern.
 */
+ (NSString *)patternUsingExclusiveMatch:(NSString *)match;

#pragma mark Expression Generation
/**
 * Constructs an expression using the current string as the pattern.
 * @param {NSRegularExpressionOptions} the options to construct with.
 * @returns {NSRegularExpression*} the resulting expression.
 */
- (NSRegularExpression *)toExpresionWithOptions:(NSRegularExpressionOptions) options;

/**
 * Constructs an expression using the current string as the pattern.
 * @returns {NSRegularExpression*} the resulting expression.
 */
- (NSRegularExpression *)toExpresion;

/**
 * Constructs an inclusive expression using the current string as the included chars.
 * @param {NSRegularExpressionOptions} the options to construct with.
 * @returns {NSRegularExpression*} the resulting expression.
 */
- (NSRegularExpression *)toInclusiveExpressionWithOptions:(NSRegularExpressionOptions) options;

/**
 * Constructs an inclusive expression using the current string as the included chars.
 * @returns {NSRegularExpression*} the resulting expression.
 */
- (NSRegularExpression *)toInclusiveExpression;

/**
 * Constructs an exclusive expression using the current string as the included chars.
 * @param {NSRegularExpressionOptions} the options to construct with.
 * @returns {NSRegularExpression*} the resulting expression.
 */
- (NSRegularExpression *)toExclusiveExpressionWithOptions:(NSRegularExpressionOptions) options;

/**
 * Constructs an exclusive expression using the current string as the included chars.
 * @param {NSRegularExpressionOptions} the options to construct with.
 * @returns {NSRegularExpression*} the resulting expression.
 */
- (NSRegularExpression *)toExclusiveExpression;

#pragma mark Named Expresions
/**
 * Gets alpha numeric inclusice epression.
 * @returns {NSRegularExpression*}
 */
+ (NSRegularExpression *)alphaNumericInclusiveExpression;

/**
 * Gets alpha numeric exclusice epression.
 * @returns {NSRegularExpression*}
 */
+ (NSRegularExpression *)alphaNumericExclusiveExpression;

/**
 * Gets email structure verification epression.
 * @returns {NSRegularExpression*}
 */
+ (NSRegularExpression *)emailStructureVerificationExpression;

@end

//
//  NSString+RegularExpression.h
//  FOUtilities
//
//  Created by Andrew Hurst on 10/7/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RegularExpression)
#pragma mark Regular Expression Utilities
/**
 * Gets if the string contains a non whitespace character.
 */
- (BOOL) containsNonWhiteSpaceCharacters;

/**
 * Gets if the string conforms to the inputted regular expression.
 * @param expression - the expression to check with.
 */
- (BOOL) conformsToExpression:(NSRegularExpression *)expression;

/**
 * Replaces Items in the string matching the inputted expression.
 * @param expression - the expression to check with.
 * @param string - the substring to replace with.
 */
- (NSString *)replaceMatches:(NSRegularExpression *)expression withString:(NSString *)string;

/**
 * Deletes substrings matching the expression.
 * @param expression - the expression to check with.
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
 * @param match - the included values to allow.
 * @returns the resulting regular expression pattern.
 */
+ (NSString *)patternUsingInclusiveMatch:(NSString *)match;

/**
 * Converts the current string to an exclusive pattern.
 * @returns the resulting inclusive regular expression pattern.
 */
- (NSString *)toExclusivePattern;

/**
 * Constructs a regular expression pattern which will only match values provided.
 * @param match - the excluded values.
 * @returns the resulting regular expression pattern.
 */
+ (NSString *)patternUsingExclusiveMatch:(NSString *)match;

#pragma mark Expression Generation
/**
 * Constructs an expression using the current string as the pattern.
 * @param options - the options to construct with.
 */
- (NSRegularExpression *)toExpresionWithOptions:(NSRegularExpressionOptions) options;

/**
 * Constructs an expression using the current string as the pattern.
 */
- (NSRegularExpression *)toExpresion;

/**
 * Constructs an inclusive expression using the current string as the included chars.
 * @param options - the options to construct with.
 */
- (NSRegularExpression *)toInclusiveExpressionWithOptions:(NSRegularExpressionOptions) options;

/**
 * Constructs an inclusive expression using the current string as the included chars.
 */
- (NSRegularExpression *)toInclusiveExpression;

/**
 * Constructs an exclusive expression using the current string as the included chars.
 * @param options - the options to construct with.
 */
- (NSRegularExpression *)toExclusiveExpressionWithOptions:(NSRegularExpressionOptions) options;

/**
 * Constructs an exclusive expression using the current string as the included chars.
 */
- (NSRegularExpression *)toExclusiveExpression;

#pragma mark Named Expresions
/**
 * Gets alpha numeric inclusice epression.
 */
+ (NSRegularExpression *)alphaNumericInclusiveExpression;

/**
 * Gets alpha numeric exclusice epression.
 */
+ (NSRegularExpression *)alphaNumericExclusiveExpression;

/**
 * Gets email structure verification epression.
 */
+ (NSRegularExpression *)emailStructureVerificationExpression;

@end

#pragma mark Constants
// All Unicode spaces.
static NSString *sIonUTF8WhiteSpaceChars = @" /r/t\u00A0\u1680\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2006\u2007\u2008\u2009\u200A\u2028\u2029\u202F\u205F\u3000";

// Verifies the structure of an email.
static NSString *sIonEmailStruturePattern = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";

// Simple set of alpha nuemric chars
static NSString *sIonAlphaNumericChars = @"A-Za-z0-9";

static NSString *sFOHexChars = @"#0-9a-fA-F";



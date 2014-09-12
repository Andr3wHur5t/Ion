//
//  NSString+Utilities.m
//  Ion
//
//  Created by Andrew Hurst on 9/10/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "NSString+Utilities.h"

// All of these are Unicode spaces... This is why we cant have nice things... Fak U Unicode...
static NSString *sIonUTF8WhiteSpaceChars = @" /r/t\u00A0\u1680\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2006\u2007\u2008\u2009\u200A\u2028\u2029\u202F\u205F\u3000";

// Verifies the structure of an email.
static NSString *sIonEmailStruturePattern = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";

// Simple set of alpha nuemric chars
static NSString *sIonAlphaNumericChars = @"A-Za-z0-9";


@implementation NSString (Utilities)
/**
 * Gets if the string contains a non whitespace character.
 * @returns {BOOL}
 */
- (BOOL) containsNonWhiteSpaceCharacters {
    // Check if we are empty
    if ( self.length == 0 )
        return FALSE;
    
    // Delete All whitespace, if there is no chars left then there were no non white space chars.
    return [self deleteMatches: [sIonUTF8WhiteSpaceChars toExclusiveExpression]].length != 0;
}


#pragma mark Regular Expression Execution
/**
 * Gets if the string conforms to the inputted regular expression.
 * @param {NSRegularExpression*} the expression to check with.
 * @returns {BOOL}
 */
- (BOOL) conformsToExpression:(NSRegularExpression *)expression {
    NSString* filteredString;
    // Check if we conform by running a replace which will remove characters that don't
    // match our expression, then check lengths to see if anything changed, if the lengths
    // are equal there was no change so the string conformed.
    filteredString = [self deleteMatches: expression];
    if ( filteredString.length == self.length )
        return [filteredString isEqualToString: self];
    else
        return FALSE;
}

/**
 * Replaces Items in the string matching the inputted expression.
 * @param {NSRegularExpression*} the expression to check with.
 * @param {NSString*} the substring to replace with.
 * @returns {NSString*}
 */
- (NSString *)replaceMatches:(NSRegularExpression *)expression withString:(NSString *)string {
    NSParameterAssert( expression && [expression isKindOfClass: [NSRegularExpression class]] );
    NSParameterAssert( string && [string isKindOfClass: [NSString class]] );
    if ( !expression || ![expression isKindOfClass: [NSRegularExpression class]] ||
         !string || ![string isKindOfClass: [NSString class]] )
        return FALSE;
    return [expression stringByReplacingMatchesInString: self
                                                 options: 0
                                                   range: NSMakeRange( 0, self.length )
                                            withTemplate: string];
}

/**
 * Deletes substrings matching the expression.
 * @param {NSRegularExpression*} the expression to check with
 * @returns {NSString*}
 */
- (NSString *)deleteMatches:(NSRegularExpression *)expression {
    return [self replaceMatches: expression withString: @""];
}

#pragma mark Regular Expression Pattern Generation
/**
 * Converts the current string to an inclusive pattern.
 * @returns {NSString*} the inclusive pattern.
 */
- (NSString *)toInclusivePattern {
    return [@"^((?!" stringByAppendingFormat: @"[%@]).)*$", self];
}

/**
 * Constructs a regular expression pattern which will only match values not provided.
 * @param {NSString*} the included values to allow.
 * @returns {NSString*} the resulting pattern.
 */
+ (NSString *)patternUsingInclusiveMatch:(NSString *)match {
    NSParameterAssert( match && [match isKindOfClass: [NSString class]] );
    if ( !match || ![match isKindOfClass: [NSString class]] )
        return @""; // Return an empty expression
    return [match toInclusivePattern];
}

/**
 * Converts the current string to an exclusive pattern.
 * @returns {NSString*} the inclusive pattern.
 */
- (NSString *)toExclusivePattern {
    return [@"^[" stringByAppendingFormat: @"%@]+", self];
}

/**
 * Constructs a regular expression pattern which will only match values provided.
 * @param {NSString*} the excluded values.
 * @returns {NSString*} the resulting pattern.
 */
+ (NSString *)patternUsingExclusiveMatch:(NSString *)match {
    NSParameterAssert( match && [match isKindOfClass: [NSString class]] );
    if ( !match || ![match isKindOfClass: [NSString class]] )
        return @""; // Return an empty expression
    return [match toExclusivePattern];
}

#pragma mark Expression Generation
/**
 * Constructs an expression using the current string as the pattern.
 * @param {NSRegularExpressionOptions} the options to construct with.
 * @returns {NSRegularExpression*} the resulting expression.
 */
- (NSRegularExpression *)toExpresionWithOptions:(NSRegularExpressionOptions) options {
    return [[NSRegularExpression alloc] initWithPattern: self
                                                options: options
                                                  error: NULL];
}

/**
 * Constructs an expression using the current string as the pattern.
 * @returns {NSRegularExpression*} the resulting expression.
 */
- (NSRegularExpression *)toExpresion {
    return [self toExpresionWithOptions: 0];
}

/**
 * Constructs an inclusive expression using the current string as the included chars.
 * @param {NSRegularExpressionOptions} the options to construct with.
 * @returns {NSRegularExpression*} the resulting expression.
 */
- (NSRegularExpression *)toInclusiveExpressionWithOptions:(NSRegularExpressionOptions) options {
    return [[self toInclusivePattern] toExpresionWithOptions: options];
}

/**
 * Constructs an inclusive expression using the current string as the included chars.
 * @returns {NSRegularExpression*} the resulting expression.
 */
- (NSRegularExpression *)toInclusiveExpression {
    return [self toInclusiveExpressionWithOptions: 0];
}

/**
 * Constructs an exclusive expression using the current string as the included chars.
 * @param {NSRegularExpressionOptions} the options to construct with.
 * @returns {NSRegularExpression*} the resulting expression.
 */
- (NSRegularExpression *)toExclusiveExpressionWithOptions:(NSRegularExpressionOptions) options {
    return [[self toExclusivePattern] toExpresionWithOptions: options];
}

/**
 * Constructs an exclusive expression using the current string as the included chars.
 * @param {NSRegularExpressionOptions} the options to construct with.
 * @returns {NSRegularExpression*} the resulting expression.
 */
- (NSRegularExpression *)toExclusiveExpression {
    return [self toExclusiveExpressionWithOptions: 0];
}


#pragma mark Named Expresions
/**
 * Gets alpha numeric inclusice epression.
 * @returns {NSRegularExpression*}
 */
+ (NSRegularExpression *)alphaNumericInclusiveExpression {
    return [sIonAlphaNumericChars toInclusiveExpression];
}

/**
 * Gets alpha numeric exclusice epression.
 * @returns {NSRegularExpression*}
 */
+ (NSRegularExpression *)alphaNumericExclusiveExpression {
    return [sIonAlphaNumericChars toExclusiveExpression];
}

/**
 * Gets email structure verification epression.
 * @returns {NSRegularExpression*}
 */
+ (NSRegularExpression *)emailStructureVerificationExpression {
    return [sIonEmailStruturePattern toExpresion];
}

@end

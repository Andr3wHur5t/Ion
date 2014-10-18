//
//  NSString+RegularExpression.m
//  FOUtilities
//
//  Created by Andrew Hurst on 10/7/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "NSString+RegularExpression.h"

@implementation NSString (RegularExpression)
#pragma mark Regular Expression Utilities

- (BOOL) containsNonWhiteSpaceCharacters {
    // Check if we are empty
    if ( self.length == 0 )
        return FALSE;
    // Delete All whitespace, if there is no chars left then there were no non white space chars.
    return [self deleteMatches: [sIonUTF8WhiteSpaceChars toExclusiveExpression]].length != 0;
}

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

- (NSString *)deleteMatches:(NSRegularExpression *)expression {
    return [self replaceMatches: expression withString: @""];
}

#pragma mark Regular Expression Pattern Generation

- (NSString *)toInclusivePattern {
    return [@"^((?!" stringByAppendingFormat: @"[%@]).)*$", self];
}

+ (NSString *)patternUsingInclusiveMatch:(NSString *)match {
    NSParameterAssert( match && [match isKindOfClass: [NSString class]] );
    if ( !match || ![match isKindOfClass: [NSString class]] )
        return @""; // Return an empty expression
    return [match toInclusivePattern];
}

- (NSString *)toExclusivePattern {
    return [@"^[" stringByAppendingFormat: @"%@]+", self];
}

+ (NSString *)patternUsingExclusiveMatch:(NSString *)match {
    NSParameterAssert( match && [match isKindOfClass: [NSString class]] );
    if ( !match || ![match isKindOfClass: [NSString class]] )
        return @""; // Return an empty expression
    return [match toExclusivePattern];
}

#pragma mark Expression Generation

- (NSRegularExpression *)toExpresionWithOptions:(NSRegularExpressionOptions) options {
    return [[NSRegularExpression alloc] initWithPattern: self
                                                options: options
                                                  error: NULL];
}

- (NSRegularExpression *)toExpresion {
    return [self toExpresionWithOptions: 0];
}

- (NSRegularExpression *)toInclusiveExpressionWithOptions:(NSRegularExpressionOptions) options {
    return [[self toInclusivePattern] toExpresionWithOptions: options];
}

- (NSRegularExpression *)toInclusiveExpression {
    return [self toInclusiveExpressionWithOptions: 0];
}

- (NSRegularExpression *)toExclusiveExpressionWithOptions:(NSRegularExpressionOptions) options {
    return [[self toExclusivePattern] toExpresionWithOptions: options];
}

- (NSRegularExpression *)toExclusiveExpression {
    return [self toExclusiveExpressionWithOptions: 0];
}


#pragma mark Named Expresions

+ (NSRegularExpression *)alphaNumericInclusiveExpression {
    return [sIonAlphaNumericChars toInclusiveExpression];
}

+ (NSRegularExpression *)alphaNumericExclusiveExpression {
    return [sIonAlphaNumericChars toExclusiveExpression];
}

+ (NSRegularExpression *)emailStructureVerificationExpression {
    return [sIonEmailStruturePattern toExpresion];
}


@end

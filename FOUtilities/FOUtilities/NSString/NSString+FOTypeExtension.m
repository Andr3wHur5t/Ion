//
//  NSString+FOTypeExtension.m
//  FOUtilities
//
//  Created by Andrew Hurst on 10/9/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "NSString+FOTypeExtension.h"
#import "NSString+RegularExpression.h"

@implementation NSString (FOTypeExtension)
#pragma mark UI Conversions

- (NSTextAlignment) toTextAlignment {
    NSString* uppercase = self.uppercaseString;
    
    // NOTE: Constants manually uppercased
    if ( [uppercase isEqualToString: sFOTextAlignment_Centered] )
        return NSTextAlignmentCenter;
    else if ( [uppercase isEqualToString: sFOTextAlignment_Right] )
        return NSTextAlignmentRight;
    else if ( [uppercase isEqualToString: sFOTextAlignment_Left] )
        return NSTextAlignmentLeft;
    else if ( [uppercase isEqualToString: sFOTextAlignment_Justified] )
        return NSTextAlignmentJustified;
    else
        return NSTextAlignmentNatural;
}


#pragma mark Keyboard

- (UIKeyboardType) toKeyboardType {
    NSString* uppercase = self.uppercaseString;
    
    // NOTE: Constants manually uppercased
    if ( [uppercase isEqualToString: sFOKeyboardType_ACII] )
        return UIKeyboardTypeASCIICapable;
    else if ( [uppercase isEqualToString: sFOKeyboardType_NumbersAndPunctuation] )
        return UIKeyboardTypeNumbersAndPunctuation;
    else if ( [uppercase isEqualToString: sFOKeyboardType_Email] )
        return UIKeyboardTypeEmailAddress;
    else if ( [uppercase isEqualToString: sFOKeyboardType_Decimal] )
        return UIKeyboardTypeDecimalPad;
    else if ( [uppercase isEqualToString: sFOKeyboardType_Twitter] )
        return UIKeyboardTypeTwitter;
    else if ( [uppercase isEqualToString: sFOKeyboardType_Search] )
        return UIKeyboardTypeWebSearch;
    else if ( [uppercase isEqualToString: sFOKeyboardType_Name] )
        return UIKeyboardTypeNamePhonePad;
    else if ( [uppercase isEqualToString: sFOKeyboardType_URL] )
        return UIKeyboardTypeURL;
    else if ( [uppercase isEqualToString: sFOKeyboardType_Number] )
        return UIKeyboardTypeNumberPad;
    else if ( [uppercase isEqualToString: sFOKeyboardType_Phone] )
        return UIKeyboardTypePhonePad;
    else
        return UIKeyboardTypeDefault;
}

- (UIKeyboardAppearance) toKeyboardAppearance {
    NSString* uppercase = self.uppercaseString;
    
    // NOTE: Constants manually uppercased
    if ( [uppercase isEqualToString: sFOKeyboardAppearance_Light] )
        return UIKeyboardAppearanceLight;
    else if ( [uppercase isEqualToString: sFOKeyboardAppearance_Dark] )
        return UIKeyboardAppearanceDark;
    else
        return UIKeyboardAppearanceDefault;
}

- (UIReturnKeyType) toReturnKeyType {
    NSString* uppercase = self.uppercaseString;
    
    // NOTE: Constants manually uppercased
    if ( [uppercase isEqualToString: sFOKeyboardReturnKey_Done] )
        return UIReturnKeyDone;
    else if ( [uppercase isEqualToString: sFOKeyboardReturnKey_EmergencyCall] )
        return UIReturnKeyEmergencyCall;
    else if ( [uppercase isEqualToString: sFOKeyboardReturnKey_Go] )
        return UIReturnKeyGo;
    else if ( [uppercase isEqualToString: sFOKeyboardReturnKey_Join] )
        return UIReturnKeyJoin;
    else if ( [uppercase isEqualToString: sFOKeyboardReturnKey_Next] )
        return UIReturnKeyNext;
    else if ( [uppercase isEqualToString: sFOKeyboardReturnKey_Route] )
        return UIReturnKeyRoute;
    else if ( [uppercase isEqualToString: sFOKeyboardReturnKey_Search] )
        return UIReturnKeySearch;
    else if ( [uppercase isEqualToString: sFOKeyboardReturnKey_Send] )
        return UIReturnKeySend;
    else
        return UIReturnKeyDefault;
}

- (UITextAutocapitalizationType) toAutocapitalizationType {
    NSString* uppercase = self.uppercaseString;
    
    // NOTE: Constants manually uppercased
    if ( [uppercase isEqualToString: sFOAutocapitalizationType_All] )
        return UITextAutocapitalizationTypeAllCharacters;
    else if ( [uppercase isEqualToString: sFOAutocapitalizationType_None] )
        return UITextAutocapitalizationTypeNone;
    else if ( [uppercase isEqualToString: sFOAutocapitalizationType_Word] )
        return UITextAutocapitalizationTypeWords;
    else
        return UITextAutocapitalizationTypeSentences;
}

- (UITextAutocorrectionType) toAutocorrectionType {
    NSString* uppercase = self.uppercaseString;
    
    // NOTE: Constants manually uppercased
    if ( [uppercase isEqualToString: sFOAutocorrectionType_Yes] )
        return UITextAutocorrectionTypeYes;
    else if ( [uppercase isEqualToString: sFOAutocorrectionType_No] )
        return UITextAutocorrectionTypeNo;
    else
        return UITextAutocorrectionTypeDefault;
}

- (UITextSpellCheckingType) toSpellCheckingType {
    NSString* uppercase = self.uppercaseString;
    
    // NOTE: Constants manually uppercased
    if ( [uppercase isEqualToString: sFOSpellCheckingType_Yes] )
        return UITextSpellCheckingTypeYes;
    else if ( [uppercase isEqualToString: sFOSpellCheckingType_No] )
        return UITextSpellCheckingTypeNo;
    else
        return UITextSpellCheckingTypeDefault;
}

- (UIScrollViewKeyboardDismissMode) toScrollViewKeyboardDismissMode {
    NSString* uppercase = self.uppercaseString;
    
    // NOTE: Constants manually uppercased
    if ( [uppercase isEqualToString: sFOScrollViewKeyboardDismissMode_OnDrag ] )
        return UIScrollViewKeyboardDismissModeOnDrag;
    else if ( [uppercase isEqualToString: sFOScrollViewKeyboardDismissMode_Interactive ] )
        return UIScrollViewKeyboardDismissModeInteractive;
    else
        return UIScrollViewKeyboardDismissModeNone;
}

- (float) toScrollViewDecelerationRateConstant {
    NSString* uppercase = self.uppercaseString;
    
    // NOTE: Constants manually uppercased
    if ( [uppercase isEqualToString: sFOScrollViewDecelerationRate_Fast ] )
        return UIScrollViewDecelerationRateFast;
    else
        return UIScrollViewDecelerationRateNormal;
}

- (UIScrollViewIndicatorStyle) toScrollViewIndicatorStyle {
    NSString* uppercase = self.uppercaseString;
    
    // NOTE: Constants manually uppercased
    if ( [uppercase isEqualToString: sFOScrollViewIndicatorStyle_Black ] )
        return UIScrollViewIndicatorStyleBlack;
    else if ( [uppercase isEqualToString: sFOScrollViewIndicatorStyle_White ] )
        return UIScrollViewIndicatorStyleWhite;
    else
        return UIScrollViewIndicatorStyleDefault;
}

#pragma mark Color

+ (NSString*) cleanDirtyHex:(NSString *)dirtyHex {
    NSRegularExpression* normalizationExpresion;
    NSString* cleanString;
    if ( !dirtyHex || ![dirtyHex isKindOfClass:[NSString class]] )
        return NULL;
    // Set
    normalizationExpresion = [NSRegularExpression regularExpressionWithPattern: @"[^#0-9a-fA-F]+"
                                                                       options: 0
                                                                         error: nil];
    
    // Clean
    cleanString = [normalizationExpresion stringByReplacingMatchesInString: dirtyHex
                                                                   options: 0
                                                                     range: NSMakeRange(0, dirtyHex.length)
                                                              withTemplate: @"F"];
    // Return
    if ( ![cleanString isKindOfClass:[NSString class]] )
        return NULL;
    return cleanString;
}

/**
 * Cleans a dirty hex string.
 */
- (NSString *)cleanedHex {
    
    return [self replaceMatches: [sFOHexChars toInclusiveExpression] withString: @"F"];
}

/**
 * Converts a NSString at an inputted range in to an RGBA Element.
 * Hex String to UIColor From Stack overflow: http://stackoverflow.com/a/7180905/3624745
 * @param start - the starting index
 * @param length - the amount of char to use to get the element
 */
- (CGFloat) colorComponentAt:(NSUInteger) start length:(NSUInteger) length {
    unsigned hexComponent;
    NSString *substring, *fullHex;
    
    substring = [self substringWithRange: NSMakeRange(start, length)];
    fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    
    return hexComponent / 255.0;
}

/**
 * Checks if the inputted string is a valid hex.
 * @returns TRUE if the hex is valid, FALSE if it has failed
 */
- (BOOL) IsValidHex {
    NSUInteger strLength = [self length];
    
    if ( [[self substringToIndex:1] isEqualToString:@"#"] && strLength <= 9) {
        // Check for valid length
        switch ( strLength - 1 ) {
            case 8:  // RRGGBBAA
                return true;
                break;
            case 6:  // RRGGBB
                return true;
                break;
            case 4:  // RGBA
                return true;
                break;
            case 3:  // RGB
                return true;
                break;
            default: // Fail Not Hex
                return false;
                break;
        }
    }
    else
        return false;

}

@end

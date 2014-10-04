//
//  NSString+TypeExtension.m
//  Ion
//
//  Created by Andrew Hurst on 8/20/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "NSString+TypeExtension.h"

@implementation NSString (TypeExtension)


#pragma mark UI Conversions

/**
 * Converts a string to text alignment.
 * @returns {NSTextAlignment}
 */
- (NSTextAlignment) toTextAlignment {
    NSString* uppercase = self.uppercaseString;
    
    // NOTE: Constants manually uppercased
    if ( [uppercase isEqualToString: sIonTextAlignment_Centered] )
        return NSTextAlignmentCenter;
    else if ( [uppercase isEqualToString: sIonTextAlignment_Right] )
        return NSTextAlignmentRight;
    else if ( [uppercase isEqualToString: sIonTextAlignment_Left] )
        return NSTextAlignmentLeft;
    else if ( [uppercase isEqualToString: sIonTextAlignment_Justified] )
        return NSTextAlignmentJustified;
    else
        return NSTextAlignmentNatural;
}


#pragma mark Keyboard
/**
 * Converts a string to UIKeyboardType.
 * @returns {UIKeyboardType}
 */
- (UIKeyboardType) toKeyboardType {
    NSString* uppercase = self.uppercaseString;
    
    // NOTE: Constants manually uppercased
    if ( [uppercase isEqualToString: sIonKeyboardType_ACII] )
        return UIKeyboardTypeASCIICapable;
    else if ( [uppercase isEqualToString: sIonKeyboardType_NumbersAndPunctuation] )
        return UIKeyboardTypeNumbersAndPunctuation;
    else if ( [uppercase isEqualToString: sIonKeyboardType_Email] )
        return UIKeyboardTypeEmailAddress;
    else if ( [uppercase isEqualToString: sIonKeyboardType_Decimal] )
        return UIKeyboardTypeDecimalPad;
    else if ( [uppercase isEqualToString: sIonKeyboardType_Twitter] )
        return UIKeyboardTypeTwitter;
    else if ( [uppercase isEqualToString: sIonKeyboardType_Search] )
        return UIKeyboardTypeWebSearch;
    else if ( [uppercase isEqualToString: sIonKeyboardType_Name] )
        return UIKeyboardTypeNamePhonePad;
    else if ( [uppercase isEqualToString: sIonKeyboardType_URL] )
        return UIKeyboardTypeURL;
    else if ( [uppercase isEqualToString: sIonKeyboardType_Number] )
        return UIKeyboardTypeNumberPad;
    else if ( [uppercase isEqualToString: sIonKeyboardType_Phone] )
        return UIKeyboardTypePhonePad;
    else
        return UIKeyboardTypeDefault;
}

/**
 * Converts a string to UIKeyboardAppearance.
 * @returns {UIKeyboardAppearance}
 */
- (UIKeyboardAppearance) toKeyboardAppearance {
    NSString* uppercase = self.uppercaseString;
    
    // NOTE: Constants manually uppercased
    if ( [uppercase isEqualToString: sIonKeyboardAppearance_Light] )
        return UIKeyboardAppearanceLight;
    else if ( [uppercase isEqualToString: sIonKeyboardAppearance_Dark] )
        return UIKeyboardAppearanceDark;
    else
        return UIKeyboardAppearanceDefault;
}

/**
 * Converts a string to UIReturnKeyType.
 * @returns {UIReturnKeyType}
 */
- (UIReturnKeyType) toReturnKeyType {
    NSString* uppercase = self.uppercaseString;
    
    // NOTE: Constants manually uppercased
    if ( [uppercase isEqualToString: sIonKeyboardReturnKey_Done] )
        return UIReturnKeyDone;
    else if ( [uppercase isEqualToString: sIonKeyboardReturnKey_EmergencyCall] )
        return UIReturnKeyEmergencyCall;
    else if ( [uppercase isEqualToString: sIonKeyboardReturnKey_Go] )
        return UIReturnKeyGo;
    else if ( [uppercase isEqualToString: sIonKeyboardReturnKey_Join] )
        return UIReturnKeyJoin;
    else if ( [uppercase isEqualToString: sIonKeyboardReturnKey_Next] )
        return UIReturnKeyNext;
    else if ( [uppercase isEqualToString: sIonKeyboardReturnKey_Route] )
        return UIReturnKeyRoute;
    else if ( [uppercase isEqualToString: sIonKeyboardReturnKey_Search] )
        return UIReturnKeySearch;
    else if ( [uppercase isEqualToString: sIonKeyboardReturnKey_Send] )
        return UIReturnKeySend;
    else
        return UIReturnKeyDefault;
}

/**
 * Converts a string to UITextAutocapitalizationType.
 * @returns {UITextAutocapitalizationType}
 */
- (UITextAutocapitalizationType) toAutocapitalizationType {
    NSString* uppercase = self.uppercaseString;
    
    // NOTE: Constants manually uppercased
    if ( [uppercase isEqualToString: sIonAutocapitalizationType_All] )
        return UITextAutocapitalizationTypeAllCharacters;
    else if ( [uppercase isEqualToString: sIonAutocapitalizationType_None] )
        return UITextAutocapitalizationTypeNone;
    else if ( [uppercase isEqualToString: sIonAutocapitalizationType_Word] )
        return UITextAutocapitalizationTypeWords;
    else
        return UITextAutocapitalizationTypeSentences;
}

/**
 * Converts a string to UITextAutocorrectionType.
 * @returns {UITextAutocorrectionType}
 */
- (UITextAutocorrectionType) toAutocorrectionType {
    NSString* uppercase = self.uppercaseString;
    
    // NOTE: Constants manually uppercased
    if ( [uppercase isEqualToString: sIonAutocorrectionType_Yes] )
        return UITextAutocorrectionTypeYes;
    else if ( [uppercase isEqualToString: sIonAutocorrectionType_No] )
        return UITextAutocorrectionTypeNo;
    else
        return UITextAutocorrectionTypeDefault;
}

/**
 * Converts a string to UITextSpellCheckingType.
 * @returns {UITextSpellCheckingType}
 */
- (UITextSpellCheckingType) toSpellCheckingType {
    NSString* uppercase = self.uppercaseString;
    
    // NOTE: Constants manually uppercased
    if ( [uppercase isEqualToString: sIonSpellCheckingType_Yes] )
        return UITextSpellCheckingTypeYes;
    else if ( [uppercase isEqualToString: sIonSpellCheckingType_No] )
        return UITextSpellCheckingTypeNo;
    else
        return UITextSpellCheckingTypeDefault;
}

/**
 * Converts a string to a UIScrollViewKeyboardDismissMode.
 * @returns {UIScrollViewKeyboardDismissMode}
 */
- (UIScrollViewKeyboardDismissMode) toScrollViewKeyboardDismissMode {
    NSString* uppercase = self.uppercaseString;
    
    // NOTE: Constants manually uppercased
    if ( [uppercase isEqualToString: sIonScrollViewKeyboardDismissMode_OnDrag ] )
        return UIScrollViewKeyboardDismissModeOnDrag;
    else if ( [uppercase isEqualToString: sIonScrollViewKeyboardDismissMode_Interactive ] )
        return UIScrollViewKeyboardDismissModeInteractive;
    else
        return UIScrollViewKeyboardDismissModeNone;
}

/**
 * Converts a string to a float using the UIScrollView Deceleration rate constants.
 * @returns {float}
 */
- (float) toScrollViewDecelerationRateConstant {
    NSString* uppercase = self.uppercaseString;
    
    // NOTE: Constants manually uppercased
    if ( [uppercase isEqualToString: sIonScrollViewDecelerationRate_Fast ] )
        return UIScrollViewDecelerationRateFast;
    else
        return UIScrollViewDecelerationRateNormal;
}


/**
 * Converts a string to a UIScrollViewIndicatorStyle.
 * @returns {UIScrollViewIndicatorStyle}
 */
- (UIScrollViewIndicatorStyle) toScrollViewIndicatorStyle {
    NSString* uppercase = self.uppercaseString;
    
    // NOTE: Constants manually uppercased
    if ( [uppercase isEqualToString: sIonScrollViewIndicatorStyle_Black ] )
        return UIScrollViewIndicatorStyleBlack;
    else if ( [uppercase isEqualToString: sIonScrollViewIndicatorStyle_White ] )
        return UIScrollViewIndicatorStyleWhite;
    else
        return UIScrollViewIndicatorStyleDefault;
}


@end

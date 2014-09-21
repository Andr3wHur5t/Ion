//
//  NSString+TypeExtension.h
//  Ion
//
//  Created by Andrew Hurst on 8/20/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>

// Text Alignment keys
static NSString* sIonTextAlignment_Centered = @"CENTER";
static NSString* sIonTextAlignment_Right = @"RIGHT";
static NSString* sIonTextAlignment_Left = @"LEFT";
static NSString* sIonTextAlignment_Justified = @"JUSTIFIED";
static NSString* sIonTextAlignment_Natural = @"NATURAL";

// Keyboard Type keys
static NSString* sIonKeyboardType_Default = @"DEFAULT";
static NSString* sIonKeyboardType_ACII = @"ACII";
static NSString* sIonKeyboardType_NumbersAndPunctuation = @"NUMBERSANDPUNCTUATION";
static NSString* sIonKeyboardType_Email = @"EMAIL";
static NSString* sIonKeyboardType_Decimal = @"DECIMAL";
static NSString* sIonKeyboardType_Twitter = @"TWITTER";
static NSString* sIonKeyboardType_Search = @"SEARCH";
static NSString* sIonKeyboardType_Name = @"SEARCH";
static NSString* sIonKeyboardType_URL = @"URL";
static NSString* sIonKeyboardType_Number = @"NUMBERS";
static NSString* sIonKeyboardType_Phone = @"PHONE";

// Keyboard Appearance keys
static NSString* sIonKeyboardAppearence_Light = @"LIGHT";
static NSString* sIonKeyboardAppearence_Dark = @"DARK";
static NSString* sIonKeyboardAppearence_Default = @"DEFAULT";

// Return Key Type Keys
static NSString* sIonKeyboardReturnKey_Done = @"DONE";
static NSString* sIonKeyboardReturnKey_EmergencyCall = @"EMERGENCYCALL";
static NSString* sIonKeyboardReturnKey_Go = @"GO";
static NSString* sIonKeyboardReturnKey_Join = @"JOIN";
static NSString* sIonKeyboardReturnKey_Next = @"NEXT";
static NSString* sIonKeyboardReturnKey_Route = @"ROUTE";
static NSString* sIonKeyboardReturnKey_Search = @"SEARCH";
static NSString* sIonKeyboardReturnKey_Send = @"SEND";
static NSString* sIonKeyboardReturnKey_Default = @"DEFAULT";

// Auto Capitlization Type
static NSString* sIonAutocapitalizationType_None = @"NONE";
static NSString* sIonAutocapitalizationType_Word = @"WORDS";
static NSString* sIonAutocapitalizationType_Sentences = @"SENTENCES";
static NSString* sIonAutocapitalizationType_All = @"ALL";

// Autocorrection Type
static NSString* sIonAutocorrectionType_Default = @"DEFULT";
static NSString* sIonAutocorrectionType_No = @"ENABLE";
static NSString* sIonAutocorrectionType_Yes = @"DISABLE";

// SpellChecking Type
static NSString* sIonSpellCheckingType_Default = @"DEFULT";
static NSString* sIonSpellCheckingType_No = @"ENABLE";
static NSString* sIonSpellCheckingType_Yes = @"DISABLE";


@interface NSString (TypeExtension)
#pragma mark UI Conversions
/**
 * Converts a string to text alignment.
 * @returns {NSTextAlignment}
 */
- (NSTextAlignment) toTextAlignment;

#pragma mark Keyboard Conversion
/**
 * Converts a string to UIKeyboardType.
 * @returns {UIKeyboardType}
 */
- (UIKeyboardType) toKeyboardType;

/**
 * Converts a string to UIKeyboardAppearence.
 * @returns {UIKeyboardAppearence}
 */
- (UIKeyboardAppearance) toKeyboardAppearence;

/**
 * Converts a string to UIReturnKeyType.
 * @returns {UIReturnKeyType}
 */
- (UIReturnKeyType) toReturnKeyType;

/**
 * Converts a string to UITextAutocapitalizationType.
 * @returns {UITextAutocapitalizationType}
 */
- (UITextAutocapitalizationType) toAutocapitalizationType;

/**
 * Converts a string to UITextAutocorrectionType.
 * @returns {UITextAutocorrectionType}
 */
- (UITextAutocorrectionType) toAutocorrectionType;

/**
 * Converts a string to UITextSpellCheckingType.
 * @returns {UITextSpellCheckingType}
 */
- (UITextSpellCheckingType) toSpellCheckingType;



@end

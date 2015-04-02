//
//  NSString+FOTypeExtension.h
//  FOUtilities
//
//  Created by Andrew Hurst on 10/9/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (FOTypeExtension)
#pragma mark UI Conversions
/**
 * Converts a string to text alignment.
 */
- (NSTextAlignment)toTextAlignment;

#pragma mark Keyboard Conversion
/**
 * Converts a string to UIKeyboardType.
 */
- (UIKeyboardType)toKeyboardType;

/**
 * Converts a string to UIKeyboardAppearance.
 */
- (UIKeyboardAppearance)toKeyboardAppearance;

/**
 * Converts a string to UIReturnKeyType.
 */
- (UIReturnKeyType)toReturnKeyType;

/**
 * Converts a string to UITextAutocapitalizationType.
 */
- (UITextAutocapitalizationType)toAutocapitalizationType;

/**
 * Converts a string to UITextAutocorrectionType.
 */
- (UITextAutocorrectionType)toAutocorrectionType;

/**
 * Converts a string to UITextSpellCheckingType.
 */
- (UITextSpellCheckingType)toSpellCheckingType;

#pragma mark Animation

/**
 * Converts a string to UIViewAnimationOptions transition.
 */
- (UIViewAnimationOptions)toTransisionType;

#pragma mark Scroll View Conversion
/**
 * Converts a string to a UIScrollViewKeyboardDismissMode.
 */
- (UIScrollViewKeyboardDismissMode)toScrollViewKeyboardDismissMode;

/**
 * Converts a string to a float using the UIScrollView Deceleration rate
 * constants.
 */
- (float)toScrollViewDecelerationRateConstant;

/**
 * Converts a string to a UIScrollViewIndicatorStyle.
 */
- (UIScrollViewIndicatorStyle)toScrollViewIndicatorStyle;

#pragma mark Color
/**
 * Cleans a dirty hex string.
 */
- (NSString*)cleanedHex;

/**
 * Converts a NSString at an inputted range in to an RGBA Element.
 * Hex String to UIColor From Stack overflow:
 * http://stackoverflow.com/a/7180905/3624745
 * @param start - the starting index
 * @param length - the amount of char to use to get the element
 */
- (CGFloat)colorComponentAt:(NSUInteger)start length:(NSUInteger)length;

/**
 * Checks if the inputted string is a valid hex.
 * @returns TRUE if the hex is valid, FALSE if it has failed
 */
- (BOOL)IsValidHex;

/*!
 @brief Converts a hex string into a color

 @return The resulting color.
 */
- (UIColor*)toColor;

#pragma mark URL Coding
/*!
 @brief gets the URL encoded value.

 @return The URL Encoded value.
 */
- (NSString*)urlEncode;

/*!
 @brief Decodes a URL encoded string

 @return The URL Decoded value.
 */
- (NSString*)urlDecode;

#pragma mark Replace Utilities

/*!
 @brief Replaces items in the string matching the keys of the provided
 dictionary.

 @param items The dictionary of items to replace.

 @return the resulting string.
 */
- (NSString*)stringByReplacingItems:(NSDictionary*)items;

@end

// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
//                              Constants
// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

#pragma mark Text Alignment keys
static NSString* sFOTextAlignment_Centered = @"CENTER";
static NSString* sFOTextAlignment_Right = @"RIGHT";
static NSString* sFOTextAlignment_Left = @"LEFT";
static NSString* sFOTextAlignment_Justified = @"JUSTIFIED";
static NSString* sFOTextAlignment_Natural = @"NATURAL";

#pragma mark Keyboard Type keys
static NSString* sFOKeyboardType_Default = @"DEFAULT";
static NSString* sFOKeyboardType_ACII = @"ACII";
static NSString* sFOKeyboardType_NumbersAndPunctuation =
    @"NUMBERSANDPUNCTUATION";
static NSString* sFOKeyboardType_Email = @"EMAIL";
static NSString* sFOKeyboardType_Decimal = @"DECIMAL";
static NSString* sFOKeyboardType_Twitter = @"TWITTER";
static NSString* sFOKeyboardType_Search = @"SEARCH";
static NSString* sFOKeyboardType_Name = @"SEARCH";
static NSString* sFOKeyboardType_URL = @"URL";
static NSString* sFOKeyboardType_Number = @"NUMBERS";
static NSString* sFOKeyboardType_Phone = @"PHONE";

#pragma mark Keyboard Appearance keys
static NSString* sFOKeyboardAppearance_Light = @"LIGHT";
static NSString* sFOKeyboardAppearance_Dark = @"DARK";
static NSString* sFOKeyboardAppearance_Default = @"DEFAULT";

#pragma mark Return Key Type Keys
static NSString* sFOKeyboardReturnKey_Done = @"DONE";
static NSString* sFOKeyboardReturnKey_EmergencyCall = @"EMERGENCYCALL";
static NSString* sFOKeyboardReturnKey_Go = @"GO";
static NSString* sFOKeyboardReturnKey_Join = @"JOIN";
static NSString* sFOKeyboardReturnKey_Next = @"NEXT";
static NSString* sFOKeyboardReturnKey_Route = @"ROUTE";
static NSString* sFOKeyboardReturnKey_Search = @"SEARCH";
static NSString* sFOKeyboardReturnKey_Send = @"SEND";
static NSString* sFOKeyboardReturnKey_Default = @"DEFAULT";

#pragma mark Auto Capitalization Type
static NSString* sFOAutocapitalizationType_None = @"NONE";
static NSString* sFOAutocapitalizationType_Word = @"WORDS";
static NSString* sFOAutocapitalizationType_Sentences = @"SENTENCES";
static NSString* sFOAutocapitalizationType_All = @"ALL";

#pragma mark Autocorrection Type
static NSString* sFOAutocorrectionType_Default = @"DEFULT";
static NSString* sFOAutocorrectionType_No = @"ENABLE";
static NSString* sFOAutocorrectionType_Yes = @"DISABLE";

#pragma mark SpellChecking Type
static NSString* sFOSpellCheckingType_Default = @"DEFULT";
static NSString* sFOSpellCheckingType_No = @"ENABLE";
static NSString* sFOSpellCheckingType_Yes = @"DISABLE";

#pragma mark Scroll View Keyboard Dismiss Mode
static NSString* sFOScrollViewKeyboardDismissMode_OnDrag = @"ONDRAG";
static NSString* sFOScrollViewKeyboardDismissMode_Interactive = @"INTERACTIVE";
static NSString* sFOScrollViewKeyboardDismissMode_None = @"NONE";

#pragma mark Scroll View Deceleration Rate
static NSString* sFOScrollViewDecelerationRate_Normal = @"NORMAL";
static NSString* sFOScrollViewDecelerationRate_Fast = @"FAST";

#pragma mark Scroll View Indication Style
static NSString* sFOScrollViewIndicatorStyle_Default = @"DEFAULT";
static NSString* sFOScrollViewIndicatorStyle_Black = @"BLACK";
static NSString* sFOScrollViewIndicatorStyle_White = @"WHITE";

#pragma mark Animation
static NSString* sFOTransisionType_CurlUp = @"curlUp";
static NSString* sFOTransisionType_CurlDown = @"curlDown";
static NSString* sFOTransisionType_FlipLeft = @"flipLeft";
static NSString* sFOTransisionType_FlipRight = @"flipRight";
static NSString* sFOTransisionType_FlipTop = @"flipTop";
static NSString* sFOTransisionType_FlipBottom = @"flipBottom";
static NSString* sFOTransisionType_Dissolve = @"dissolve";
static NSString* sFOTransisionType_None = @"none";

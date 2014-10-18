//
//  NSDictionary+FOTypeExtension.h
//  FOUtilities
//
//  Created by Andrew Hurst on 10/9/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSDictionary (FOTypeExtension)
#pragma mark Fundamental Objects
/**
 * Gets the NSString of the keyed value.
 * @param key - the key to get the value from.
 */
- (NSString*) stringForKey:(id) key;

/**
 * Gets the NSDictionary of the keyed value.
 * @param key - the key to get the value from.
 */
- (NSDictionary*) dictionaryForKey:(id) key;

/**
 * Gets the NSDictionary of the keyed value.
 * @param key - the key to get the value from.
 * @param defaultValue - the value to return if invalid.
 */
- (NSDictionary*) dictionaryForKey:(id) key defaultValue:(id) defaultValue;

/**
 * Gets the NSArray of the keyed value.
 * @param key - the key to get the value from.
 */
- (NSArray*) arrayForKey:(id) key;

/**
 * Gets the NSNumber of the keyed value.
 * @param key - the key to get the value from.
 */
- (NSNumber*) numberForKey:(id) key;

/**
 * Gets the NSNumber of the keyed value.
 * @param key - the key to get the value from.
 */
- (NSNumber*) numberForKey:(id) key defaultValue:(id) defaultValue;

/**
 * Gets the BOOL of the keyed value.
 * @param key - the key to get the value from.
 */
- (BOOL) boolForKey:(id) key;

/**
 * Gets the BOOL of the keyed value.
 * @param key - the key to get the value from.
 * @param defaultValue - the default value to return on failure.
 */
- (BOOL) boolForKey:(id) key defaultValue:(BOOL) defaultValue;

#pragma mark Color
/**
 * Gets the UIColor of the keyed value.
 * @warning will only convert from Hex in any of the following formats #RBG #RBGA #RRBBGG #RRBBGGAA
 * @param key - the key to get the value from.
 * @retruns a valid UIColor, or NULL if invalid.
 */
- (UIColor *)colorFromKey:(id) key;

#pragma mark Fonts

/**
 * Converts the dictionary to a font.
 * @returns {UIFont*} the resulting font, or NULL if invalid.
 */
- (UIFont*) toFont;

/**
 * Gets the font for the specified key.
 * @param key - the key for the font.
 * @returns {UIFont} the resulting font, or NULL if invalid.
 */
- (UIFont*) fontForKey:(id) key;

/**
 * Gets the text alignment representation at the specified key.
 * @param key - the key for the text alignment.
 * @returns {NSTextAlignment}
 */
- (NSTextAlignment) textAlignmentForKey:(id) key;

#pragma mark Keyboard
/**
 * Gets the KeyboardType representation at the specified key.
 * @param key - the key for the keyboardTyper.
 * @returns {NSTextAlignment}
 */
- (UIKeyboardType) keyboardTypeForKey:(id) key;

/**
 * Gets the KeyboardAppearance representation at the specified key.
 * @param key - the key for the KeyboardAppearance.
 * @returns {UIKeyboardAppearance}
 */
- (UIKeyboardAppearance) keyboardAppearanceForKey:(id) key;

/**
 * Gets the ReturnKeyType representation at the specified key.
 * @param key - the key for the ReturnKeyType.
 * @returns {UIReturnKeyType}
 */
- (UIReturnKeyType) returnKeyTypeForKey:(id) key;

/**
 * Gets the UITextAutocapitalizationType representation at the specified key.
 * @param key - the key for the UITextAutocapitalizationType.
 * @returns {UITextAutocapitalizationType}
 */
- (UITextAutocapitalizationType) autocapitalizationTypeForKey:(id) key;

/**
 * Gets the UITextAutocorrectionType representation at the specified key.
 * @param key - the key for the UITextAutocorrectionType.
 * @returns {UITextAutocorrectionType}
 */
- (UITextAutocorrectionType) autocorrectionTypeForKey:(id) key;

/**
 * Gets the UITextSpellCheckingType representation at the specified key.
 * @param key - the key for the UITextSpellCheckingType.
 * @returns {UITextSpellCheckingType}
 */
- (UITextSpellCheckingType) spellcheckTypeForKey:(id) key;

#pragma mark Scroll View
/**
 * Gets the deceleration rate for the specified key.
 * @param key - the key of the object to process.
 * @returns {float}
 */
- (float) scrollViewDecelerationRateForKey:(id) key;

/**
 * Gets the scroll view indicator style for the specified key.
 * @param key - the key of the object to process.
 * @returns {UIScrollViewIndicatorStyle}
 */
- (UIScrollViewIndicatorStyle) scrollViewIndicatorStyleForKey:(id) key;

/**
 * Gets the scroll view keyboard dismiss mode for the specified key.
 * @param key - the key of the object to process.
 * @returns {UIScrollViewKeyboardDismissMode}
 */
- (UIScrollViewKeyboardDismissMode) scrollViewKeyboardDismissModeForKey:(id) key;

#pragma mark Edge Insets
/**
 * Converts the current Dictionary into a UIEdgeInsets format.
 * @returns {UIEdgeInsets}
 */
- (UIEdgeInsets) toEdgeInsets;

/**
 * Gets the edge insets value of the specified key.
 * @param key - the key of the object to process.
 * @returns {UIEdgeInsets}
 */
- (UIEdgeInsets) edgeInsetsForKey:(id) key;

#pragma mark Regular Expression
/**
 * Converts the object at the specified key into a regular expression.
 * @param key - the key of the object to process.
 * @returns {NSRegularExpression}
 */
- (NSRegularExpression *)expressionForKey:(id) key;

#pragma mark Multidimensional Vectors
/**
 * Gets the CGPoint equivalent of the value.
 * @param key - the key to get the value from.
 * @returns {CGPoint} a valid CGPoint, or a CGPointUndefined.
 */
- (CGPoint) pointForKey:(id) key;

/**
 * Gets the CGPoint equivalent of the dictionary.
 * @returns {CGPoint} a valid CGPoint, or a CGPointUndefined.
 */
- (CGPoint) toPoint;

/**
 * Gets the CGSize equivalent of the value.
 * @param key - the key to get the value from.
 * @returns {CGPoint} a valid CGSize, or a CGPointUndefined.
 */
- (CGSize) sizeForKey:(id) key;

/**
 * Gets the CGSize equivalent of the dictionary.
 * @returns {CGPoint} a valid CGSize, or a CGPointUndefined.
 */
- (CGSize) toSize;

/**
 * Gets the CGRect equivalent of the value.
 * @param key - the key to get the value from.
 * @returns {CGPoint} a valid CGSize, or a CGPointUndefined.
 */
- (CGRect) rectForKey:(id) key;

/**
 * Gets the CGRect equivalent of the dictionary.
 * @returns {CGPoint} a valid CGSize, or a CGPointUndefined.
 */
- (CGRect) toRect;

#pragma mark Primitive Processors

/**
 * Gets the 2 Vector Value as a point.
 * @param x1key - the key for x1
 * @param y1Key - the key for y1
 * @returns {CGPoint} representation, or CGPointUndefined if incorrect type.
 */
- (CGPoint) toVec2UsingX1:(id) x1key andY1:(id) y1Key;

/**
 * Gets the 2 Vector Value as a point.
 * @param x1key - the key for x1
 * @param y1Key - the key for y1
 * @param x2Key - the key for x2
 * @param y2Key - the key for y2
 * @returns {CGRect} representation, or CGRectUndefined if incorrect type.
 */
- (CGRect) toVec4UsingX1:(id) x1key y1:(id) y1Key x2:(id) x2Key andY2:(id) y2Key;

#pragma mark Utilities

/**
 * Enumerates through all keys of the dictionary and preforms the block.
 * @param block - the block to be called for each key.
 */
- (void) enumerateKeysUsingBlock:(void(^)( id key, BOOL *stop )) block;

/**
 * Gets a new dictionary matching our dictionary which was overridden by the inputted dictionary.
 * @param overridingDictionary - the dictionary that will override ours.
 */
- (NSDictionary*) overriddenByDictionary:(NSDictionary *)overridingDictionary;

/**
 * Gets a new dictionary matching our dictionary which was recursively overridden by the inputted dictionary.
 * @param overridingDictionary - the dictionary that will override ours.
 */
- (NSDictionary*) overriddenByDictionaryRecursively:(NSDictionary *)overridingDictionary;

#pragma mark Input Sanitization

/**
 * Sanitizes the inputted key to the correct format for usage inside a NSDictionary.
 * @param key - the key to be sanitized.
 */
+ (NSString*) sanitizeKey:(NSString*) key;


#pragma mark Conversions
/**
 * Gets the dictionaries JSON Representation
 */
- (NSString*) toJSON;

@end

// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
//                              Constants
// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
#pragma mark Regular Expression keys
static NSString* sFORegularExpression_type = @"type";
static NSString* sFORegularExpression_content = @"content";
static NSString* sFORegularExpression_type_Literal = @"LITERAL";
static NSString* sFORegularExpression_type_Inclusive = @"INCLUSIVE";
static NSString* sFORegularExpression_type_Exclusive = @"EXCLUSIVE";

#pragma mark Fonts
static NSString* sFOFontName = @"name";
static NSString* sFOFontSize = @"size";

#pragma mark UIKit Conversions
static NSString* sFOXKey = @"x";
static NSString* sFOYKey = @"y";

static NSString* sFOWidthKey = @"width";
static NSString* sFOHeightKey = @"height";

static NSString* sFOEdgeInsets_Left = @"left";
static NSString* sFOEdgeInsets_Right = @"right";
static NSString* sFOEdgeInsets_Top = @"top";
static NSString* sFOEdgeInsets_Bottom = @"bottom";

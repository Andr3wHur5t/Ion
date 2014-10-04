//
//  NSDictionary+IonTypeExtension.m
//  Ion
//
//  Created by Andrew Hurst on 7/22/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "NSDictionary+IonTypeExtension.h"
#import "NSArray+IonExtension.h"
#import "NSData+IonTypeExtension.h"
#import "NSString+TypeExtension.h"
#import "IonKeyValuePair.h"
#import "IonImageRef.h"
#import "IonGradientConfiguration.h"
#import "UIColor+IonColor.h"
#import "NSString+Utilities.h"

// Enviorment variables
#define DebugIonTheme [[[[NSProcessInfo processInfo] environment] objectForKey: @"DebugIonTheme"] boolValue]
#define DebugIonThemeEmpty [[[[NSProcessInfo processInfo] environment] objectForKey: @"DebugIonThemeEmpty"] boolValue]

// Log Functions
#define IonReport(args...) if( DebugIonTheme ) NSLog(@"%s - %@",__PRETTY_FUNCTION__, [NSString stringWithFormat: args]);
#define IonReportEmpty(args...) if( DebugIonThemeEmpty ) IonReport(args);

@implementation NSDictionary (IonTypeExtension)
#pragma mark Fundamental Objects
/**
 * Gets the NSString of the keyed value.
 * @param {id} the key to get the value from.
 * @retruns {NSString*} a valid NSString, or NULL if invalid.
 */
- (NSString*) stringForKey:(id) key {
    NSString* str;
    
    
    NSParameterAssert( key );
    if ( !key ) {
        IonReport( @"No key specified." );
        return NULL;
    }
    
    str = [self objectForKey: key];
    if ( !str ) {
        IonReportEmpty( @"\"%@\" dose not exist!", key );
        return NULL;
    }
    if ( ![str isKindOfClass: [NSString class]] ) {
        IonReport( @"\"%@\" is not a string.", key );
        return NULL;
    }
    
    return str;
}

/**
 * Gets the NSDictionary of the keyed value.
 * @param key -  the key to get the value from.
 * @retruns {NSDictionary*} a valid NSDictionary, or NULL if invalid.
 */
- (NSDictionary*) dictionaryForKey:(id) key {
    return [self dictionaryForKey: key defaultValue: NULL];
}

/**
 * Gets the NSDictionary of the keyed value.
 * @param key - the key to get the value from.
 * @param defaultValue - the value to return if invalid.
 * @retruns {NSDictionary*} a valid NSDictionary, or NULL if invalid.
 */
- (NSDictionary*) dictionaryForKey:(id) key defaultValue:(id) defaultValue {
    NSDictionary* dict;
    
    NSParameterAssert( key );
    if ( !key ) {
        IonReport( @"No key specified." );
        return defaultValue;
    }
    
    dict = [self objectForKey: key];
    if ( !dict ) {
        IonReportEmpty( @"\"%@\" dose not exist!", key );
        return defaultValue;
    }
    if ( ![dict isKindOfClass: [NSDictionary class]] ) {
        IonReport( @"\"%@\" is not a dictionary.", key );
        return defaultValue;
    }
    
    return dict;
}

/**
 * Gets the NSArray of the keyed value.
 * @param {id} the key to get the value from.
 * @retruns {NSArray*} a valid NSArray, or NULL if invalid.
 */
- (NSArray*) arrayForKey:(id) key {
    NSArray* arr;
    
    NSParameterAssert( key );
    if ( !key ) {
        IonReport( @"No key specified." );
        return NULL;
    }
    
    arr = [self objectForKey: key];
    if ( !arr ) {
        IonReportEmpty( @"\"%@\" dose not exist!", key );
        return NULL;
    }
    if ( ![arr isKindOfClass: [NSArray class]] ) {
        IonReport( @"\"%@\" is not an array.", key );
        return NULL;
    }
    
    return arr;
}

/**
 * Gets the NSNumber of the keyed value.
 * @param key - the key to get the value from.
 * @retruns {NSNumber*} a valid NSNumber, or NULL if invalid.
 */
- (NSNumber*) numberForKey:(id) key {
    return [self numberForKey: key defaultValue: NULL];
}

/**
 * Gets the NSNumber of the keyed value.
 * @param key - the key to get the value from.
 * @retruns {NSNumber*} a valid NSNumber, or the default value.
 */
- (NSNumber*) numberForKey:(id) key defaultValue:(id) defaultValue {
    NSNumber* num;
    
    NSParameterAssert( key );
    if ( !key ) {
        IonReport( @"No key specified." );
        return defaultValue;
    }
    
    num = [self objectForKey: key];
    if ( !num ) {
        IonReportEmpty( @"\"%@\" dose not exist!", key );
        return defaultValue;
    }
    if ( ![num isKindOfClass: [NSNumber class]] ) {
        IonReport( @"\"%@\" is not a number", key );
        return defaultValue;
    }
    
    return num;
}

/**
 * Gets the BOOL of the keyed value.
 * @param {id} the key to get the value from.
 * @retruns {BOOL} a valid BOOL, or false.
 */
- (BOOL) boolForKey:(id) key {
    return [self boolForKey: key defaultValue: NO];
}

/**
 * Gets the BOOL of the keyed value.
 * @param key - the key to get the value from.
 * @param default - the default value to return on failure.
 * @retruns {BOOL}
 */
- (BOOL) boolForKey:(id) key defaultValue:(BOOL) defaultValue {
    NSNumber* num;
    NSParameterAssert( key );
    if ( !key ) {
        IonReport( @"No key specified." );
        return defaultValue;
    }
    
    num = [self numberForKey: key];
    if ( !num )
        return defaultValue;
    
    return [num boolValue];
}

#pragma mark Configuration Objects
/**
 * Gets the UIColor of the keyed value.
 * Note: will only convert from Hex in any of the following formats #RBG #RBGA #RRBBGG #RRBBGGAA
 * @param {id} the key to get the value from.
 * @retruns {UIColor*} a valid UIColor, or NULL if invalid.
 */
- (UIColor*) colorFromKey:(id) key {
    NSString* hexString;
    
    NSParameterAssert( key );
    if ( !key ) {
        IonReport( @"No key specified." );
        return NULL;
    }

    hexString = [self stringForKey: key];
    if ( !hexString )
        return NULL;
    
    return [UIColor colorFromHexString: hexString];;
}

/**
 * Gets the IonColorWeight of the keyed value.
 * @param {id} the key to get the value from.
 * @retruns {IonColorWeight*} a valid IonColorWeight, or NULL if invalid.
 */
- (IonColorWeight*) colorWeightForKey:(id) key {
    NSDictionary* dict;
    
    NSParameterAssert( key );
    if ( !key ) {
        IonReport( @"No key specified." );
        return NULL;
    }
    
    dict = [self dictionaryForKey: key];
    if ( !dict )
        return NULL;
    
    return [dict toColorWeight];
}

/**
 * Gets the IonColorWeight equivalent of the dictionary.
 * @retruns {IonColorWeight*} a valid IonColorWeight, or NULL if invalid.
 */
- (IonColorWeight*) toColorWeight {
    IonColorWeight* result;
    UIColor* color;
    NSNumber* weight;
    
    color = [self colorFromKey: sIonColorKey];
    weight = [self numberForKey: sIonWeightKey];
    if ( !color || !weight )
        return NULL;
    
    result = [[IonColorWeight alloc] initWithColor: color andWeight: [weight floatValue]];
    return result;
}

/**
 * Gets an NSArray of IonColorWeights from the keyed value.
 * @param {id} the key to get the value from.
 * @retruns {NSArray*} a valid NSArray of IonColorWeights, or NULL if invalid.
 */
- (NSArray*) colorWeightsForKey:(id) key {
    NSDictionary* dict;
    NSArray *rawColorWeights;
    NSMutableArray* colorWeights;
    
    NSParameterAssert( key );
    if ( !key ) {
        IonReport( @"No key specified." );
        return NULL;
    }
    
    dict = [self dictionaryForKey: key];
    if ( !dict )
        return NULL;
    
    
    rawColorWeights = [self arrayForKey: sIonWeightKey];
    if ( !rawColorWeights )
        return NULL;
    
    colorWeights = [[NSMutableArray alloc] init];
    for ( NSDictionary* cw in rawColorWeights )
        [colorWeights addObject: [cw toColorWeight]];
    
    return colorWeights;
}

/**
 * Gets the IonGradientConfiguration of the keyed value.
 * @param {id} the key to get the value from.
 * @retruns {IonGradientConfiguration*} a valid IonGradientConfiguration, or NULL if invalid.
 */
- (IonGradientConfiguration*) gradientConfigurationForKey:(id) key {
    NSDictionary* dict;
    NSParameterAssert( key );
    if ( !key ) {
        IonReport( @"No key specified." );
        return NULL;
    }
    
    dict = [self dictionaryForKey: key];
    if ( !dict )
        return NULL;
        
    return [dict toGradientConfiguration];
}

/**
 * Gets the IonGradientConfiguration equivalent of the dictionary.
 * @retruns {IonGradientConfiguration*} a valid IonGradientConfiguration, or NULL if invalid.
 */
- (IonGradientConfiguration*) toGradientConfiguration {
    IonGradientConfiguration* gradConfig;
    NSString* type;
    
    type = [self stringForKey: sIonGradientTypeKey];
    if ( !type )
        return NULL;
        
    if ( [type isEqualToString: sIonGradientTypeLinear] )
        gradConfig = [self toLinearGradientConfiguration];
    else
        gradConfig = [self toLinearGradientConfiguration];
    
    return gradConfig;
}

/**
 * Gets the IonLinearGradientConfiguration of the keyed value.
 * @param {id} the key to get the value from.
 * @retruns {IonLinearGradientConfiguration*} a valid IonLinearGradientConfiguration, or NULL if invalid.
 */
- (IonLinearGradientConfiguration*) linearGradientConfigurationForKey:(id) key {
    NSDictionary* dict;
    NSParameterAssert( key );
    if ( !key ) {
        IonReport( @"No key specified." );
        return NULL;
    }
    
    dict = [self dictionaryForKey: key];
    if ( !dict )
        return NULL;
    
    return [dict toLinearGradientConfiguration];
}

/**
 * Gets the IonGradientConfiguration equivalent of the dictionary.
 * @retruns {IonColorWeight*} a valid IonLinearGradientConfiguration, or NULL if invalid.
 */
- (IonLinearGradientConfiguration*) toLinearGradientConfiguration {
    NSNumber* angle;
    NSArray* colorWeights;
    
    colorWeights = [self colorWeightsForKey: sIonColorWeightsKey];
    if ( !colorWeights )
        return NULL;
    
    angle = [self numberForKey: sIonGradientAngleKey];
    if ( !angle ) {
        IonReport( @"No valid angle specified defaulting to 90" );
        angle = @90.0f;
    }
    
    return [[IonLinearGradientConfiguration alloc] initWithColor: colorWeights andAngel: [angle floatValue]];
}


/**
 * Gets the IonImageRef of the keyed value.
 * @param {id} the key to get the value from.
 * @retruns {IonImageRef*} a valid IonImageRef, or NULL if invalid.
 */
- (IonImageRef*) imageRefFromKey:(id) key {
    NSString* fileNameString;
    IonImageRef* result;
    NSParameterAssert( key );
    if ( !key ) {
        IonReport( @"No key specified." );
        return NULL;
    }
    
    result = [[IonImageRef alloc] init];
    fileNameString = [self stringForKey: key];
    if ( !fileNameString )
        return NULL;
    
    result.fileName = fileNameString;
    return result;
}

#pragma mark Fonts
/**
 * Converts the dictionary to a font.
 * @returns {UIFont*} the resulting font, or NULL if invalid.
 */
- (UIFont*) toFont {
    NSString* fontName;
    NSNumber* fontSize;
    
    fontName = [self stringForKey: sIonFontName];
    if ( !fontName )
        return NULL;
    
    fontSize = [self numberForKey: sIonFontSize];
    if ( !fontSize )
        return NULL;
    
    return [UIFont fontWithName: fontName size: [fontSize floatValue]];
}

/**
 * Gets the font for the specified key.
 * @param {id} the key for the font.
 * @returns {UIFont} the resulting font, or NULL if invalid.
 */
- (UIFont*) fontForKey:(id) key {
    NSDictionary* dict;
    NSParameterAssert( key );
    if ( !key ) {
        IonReport( @"No key specified." );
        return NULL;
    }
    
    dict = [self dictionaryForKey: key];
    if ( !dict )
        return NULL;
    
    return [dict toFont];
}

/**
 * Gets the text alignment representation at the specified key.
 * @param {id} the key for the text alignment.
 * @returns {NSTextAlignment}
 */
- (NSTextAlignment) textAlignmentForKey:(id) key {
    NSString* val;
    NSParameterAssert( key );
    if ( !key ) {
        IonReport( @"No key specified." );
        return NSTextAlignmentNatural;
    }
    
    val = [self stringForKey: key];
    if ( !val )
        return NSTextAlignmentNatural;
    
    return [val toTextAlignment];
}

#pragma mark Keyboard
/**
 * Gets the KeyboardType representation at the specified key.
 * @param {id} the key for the keyboardType.
 * @returns {UIKeyboardType}
 */
- (UIKeyboardType) keyboardTypeForKey:(id) key {
    NSString* val;
    NSParameterAssert( key );
    if ( !key ) {
        IonReport( @"No key specified." );
        return UIKeyboardTypeDefault;
    }
    
    val = [self stringForKey: key];
    if ( !val )
        return UIKeyboardTypeDefault;
    
    return [val toKeyboardType];
}

/**
 * Gets the KeyboardAppearance representation at the specified key.
 * @param {id} the key for the KeyboardAppearance.
 * @returns {UIKeyboardAppearance}
 */
- (UIKeyboardAppearance) keyboardAppearanceForKey:(id) key {
    NSString* val;
    NSParameterAssert( key );
    if ( !key ) {
        IonReport( @"No key specified." );
        return UIKeyboardAppearanceDefault;
    }
    
    val = [self stringForKey: key];
    if ( !val )
        return UIKeyboardAppearanceDefault;
    
    return [val toKeyboardAppearance];
}

/**
 * Gets the ReturnKeyType representation at the specified key.
 * @param {id} the key for the ReturnKeyType.
 * @returns {UIReturnKeyType}
 */
- (UIReturnKeyType) returnKeyTypeForKey:(id) key {
    NSString* val;
    NSParameterAssert( key );
    if ( !key ) {
        IonReport( @"No key specified." );
        return UIReturnKeyDefault;
    }
    
    val = [self stringForKey: key];
    if ( !val )
        return UIReturnKeyDefault;
    
    return [val toReturnKeyType];
}

/**
 * Gets the UITextAutocapitalizationType representation at the specified key.
 * @param {id} the key for the UITextAutocapitalizationType.
 * @returns {UITextAutocapitalizationType}
 */
- (UITextAutocapitalizationType) autocapitalizationTypeForKey:(id) key {
    NSString* val;
    NSParameterAssert( key );
    if ( !key ) {
        IonReport( @"No key specified." );
        return UITextAutocapitalizationTypeSentences;
    }
    
    val = [self stringForKey: key];
    if ( !val )
        return UITextAutocapitalizationTypeSentences;

    return [val toAutocapitalizationType];
}

/**
 * Gets the UITextAutocorrectionType representation at the specified key.
 * @param {id} the key for the UITextAutocorrectionType.
 * @returns {UITextAutocorrectionType}
 */
- (UITextAutocorrectionType) autocorrectionTypeForKey:(id) key {
    NSString* val;
    NSParameterAssert( key );
    if ( !key ) {
        IonReport( @"No key specified." );
        return UITextAutocorrectionTypeDefault;
    }
    
    val = [self stringForKey: key];
    if ( !val )
        return UITextAutocorrectionTypeDefault;
    
    return [val toAutocorrectionType];
}

/**
 * Gets the UITextSpellCheckingType representation at the specified key.
 * @param {id} the key for the UITextSpellCheckingType.
 * @returns {UITextSpellCheckingType}
 */
- (UITextSpellCheckingType) spellcheckTypeForKey:(id) key {
    NSString* val;
    NSParameterAssert( key );
    if ( !key ) {
        IonReport( @"No key specified." );
        return UITextSpellCheckingTypeDefault;
    }
    
    val = [self stringForKey: key];
    if ( !val )
        return UITextSpellCheckingTypeDefault;
    
    return [val toSpellCheckingType];
}

#pragma mark Scroll View
/**
 * Gets the deceleration rate for the specified key.
 * @param key - the key of the object to process.
 * @returns {float}
 */
- (float) scrollViewDecelerationRateForKey:(id) key {
    id value;
    NSParameterAssert( key );
    if ( !key )
        return UIScrollViewDecelerationRateNormal;
    
    value = [self objectForKey: key];
    if ( [value isKindOfClass: [NSString class]] )
        return [((NSString *)value) toScrollViewDecelerationRateConstant];
    else if ( [value isKindOfClass: [NSNumber class]] )
        return [((NSNumber *)value) floatValue];
    else
        return UIScrollViewDecelerationRateNormal;
}

/**
 * Gets the scroll view indicator style for the specified key.
 * @param key - the key of the object to process.
 * @returns {UIScrollViewIndicatorStyle}
 */
- (UIScrollViewIndicatorStyle) scrollViewIndicatorStyleForKey:(id) key {
    NSString *value;
    NSParameterAssert( key );
    if ( !key )
        return UIScrollViewIndicatorStyleDefault;
    
    value = [self stringForKey: key];
    if ( !value )
        return UIScrollViewIndicatorStyleDefault;
    
    return [value toScrollViewIndicatorStyle];
}

/**
 * Gets the scroll view keyboard dismiss mode for the specified key.
 * @param key - the key of the object to process.
 * @returns {UIScrollViewKeyboardDismissMode}
 */
- (UIScrollViewKeyboardDismissMode) scrollViewKeyboardDismissModeForKey:(id) key {
    NSString *value;
    NSParameterAssert( key );
    if ( !key )
        return UIScrollViewKeyboardDismissModeNone;
    
    value = [self stringForKey: key];
    if ( !value )
        return UIScrollViewKeyboardDismissModeNone;
    
    return [value toScrollViewKeyboardDismissMode];
}

#pragma mark Edge Insets
/**
 * Converts the current Dictionary into a UIEdgeInsets format.
 * @returns {UIEdgeInsets}
 */
- (UIEdgeInsets) toEdgeInsets {
    return (UIEdgeInsets){
        [[self numberForKey: sIonEdgeInsets_Top defaultValue: @0.0] floatValue],
        [[self numberForKey: sIonEdgeInsets_Left defaultValue: @0.0] floatValue],
        [[self numberForKey: sIonEdgeInsets_Bottom defaultValue: @0.0] floatValue],
        [[self numberForKey: sIonEdgeInsets_Right defaultValue: @0.0] floatValue]
    };
}

/**
 * Gets the edge insets value of the specified key.
 * @param key - the key of the object to process.
 * @returns {UIEdgeInsets}
 */
- (UIEdgeInsets) edgeInsetsForKey:(id) key {
    return [[self dictionaryForKey: key defaultValue: @{}] toEdgeInsets];
}

#pragma mark Regular Expression
/**
 * Converts the object at the specified key into a regular expression.
 * @param key - the key of the object to process.
 * @returns {NSRegularExpression}
 */
- (NSRegularExpression *)expressionForKey:(id) key {
    NSString *type, *content;
    id value;
    
    NSParameterAssert( key );
    if ( !key )
        return NULL;
    
    value = [self objectForKey: key];
    if ( !value ) {
        IonReport( @"No value at the target key." );
        return NULL;
    }
    
    if ( [value isKindOfClass: [NSString class]] )
        return [value toExpresion];
    else if ( [value isKindOfClass: [NSDictionary class]] ) {
        // Get type
        type = [value objectForKey: sIonRegularExpression_type];
        if ( !type || ![type isKindOfClass: [NSString class]] ) {
            IonReport( @"Type was not a string, defaulting to literal processing.");
            type = sIonRegularExpression_type_Literal; // Default to the content being literal
        }
        
        // Get content
        content = [value objectForKey: sIonRegularExpression_content];
        if ( !content || ![content isKindOfClass: [NSString class]] ) {
            IonReport( @"Content was not a string!" );
            return NULL; // We have no valid content, don't bother doing anything else
        }
        
        // Create pattern
        if ( [type.uppercaseString isEqualToString: sIonRegularExpression_type_Inclusive] )
            return [content toInclusiveExpression];
        else if ( [type.uppercaseString isEqualToString: sIonRegularExpression_type_Exclusive] )
            return [content toExclusiveExpression];
        else // Literal
            return [content toExpresion];
    }
    else {
        IonReport( @"%@ is not a valid type for regular expression generation.", NSStringFromClass( [value class] ));
        return NULL; // Not a supported type NULL
    }
}

#pragma mark Multidimensional Vectors
/**
 * Gets the CGPoint Equivalent of the value.
 * @param {id} the key to get the value from.
 * @returns {CGPoint} a valid CGPoint, or a CGPointUndefined.
 */
- (CGPoint) pointForKey:(id) key {
    NSDictionary* dict;
    
    NSParameterAssert( key );
    if ( !key ) {
        IonReport( @"No key specified." );
        return CGPointUndefined;
    }
    
    dict = [self dictionaryForKey: key];
    if ( !dict )
        return CGPointUndefined;
    
    return [dict toPoint];
}

/**
 * Gets the CGPoint Equivalent of the dictionary.
 * @returns {CGPoint} a valid CGPoint, or a CGPointUndefined.
 */
- (CGPoint) toPoint {
    return [self toVec2UsingX1: sIonXKey andY1: sIonYKey];
}

/**
 * Gets the CGSize Equivalent of the value.
 * @param {id} the key to get the value from.
 * @returns {CGPoint} a valid CGSize, or a CGPointUndefined.
 */
- (CGSize) sizeForKey:(id) key {
    NSDictionary* dict;
    
    NSParameterAssert( key );
    if ( !key ) {
        IonReport( @"No key specified." );
        return CGSizeUndefined;
    }
    
    dict = [self dictionaryForKey: key];
    if ( !dict )
        return CGSizeUndefined;
    
    return [dict toSize];
}

/**
 * Gets the CGSize Equivalent of the dictionary.
 * @returns {CGPoint} a valid CGSize, or a CGPointUndefined.
 */
- (CGSize) toSize {
    CGPoint reference = [self toVec2UsingX1: sIonWidthKey andY1: sIonHeightKey];
    return (CGSize){ reference.x, reference.y };
}

/**
 * Gets the CGRect Equivalent of the value.
 * @param {id} the key to get the value from.
 * @returns {CGPoint} a valid CGSize, or a CGPointUndefined.
 */
- (CGRect) rectForKey:(id) key {
    NSDictionary* dict;
    
    NSParameterAssert( key );
    if ( !key ) {
        IonReport( @"No key specified." );
        return CGRectUndefined;
    }
    
    dict = [self dictionaryForKey: key];
    if ( !dict )
        return CGRectUndefined;
    
    return [dict toRect];
}

/**
 * Gets the CGRect Equivalent of the dictionary.
 * @returns {CGPoint} a valid CGSize, or a CGPointUndefined.
 */
- (CGRect) toRect {
    return [self toVec4UsingX1: sIonXKey
                            y1: sIonYKey
                            x2: sIonWeightKey
                         andY2: sIonHeightKey];
}


#pragma mark Primitive Processors

/**
 * Gets the 2 Vector Value as a point.
 * @param {id} the key for x1
 * @param {id} the key for y1
 * @returns {CGPoint} representation, or CGPointUndefined if incorrect type.
 */
- (CGPoint) toVec2UsingX1:(id) x1key andY1:(id) y1Key {
    NSNumber *x1, *y1;
    if ( !x1key || !y1Key ) {
        IonReport( @"A key was not specified." );
        return CGPointUndefined;
    }
    
    x1 = [self numberForKey: x1key];
    y1 = [self numberForKey: y1Key];
    if ( !x1 || !y1)
        return CGPointUndefined;
    
    return (CGPoint){ [x1 floatValue], [y1 floatValue] };
}
/**
 * Gets the 2 Vector Value as a point.
 * @param {id} the key for x1
 * @param {id} the key for y1
 * @param {id} the key for x2
 * @param {id} the key for y2
 * @returns {CGRect} representation, or CGRectUndefined if incorrect type.
 */
- (CGRect) toVec4UsingX1:(id) x1key y1:(id) y1Key x2:(id) x2Key andY2:(id) y2Key {
    NSNumber *x1, *y1, *x2, *y2;
    if ( !x1key || !y1Key )
        return CGRectUndefined;
    
    x1 = [self numberForKey: x1key];
    y1 = [self numberForKey: y1Key];
    x2 = [self numberForKey: x2Key];
    y2 = [self numberForKey: y2Key];
    if ( !x1 || !y1 || !y2 || !x2 )
        return CGRectUndefined;
    
    return (CGRect){ [x1 floatValue], [y1 floatValue], [x2 floatValue], [y2 floatValue] };
}

#pragma mark Utilities

/**
 * Enumerates through all keys of the dictionary and preforms the block.
 * @param { void(^)( id key, BOOL* stop ) } the block to be called for each key.
 * @returns {void}
 */
- (void) enumerateKeysUsingBlock:(void(^)( id key, BOOL* stop )) block {
    BOOL* stop = FALSE;
    if ( !block )
        return;
    
    for ( NSString* key in self.allKeys ) {
        block( key, stop );
        if ( stop )
            return;
    }
}

/**
 * Gets a new dictionary matching our dictionary which was overridden by the inputted dictionary.
 * @param {NSDictionary*} the dictionary that will override ours.
 * @returns {NSDictionary*}
 */
- (NSDictionary*) overriddenByDictionary:(NSDictionary*) overridingDictionary {
    NSMutableDictionary* opDict;
    NSParameterAssert( overridingDictionary && [overridingDictionary isKindOfClass: [NSDictionary class]] );
    if ( !overridingDictionary || ![overridingDictionary isKindOfClass: [NSDictionary class]] )
        return [[NSDictionary alloc] initWithDictionary: self];
    
    opDict = [[NSMutableDictionary alloc] initWithDictionary: self];
    
    [overridingDictionary enumerateKeysAndObjectsUsingBlock: ^(id key, id obj, BOOL *stop) {
        [opDict setObject: obj forKey: key];
    }];
    
    return [[NSDictionary alloc] initWithDictionary: opDict];
}

/**
 * Gets a new dictionary matching our dictionary which was recursively overridden by the inputted dictionary.
 * @param {NSDictionary*} the dictionary that will override ours.
 * @returns {NSDictionary*}
 */
- (NSDictionary*) overriddenByDictionaryRecursively:(NSDictionary*) overridingDictionary {
    NSMutableDictionary* opDict;
    __block id currentItem;
    NSParameterAssert( overridingDictionary && [overridingDictionary isKindOfClass: [NSDictionary class]] );
    if ( !overridingDictionary || ![overridingDictionary isKindOfClass: [NSDictionary class]] )
        return [[NSDictionary alloc] initWithDictionary: self];
    
    opDict = [[NSMutableDictionary alloc] initWithDictionary: self];
    
    [overridingDictionary enumerateKeysAndObjectsUsingBlock: ^(id key, id obj, BOOL *stop) {
        currentItem = [opDict objectForKey: key];
        
        if ( [currentItem isKindOfClass: [NSDictionary class]] && [obj isKindOfClass: [NSDictionary class]] )
            obj = [(NSDictionary*)currentItem overriddenByDictionaryRecursively: obj];
        
        if ( [currentItem isKindOfClass: [NSArray class]] && [obj isKindOfClass: [NSArray class]] )
            obj = [(NSArray*)currentItem overwriteRecursivelyWithArray: obj];
        
        
        [opDict setObject: obj forKey: key];
    }];
    
    return [[NSDictionary alloc] initWithDictionary: opDict];
}

#pragma mark Input Sanitization

/**
 * Sanitizes the inputted key to the correct format for usage inside a NSDictionary.
 * @param {NSString*} the key to be sanitized.
 * @returns {NSString*} the sanitized string, or NULL if invalid.
 */
+ (NSString*) sanitizeKey:(NSString*) key {
    NSParameterAssert( key && [key isKindOfClass: [NSString class]] );
    if ( !key || ![key isKindOfClass: [NSString class]] )
        return NULL;
    return [key replaceMatches: [@"[^a-zA-Z0-9\\@\\$\\&\\?\\[\\]\\~\\(\\)\\*\\+\\&/_]+" toExpresion] withString: @"-"];
}


#pragma mark Conversion

/**
 * Gets the dictionaries JSON Representation
 * @returns {NSString*} the JSON representation
 */
- (NSString*) toJSON {
    return [[NSJSONSerialization dataWithJSONObject: self
                                            options: NSJSONWritingPrettyPrinted
                                              error: NULL] toString];
}

@end

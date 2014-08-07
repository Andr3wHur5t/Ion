//
//  NSDictionary+IonTypeExtension.m
//  Ion
//
//  Created by Andrew Hurst on 7/22/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "NSDictionary+IonTypeExtension.h"
#import "NSArray+IonExtension.h"
#import "IonKeyValuePair.h"
#import "IonImageRef.h"
#import "IonGradientConfiguration.h"
#import "UIColor+IonColor.h"



@implementation NSDictionary (IonTypeExtension)
#pragma mark Fundamental Objects

/**
 * Gets the NSString of the keyed value.
 * @param {id} the key to get the value from.
 * @retruns {NSString*} a valid NSString, or NULL if invalid.
 */
- (NSString*) stringForKey:(id) key {
    NSString* str;
    if ( !key )
        return NULL;
    
    str = [self objectForKey: key];
    if ( !str || ![str isKindOfClass: [NSString class]] )
        return NULL;
    
    return str;
}

/**
 * Gets the NSDictionary of the keyed value.
 * @param {id} the key to get the value from.
 * @retruns {NSDictionary*} a valid NSDictionary, or NULL if invalid.
 */
- (NSDictionary*) dictionaryForKey:(id) key {
    NSDictionary* dict;
    if ( !key )
        return NULL;
    
    dict = [self objectForKey: key];
    if ( !dict || ![dict isKindOfClass: [NSDictionary class]] )
        return NULL;
    
    return dict;
}

/**
 * Gets the NSArray of the keyed value.
 * @param {id} the key to get the value from.
 * @retruns {NSArray*} a valid NSArray, or NULL if invalid.
 */
- (NSArray*) arrayForKey:(id) key {
    NSArray* arr;
    if ( !key )
        return NULL;
    
    arr = [self objectForKey: key];
    if ( !arr || ![arr isKindOfClass: [NSArray class]] )
        return NULL;
    
    return arr;
}

/**
 * Gets the NSNumber of the keyed value.
 * @param {id} the key to get the value from.
 * @retruns {NSNumber*} a valid NSNumber, or NULL if invalid.
 */
- (NSNumber*) numberForKey:(id) key {
    NSNumber* num;
    if ( !key )
        return NULL;
    
    num = [self objectForKey: key];
    if ( !num || ![num isKindOfClass: [NSNumber class]] )
        return NULL;
    
    return num;
}

/**
 * Gets the BOOL of the keyed value.
 * @param {id} the key to get the value from.
 * @retruns {BOOL} a valid BOOL, or false.
 */
- (BOOL) boolForKey:(id) key {
    NSNumber* num;
    if ( !key )
        return NO;
    
    num = [self numberForKey: key];
    if ( !num )
        return NO;
    
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
    if ( !key )
        return NULL;

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
    if ( !key )
        return NULL;
    
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
    
    if ( !key )
        return NULL;
    
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
    if ( !key )
        return NULL;
    
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
    if ( !key )
        return NULL;
    
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
    if ( !angle )
        angle = @90.0f;
    
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
    if ( !key )
        return NULL;
    
    result = [[IonImageRef alloc] init];
    fileNameString = [self stringForKey: key];
    if ( !fileNameString )
        return NULL;
    
    result.fileName = fileNameString;
    return result;
}


#pragma mark Multidimensional Vectors
/**
 * Gets the CGPoint Equivalent of the value.
 * @param {id} the key to get the value from.
 * @returns {CGPoint} a valid CGPoint, or a CGPointUndefined.
 */
- (CGPoint) pointForKey:(id) key {
    NSDictionary* dict;
    if ( !key )
        return CGPointUndefined;
    
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
    if ( !key )
        return CGSizeUndefined;
    
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
    CGPoint reference = [self toVec2UsingX1: sIonWeightKey andY1: sIonHeightKey];
    if ( CGPointEqualToPoint( reference, CGPointUndefined ) )
        return CGSizeUndefined;
    
    return (CGSize){ reference.x, reference.y };
}

/**
 * Gets the CGRect Equivalent of the value.
 * @param {id} the key to get the value from.
 * @returns {CGPoint} a valid CGSize, or a CGPointUndefined.
 */
- (CGRect) rectForKey:(id) key {
    NSDictionary* dict;
    if ( !key )
        return CGRectUndefined;
    
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
    if ( !x1key || !y1Key )
        return CGPointUndefined;
    
    x1 = [self objectForKey: x1key];
    y1 = [self objectForKey: y1Key];
    if ( !x1 || ![x1 isKindOfClass: [NSNumber class]] ||
        !y1 || ![y1 isKindOfClass: [NSNumber class]])
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
    
    x1 = [self objectForKey: x1key];
    y1 = [self objectForKey: y1Key];
    x2 = [self objectForKey: x2Key];
    y2 = [self objectForKey: y2Key];
    if ( !x1 || ![x1 isKindOfClass: [NSNumber class]] ||
        !y1 || ![y1 isKindOfClass: [NSNumber class]] ||
        !y2 || ![y2 isKindOfClass: [NSNumber class]] ||
        !x2 || ![x2 isKindOfClass: [NSNumber class]])
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
    if ( !overridingDictionary )
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
    if ( !overridingDictionary )
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
    NSRegularExpression* sanitizationExpression;
    if ( !key || ![key isKindOfClass: [NSString class]] )
        return NULL;
    
    // Create Expression
    sanitizationExpression = [[NSRegularExpression alloc] initWithPattern: @"[^a-zA-Z0-9\\@\\$\\&\\?/]+"
                                                      options: 0
                                                        error: NULL];
    
    return [sanitizationExpression stringByReplacingMatchesInString: key
                                                            options: 0
                                                              range: NSMakeRange(0, key.length)
                                                       withTemplate: @"-"];;
}
@end

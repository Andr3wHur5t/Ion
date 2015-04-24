//
//  NSDictionary+FOTypeExtension.m
//  FOUtilities
//
//  Created by Andrew Hurst on 10/9/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "NSDictionary+FOTypeExtension.h"

// String Utilities
#import <FOUtilities/NSString+FOTypeExtension.h>
#import <FOUtilities/NSString+RegularExpression.h>

// Color Utilities
#import <FOUtilities/UIColor+FOColor.h>

// Types
#import <FOUtilities/FOCGTypes.h>

// NSData
#import <FOUtilities/NSData+FOTypeExtension.h>

// NSArray
#import <FOUtilities/NSArray+FOUtilities.h>

// Environment variables
#define DebugFOResolution                     \
  [[[[NSProcessInfo processInfo] environment] \
      objectForKey:@"DebugIonTheme"] boolValue]
#define DebugFOResolutionEmpty                \
  [[[[NSProcessInfo processInfo] environment] \
      objectForKey:@"DebugIonThemeEmpty"] boolValue]

// Log Functions
#define FOReport(args...) \
  if (DebugFOResolution)  \
    NSLog(@"%s - %@", __PRETTY_FUNCTION__, [NSString stringWithFormat:args]);
#define FOReportEmpty(args...) \
  if (DebugFOResolutionEmpty) FOReport(args);

@implementation NSDictionary (FOTypeExtension)
#pragma mark Fundamental Objects

- (NSString*)stringForKey:(id)key {
  NSString* str;

  NSParameterAssert(key);
  if (!key) {
    FOReport(@"No key specified.");
    return NULL;
  }

  str = [self objectForKey:key];
  if (!str) {
    FOReportEmpty(@"\"%@\" dose not exist!", key);
    return NULL;
  }
  if (![str isKindOfClass:[NSString class]]) {
    FOReport(@"\"%@\" is not a string.", key);
    return NULL;
  }

  return str;
}

- (NSDictionary*)dictionaryForKey:(id)key {
  return [self dictionaryForKey:key defaultValue:NULL];
}

- (NSDictionary*)dictionaryForKey:(id)key defaultValue:(id)defaultValue {
  NSDictionary* dict;

  if (!key) {
    FOReport(@"No key specified.");
    return defaultValue;
  }

  dict = [self objectForKey:key];
  if (!dict) {
    FOReportEmpty(@"\"%@\" dose not exist!", key);
    return defaultValue;
  }
  if (![dict isKindOfClass:[NSDictionary class]]) {
    FOReport(@"\"%@\" is not a dictionary.", key);
    return defaultValue;
  }

  return dict;
}

- (NSArray*)arrayForKey:(id)key {
  NSArray* arr;

  NSParameterAssert(key);
  if (!key) {
    FOReport(@"No key specified.");
    return NULL;
  }

  arr = [self objectForKey:key];
  if (!arr) {
    FOReportEmpty(@"\"%@\" dose not exist!", key);
    return NULL;
  }
  if (![arr isKindOfClass:[NSArray class]]) {
    FOReport(@"\"%@\" is not an array.", key);
    return NULL;
  }

  return arr;
}

- (NSNumber*)numberForKey:(id)key {
  return [self numberForKey:key defaultValue:NULL];
}

- (NSNumber*)numberForKey:(id)key defaultValue:(id)defaultValue {
  NSNumber* num;

  NSParameterAssert(key);
  if (!key) {
    FOReport(@"No key specified.");
    return defaultValue;
  }

  num = [self objectForKey:key];
  if (!num) {
    FOReportEmpty(@"\"%@\" dose not exist!", key);
    return defaultValue;
  }
  if (![num isKindOfClass:[NSNumber class]]) {
    FOReport(@"\"%@\" is not a number", key);
    return defaultValue;
  }

  return num;
}

- (BOOL)boolForKey:(id)key {
  return [self boolForKey:key defaultValue:NO];
}

- (BOOL)boolForKey:(id)key defaultValue:(BOOL)defaultValue {
  NSNumber* num;
  NSParameterAssert(key);
  if (!key) {
    FOReport(@"No key specified.");
    return defaultValue;
  }

  num = [self numberForKey:key];
  if (!num) return defaultValue;

  return [num boolValue];
}

#pragma mark Configuration Objects
- (UIColor*)colorFromKey:(id)key {
  NSString* hexString;

  NSParameterAssert(key);
  if (!key) {
    FOReport(@"No key specified.");
    return NULL;
  }

  hexString = [self stringForKey:key];
  if (!hexString) return NULL;

  return [UIColor colorFromHexString:hexString];
}

#pragma mark Fonts

- (UIFont*)toFont {
  NSString* fontName;
  NSNumber* fontSize;

  fontName = [self stringForKey:sFOFontName];
  if (!fontName) return NULL;

  fontSize = [self numberForKey:sFOFontSize];
  if (!fontSize) return NULL;

  return [UIFont fontWithName:fontName size:[fontSize floatValue]];
}

- (UIFont*)fontForKey:(id)key {
  NSDictionary* dict;
  NSParameterAssert(key);
  if (!key) {
    FOReport(@"No key specified.");
    return NULL;
  }

  dict = [self dictionaryForKey:key];
  if (!dict) return NULL;

  return [dict toFont];
}

- (NSTextAlignment)textAlignmentForKey:(id)key {
  NSString* val;
  NSParameterAssert(key);
  if (!key) {
    FOReport(@"No key specified.");
    return NSTextAlignmentNatural;
  }

  val = [self stringForKey:key];
  if (!val) return NSTextAlignmentNatural;

  return [val toTextAlignment];
}

#pragma mark Keyboard

- (UIKeyboardType)keyboardTypeForKey:(id)key {
  NSString* val;
  NSParameterAssert(key);
  if (!key) {
    FOReport(@"No key specified.");
    return UIKeyboardTypeDefault;
  }

  val = [self stringForKey:key];
  if (!val) return UIKeyboardTypeDefault;

  return [val toKeyboardType];
}

- (UIKeyboardAppearance)keyboardAppearanceForKey:(id)key {
  NSString* val;
  NSParameterAssert(key);
  if (!key) {
    FOReport(@"No key specified.");
    return UIKeyboardAppearanceDefault;
  }

  val = [self stringForKey:key];
  if (!val) return UIKeyboardAppearanceDefault;

  return [val toKeyboardAppearance];
}

- (UIReturnKeyType)returnKeyTypeForKey:(id)key {
  NSString* val;
  NSParameterAssert(key);
  if (!key) {
    FOReport(@"No key specified.");
    return UIReturnKeyDefault;
  }

  val = [self stringForKey:key];
  if (!val) return UIReturnKeyDefault;

  return [val toReturnKeyType];
}

- (UITextAutocapitalizationType)autocapitalizationTypeForKey:(id)key {
  NSString* val;
  NSParameterAssert(key);
  if (!key) {
    FOReport(@"No key specified.");
    return UITextAutocapitalizationTypeSentences;
  }

  val = [self stringForKey:key];
  if (!val) return UITextAutocapitalizationTypeSentences;

  return [val toAutocapitalizationType];
}

- (UITextAutocorrectionType)autocorrectionTypeForKey:(id)key {
  NSString* val;
  NSParameterAssert(key);
  if (!key) {
    FOReport(@"No key specified.");
    return UITextAutocorrectionTypeDefault;
  }

  val = [self stringForKey:key];
  if (!val) return UITextAutocorrectionTypeDefault;

  return [val toAutocorrectionType];
}

- (UITextSpellCheckingType)spellcheckTypeForKey:(id)key {
  NSString* val;
  NSParameterAssert(key);
  if (!key) {
    FOReport(@"No key specified.");
    return UITextSpellCheckingTypeDefault;
  }

  val = [self stringForKey:key];
  if (!val) return UITextSpellCheckingTypeDefault;

  return [val toSpellCheckingType];
}

#pragma mark Scroll View

- (float)scrollViewDecelerationRateForKey:(id)key {
  id value;
  NSParameterAssert(key);
  if (!key) return UIScrollViewDecelerationRateNormal;

  value = [self objectForKey:key];
  if ([value isKindOfClass:[NSString class]])
    return [((NSString*)value)toScrollViewDecelerationRateConstant];
  else if ([value isKindOfClass:[NSNumber class]])
    return [((NSNumber*)value)floatValue];
  else
    return UIScrollViewDecelerationRateNormal;
}

- (UIScrollViewIndicatorStyle)scrollViewIndicatorStyleForKey:(id)key {
  NSString* value;
  NSParameterAssert(key);
  if (!key) return UIScrollViewIndicatorStyleDefault;

  value = [self stringForKey:key];
  if (!value) return UIScrollViewIndicatorStyleDefault;

  return [value toScrollViewIndicatorStyle];
}

- (UIScrollViewKeyboardDismissMode)scrollViewKeyboardDismissModeForKey:(id)key {
  NSString* value;
  NSParameterAssert(key);
  if (!key) return UIScrollViewKeyboardDismissModeNone;

  value = [self stringForKey:key];
  if (!value) return UIScrollViewKeyboardDismissModeNone;

  return [value toScrollViewKeyboardDismissMode];
}

#pragma mark Edge Insets

- (UIEdgeInsets)toEdgeInsets {
  return (UIEdgeInsets) {
    [[self numberForKey:sFOEdgeInsets_Top defaultValue:@0.0] floatValue],
        [[self numberForKey:sFOEdgeInsets_Left defaultValue:@0.0] floatValue],
        [[self numberForKey:sFOEdgeInsets_Bottom defaultValue:@0.0] floatValue],
        [[self numberForKey:sFOEdgeInsets_Right defaultValue:@0.0] floatValue]
  };
}

- (UIEdgeInsets)edgeInsetsForKey:(id)key {
  return [[self dictionaryForKey:key defaultValue:@{}] toEdgeInsets];
}

#pragma mark Regular Expression

- (NSRegularExpression*)expressionForKey:(id)key {
  NSString* type, *content;
  id value;

  NSParameterAssert(key);
  if (!key) return NULL;

  value = [self objectForKey:key];
  if (!value) {
    FOReport(@"No value at the target key.");
    return NULL;
  }

  if ([value isKindOfClass:[NSString class]])
    return [value toExpresion];
  else if ([value isKindOfClass:[NSDictionary class]]) {
    // Get type
    type = [value objectForKey:sFORegularExpression_type];
    if (!type || ![type isKindOfClass:[NSString class]]) {
      FOReport(@"Type was not a string, defaulting to literal processing.");
      type = sFORegularExpression_type_Literal;  // Default to the content being
                                                 // literal
    }

    // Get content
    content = [value objectForKey:sFORegularExpression_content];
    if (!content || ![content isKindOfClass:[NSString class]]) {
      FOReport(@"Content was not a string!");
      return NULL;  // We have no valid content, don't bother doing anything
                    // else
    }

    // Create pattern
    if ([type.uppercaseString
            isEqualToString:sFORegularExpression_type_Inclusive])
      return [content toInclusiveExpression];
    else if ([type.uppercaseString
                 isEqualToString:sFORegularExpression_type_Exclusive])
      return [content toExclusiveExpression];
    else  // Literal
      return [content toExpresion];
  } else {
    FOReport(@"%@ is not a valid type for regular expression generation.",
             NSStringFromClass([value class]));
    return NULL;  // Not a supported type NULL
  }
}

#pragma mark Multidimensional Vectors

- (CGPoint)pointForKey:(id)key {
  NSDictionary* dict;

  NSParameterAssert(key);
  if (!key) {
    FOReport(@"No key specified.");
    return CGPointUndefined;
  }

  dict = [self dictionaryForKey:key];
  if (!dict) return CGPointUndefined;

  return [dict toPoint];
}

- (CGPoint)toPoint {
  return [self toVec2UsingX1:sFOXKey andY1:sFOYKey];
}

- (CGSize)sizeForKey:(id)key {
  NSDictionary* dict;

  NSParameterAssert(key);
  if (!key) {
    FOReport(@"No key specified.");
    return CGSizeUndefined;
  }

  dict = [self dictionaryForKey:key];
  if (!dict) return CGSizeUndefined;

  return [dict toSize];
}

- (CGSize)toSize {
  CGPoint reference = [self toVec2UsingX1:sFOWidthKey andY1:sFOHeightKey];
  return (CGSize){reference.x, reference.y};
}

- (CGRect)rectForKey:(id)key {
  NSDictionary* dict;

  NSParameterAssert(key);
  if (!key) {
    FOReport(@"No key specified.");
    return CGRectUndefined;
  }

  dict = [self dictionaryForKey:key];
  if (!dict) return CGRectUndefined;

  return [dict toRect];
}

- (CGRect)toRect {
  return [self toVec4UsingX1:sFOXKey
                          y1:sFOYKey
                          x2:sFOHeightKey
                       andY2:sFOHeightKey];
}

#pragma mark Primitive Processors

- (CGPoint)toVec2UsingX1:(id)x1key andY1:(id)y1Key {
  NSNumber* x1, *y1;
  if (!x1key || !y1Key) {
    FOReport(@"A key was not specified.");
    return CGPointUndefined;
  }

  x1 = [self numberForKey:x1key];
  y1 = [self numberForKey:y1Key];
  if (!x1 || !y1) return CGPointUndefined;

  return (CGPoint){[x1 floatValue], [y1 floatValue]};
}

- (CGRect)toVec4UsingX1:(id)x1key y1:(id)y1Key x2:(id)x2Key andY2:(id)y2Key {
  NSNumber* x1, *y1, *x2, *y2;
  if (!x1key || !y1Key) return CGRectUndefined;

  x1 = [self numberForKey:x1key];
  y1 = [self numberForKey:y1Key];
  x2 = [self numberForKey:x2Key];
  y2 = [self numberForKey:y2Key];
  if (!x1 || !y1 || !y2 || !x2) return CGRectUndefined;

  return (CGRect){(CGPoint){[x1 floatValue], [y1 floatValue]},
                  (CGSize){[x2 floatValue], [y2 floatValue]}};
}

#pragma mark Utilities

- (void)enumerateKeysUsingBlock:(void (^)(id key, BOOL* stop))block {
  BOOL* stop = FALSE;
  if (!block) return;

  for (NSString* key in self.allKeys) {
    block(key, stop);
    if (stop) return;
  }
}

- (NSDictionary*)overriddenByDictionary:(NSDictionary*)overridingDictionary {
  NSMutableDictionary* opDict;
  NSParameterAssert(overridingDictionary &&
                    [overridingDictionary isKindOfClass:[NSDictionary class]]);
  if (!overridingDictionary ||
      ![overridingDictionary isKindOfClass:[NSDictionary class]])
    return [[NSDictionary alloc] initWithDictionary:self];

  opDict = [[NSMutableDictionary alloc] initWithDictionary:self];

  [overridingDictionary
      enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL* stop) {
        [opDict setObject:obj forKey:key];
      }];

  return [[NSDictionary alloc] initWithDictionary:opDict];
}

- (NSDictionary*)overriddenByDictionaryRecursively:
        (NSDictionary*)overridingDictionary {
  NSMutableDictionary* opDict;
  __block id currentItem;
  NSParameterAssert(overridingDictionary &&
                    [overridingDictionary isKindOfClass:[NSDictionary class]]);
  if (!overridingDictionary ||
      ![overridingDictionary isKindOfClass:[NSDictionary class]])
    return [[NSDictionary alloc] initWithDictionary:self];

  opDict = [[NSMutableDictionary alloc] initWithDictionary:self];

  [overridingDictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj,
                                                            BOOL* stop) {
    currentItem = [opDict objectForKey:key];

    if ([currentItem isKindOfClass:[NSDictionary class]] &&
        [obj isKindOfClass:[NSDictionary class]])
      obj = [(NSDictionary*)currentItem overriddenByDictionaryRecursively:obj];

    if ([currentItem isKindOfClass:[NSArray class]] &&
        [obj isKindOfClass:[NSArray class]])
      obj = [(NSArray*)currentItem overwriteRecursivelyWithArray:obj];

    [opDict setObject:obj forKey:key];
  }];

  return [[NSDictionary alloc] initWithDictionary:opDict];
}

#pragma mark Input Sanitization

+ (NSString*)sanitizeKey:(NSString*)key {
  NSParameterAssert(key && [key isKindOfClass:[NSString class]]);
  if (!key || ![key isKindOfClass:[NSString class]]) return NULL;
  return [key
      replaceMatches:
          [@"[^a-zA-Z0-9\\@\\$\\&\\?\\[\\]\\~\\(\\)\\*\\+\\&/_]+" toExpresion]
          withString:@"-"];
}

#pragma mark Conversion

- (NSString*)toJSON {
  return [[NSJSONSerialization dataWithJSONObject:self
                                          options:NSJSONWritingPrettyPrinted
                                            error:NULL] toString];
}

@end

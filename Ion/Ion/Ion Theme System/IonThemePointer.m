//
//  IonThemePointer.m
//  Ion
//
//  Created by Andrew Hurst on 7/18/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonThemePointer.h"

#import "IonKeyValuePair.h"
#import "IonKVPAccessBasedGenerationMap.h"
#import "IonAttrubutesStanderdResolution.h"


/** Keys for pointer
 */
static NSString* sPointerTypeKey = @"type";
static NSString* sPointerNameKey = @"name";

static NSString* sPointerTargetTypeColor = @"color";
static NSString* sPointerTargetTypeGradient = @"gradient";
static NSString* sPointerTargetTypeImage = @"image";
static NSString* sPointerTargetTypeKVP = @"kvp";
static NSString* sPointerTargetTypeStyle = @"style";


@interface IonThemePointer ()

/**
 * This is the attrbutes object we will resolve with.
 */
@property (strong, nonatomic) IonKVPAccessBasedGenerationMap* attributes;

/**
 * This is the target name we will resolve with.
 */
@property (strong, nonatomic) NSString* targetName;

/**
 * This is the target type we will resolve with.
 */
@property (strong, nonatomic) NSString* targetType;

@end

@implementation IonThemePointer

/**
 * This resolves pointers into objects
 * @param {NSDictionary*} representation of a valid pointer.
 * @param {IonThemeAttributes*} the attrubute we should resolve with.
 * @returns {IonKeyValuePair} the resulting object, or NULL if invalid.
 */
+ (IonKeyValuePair*) resolvePointer:(NSDictionary*) pointer withAttributes:(IonKVPAccessBasedGenerationMap*) attributes {
    IonThemePointer* pointerObject;
    if ( !pointer || !attributes )
        return NULL;
    
    pointerObject = [[IonThemePointer alloc] initWithMap: pointer andAttrubutes: attributes];
    
    return [pointerObject resolve];
}



/**
 * This creates a theme pointer which can be resolved latter.
 * @param {NSDictionary*} the map to configure our self with.
 * @param {IonThemeAttributes*} the attrbutes object to reslove with.
 * @returns {instancetype}
 */
- (instancetype) initWithMap:(NSDictionary*) map andAttrubutes:(IonKVPAccessBasedGenerationMap*) attributes {
    self = [super init];
    if ( self && attributes && map ) {
        _attributes = attributes;
        [self setTargetWithMap: map];
    }
    return self;
}

/**
 * This will set our target with the inputed map.
 * @param {NSDictionary*} the map to configure our self with.
 * @returns {void}
 */
- (void) setTargetWithMap:(NSDictionary*) map {
    NSString *targetType, *targetName;
    if ( !map )
        return;
    
    // Get Keys
    targetType = [map objectForKey:sPointerTypeKey];
    targetName = [map objectForKey:sPointerNameKey];
    
    // Is Valid?
    if ( !targetType || !targetName )
        return;
    if ( ![targetType isKindOfClass:[NSString class]] || ![targetName isKindOfClass:[NSString class]] )
        return;
    
    // Set Keys
    _targetName = targetName;
    _targetType = targetType;
}

/**
 * This will resolve the pointer into a KVP
 * @return {IonKeyValuePair}
 */
- (IonKeyValuePair*) resolve {
    id result;
    if ( !_targetName || !_targetType )
        return NULL;
    
    // Resolve Color
    if ( [_targetType isEqualToString: sPointerTargetTypeColor] )
        result = [_attributes resolveColorAttrubute: _targetName];
    
    // Resolve Gradient
    else if ( [_targetType isEqualToString: sPointerTargetTypeGradient] ) {
        result = [_attributes resolveGradientAttribute: _targetName];
    }
    
    // Resolve  Image
    else if ( [_targetType isEqualToString: sPointerTargetTypeImage] )
        result = [_attributes resolveImageAttribute: _targetName];
    
    // Resolve KVP
    else if ( [_targetType isEqualToString: sPointerTargetTypeKVP] )
        result = [_attributes resolveKVPAttribute: _targetName];
    
    // Resolve Style
    else if ( [_targetType isEqualToString: sPointerTargetTypeStyle] )
        result = [_attributes resolveStyleAttribute: _targetName];
    
    return result;

}

@end

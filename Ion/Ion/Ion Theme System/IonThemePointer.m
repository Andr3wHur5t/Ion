//
//  IonThemePointer.m
//  Ion
//
//  Created by Andrew Hurst on 7/18/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonThemePointer.h"
#import "IonThemeAttributes.h"


/** Keys for pointer
 */
static NSString* sPointerTypeKey = @"type";
static NSString* sPointerNameKey = @"name";

static NSString* sPointerTargetTypeColor = @"color";
static NSString* sPointerTargetTypeGradient = @"gradient";
static NSString* sPointerTargetTypeImage = @"image";
static NSString* sPointerTargetTypeKVP = @"kvp";
static NSString* sPointerTargetTypeStyle = @"style";

@implementation IonThemePointer

/**
 * This resolves pointers into objects
 * @param {NSDictionary*} representation of a valid pointer.
 * @param {IonThemeAttributes*} the attrubute we should resolve with.
 * @returns {id} the resulting object, or NULL if invalid.
 */
+ (id) resolvePointer:(NSDictionary*) pointer withAttributes:(IonThemeAttributes*) attributes {
    NSString *targetType, *targetName;
    id result;
    if ( !pointer || !attributes )
        return NULL;
    
    // Get Keys
    targetType = [pointer objectForKey:sPointerTypeKey];
    targetName = [pointer objectForKey:sPointerNameKey];
    
    // Is Valid?
    if ( !targetType || !targetName )
        return  NULL;
    if ( ![targetType isKindOfClass:[NSString class]] || ![targetName isKindOfClass:[NSString class]] )
        return  NULL;
    
    // Resolve Color
    if ( [targetType isEqualToString: sPointerTargetTypeColor] )
        result = [attributes resolveColorAttrubute: targetName];
    
    // Resolve Gradient
    else if ( [targetType isEqualToString: sPointerTargetTypeGradient] )
        result = [attributes resolveGradientAttribute: targetName];
    
    // Resolve  Image
    else if ( [targetType isEqualToString: sPointerTargetTypeImage] )
        result = [attributes resolveImageAttribute: targetName];
    
    // Resolve KVP
    else if ( [targetType isEqualToString: sPointerTargetTypeKVP] )
        result = [attributes resolveKVPAttribute: targetName];
    
    // Resolve Style
    else if ( [targetType isEqualToString: sPointerTargetTypeStyle] )
        result = [attributes resolveStyleAttribute: targetName];
    
    return result;
}

@end

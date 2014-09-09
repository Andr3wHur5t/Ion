//
//  IonAttrubutesStanderdResolution.m
//  Ion
//
//  Created by Andrew Hurst on 7/19/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonAttrubutesStanderdResolution.h"

#import "IonKeyValuePair.h"
#import "IonKVP+IonTheme.h"

#import <IonData/UIColor+IonColor.h>
#import <IonData/IonGradientConfiguration.h>
#import <IonData/IonImageRef.h>
#import "IonStyle.h"

#import <objc/runtime.h>


extern void ThemeLog ( NSString* message ) {
    NSLog(@"Theme System: %@", message);
}

static char* sParentMap = "IonParentMap";

// Limit our search depth incase of evil recusion loops!
static const unsigned int sMaxColorResolveDepth = 2500;
unsigned int currentColorResolveDepth = 0;

@implementation IonKVPAccessBasedGenerationMap (StanderdResolution)

#pragma mark parent Map

/**
 * This is the setter for the parentMap
 * @returns {void}
 */
- (void) setParentMap:(IonKVPAccessBasedGenerationMap *)parentMap {
    objc_setAssociatedObject(self, sParentMap, parentMap,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    // Note Need to re-compile the style here
}

/**
 * This is the getter for the parentMap
 * @returns {IonKVPAccessBasedGenerationMap*}
 */
- (IonKVPAccessBasedGenerationMap *)parentMap {
    return objc_getAssociatedObject(self, sParentMap);
}


#pragma mark Resolution


/**
 * Resolves a color with the inputed key;
 * @param {NSString} the key to search for.
 * @return {UIColor} representation of the input, or NULL if invalid.
 */
- (UIColor*) resolveColorAttribute:(NSString*) value {
    UIColor* result;
    if ( !value || ![value isKindOfClass: [NSString class]] ) {
        ThemeLog(@"Incorect input type for color.");
        return NULL;
    }
    if ( value.length == 0 ) {
        ThemeLog(@"Input too small for color.");
        return NULL;
    }
    ++currentColorResolveDepth;
    
    
    // Check if the string is a hex
    if ( [UIColor stingIsValidHex:value] ) {
        // We found it!
        result = [UIColor colorFromHexString: value];
        
        --currentColorResolveDepth;
        return result;
    } else {
        if ( false ) // do we contain illegal char?
            return NULL;
        
        // Attempt to continue resolution
        if ( currentColorResolveDepth <= sMaxColorResolveDepth ) {
            // Go farther down the rabbit hole!
            result = [self colorFromMapWithKey: value];
        }
        --currentColorResolveDepth;
        if ( !result )
            ThemeLog([NSString stringWithFormat: @"Unable to find color with key \"%@\"", value]);
        return result;
    }
}

/**
 * This resolves a gradient key into a gradientConfiguration
 * @param {NSString*} the key for us to look for.
 * @returns {IonGradientConfiguration*} representation of the input, or NULL if invalid.
 */
- (IonGradientConfiguration*) resolveGradientAttribute:(NSString*) value {
    id result;
    if ( !value || ![value isKindOfClass: [NSString class]] ) {
        ThemeLog(@"Invalid target for gradient.");
        return NULL;
    }
    if ( value.length == 0 ) {
        ThemeLog(@"Target input too small for graient to process.");
        return NULL;
    }
    
    result = [self resolveAttributeInRootWithGroup: sGradientsGroupKey value: value andGenerationBlock: ^id(IonKVPAccessBasedGenerationMap *context, IonKeyValuePair *data) {
        return [data toGradientConfiguration];
    }];
    
    if ( ![result isKindOfClass:[IonGradientConfiguration class]] ) {
        ThemeLog( [NSString stringWithFormat: @"Unable to process gradient with name %@ to correct type.", value] );
        return NULL;
    }
    
    return result;
}

/**
 * Gets the Root Style.
 * @returns {IonStyle*}
 */
- (IonStyle*) rootStyle {
    IonStyle* result;
    __weak typeof( self ) weakSelf = self;
    result = [self objectForKey: sStylesGroupKey usingGenerationBlock: ^id( id data ) {
        IonKeyValuePair* kvp = data;
        kvp.attributes = [weakSelf rootMap];
        IonStyle* style = [kvp toStyle];
        return style;
    }];
    
    if ( ![result isKindOfClass:[IonStyle class]] )
        return NULL;
    return result;
}


/**
 * This will resolve the map for the specified key.
 * @returns {IonKVPAccessBasedGenerationMap*} representation of the map, or NULL if invalid.
 */
- (IonKVPAccessBasedGenerationMap*) resolveMapAttribute:(NSString*) key {
    id result;
    if ( !key || ![key isKindOfClass: [NSString class]] )
        return NULL;
    if ( key.length == 0 )
        return NULL;
    
    __weak typeof(self) weakSelf = self;
    result = [self objectForKey: key usingGenerationBlock:^id(id data) {
        IonKVPAccessBasedGenerationMap* map = [((IonKeyValuePair*)data) toKVPAccessBasedGenerationMap];
        map.parentMap = weakSelf;
        
        return map;
    }];
    
    if ( ![result isKindOfClass:[IonKVPAccessBasedGenerationMap class]] )
        return NULL;
    
    return result;
}



#pragma mark Color Getter

/**
 * This will get the color from the color map.
 * @param {NSString*} color key to look for.
 * @returns {UIColor*} representation of the input, or NULL if invalid.
 */
- (UIColor*) colorFromMapWithKey:(NSString*) colorKey {
    id result;
    if ( !colorKey )
        return NULL;
    
    // Get / Generate the color
    __weak typeof(self) weakSelf = self;
    result = [[self resolveMapAttribute: sColorsGroupKey] objectForKey: colorKey
                                   usingGenerationBlock:^id(id data) {
                                       UIColor* color;
                                       ((IonKeyValuePair*)data).attributes = weakSelf;
                                       color = [(IonKeyValuePair*)data toColor];
                                       if ( !color )
                                           ThemeLog(@"Unable to retrive color from KVP.");
                                       return color;
                                   }];
    
    // continue resolution if we need to.
    if ( [result isKindOfClass:[NSString class]] )
        result = [self resolveColorAttribute: result];

    // Check Output
    if ( ![result isKindOfClass:[UIColor class]] )
        return NULL;
    
    return result;
}

#pragma mark Utilities

/**
 * This will find the root map of the current map.
 * @returns {IonKVPAccessBasedGenerationMap*} the root map
 */
- (IonKVPAccessBasedGenerationMap*) rootMap {
    IonKVPAccessBasedGenerationMap* root = self;
    
    while ( root.parentMap )
        root = root.parentMap;
    
    return root;
}


/**
 * This will resolve an attribute in the root map with a group key, a value key, and a optional generation block.
 * @param {NSString*} the group key to look for.
 * @param {NSString*} the value key to look for.
 * @praam {IonGenerationBlock} the optional generation block to use.
 * @returns {id} the resulting object, or NULL if invalid
 */
- (id) resolveAttributeInRootWithGroup:(NSString*) groupKey
                                 value:(NSString*) valueKey
                    andGenerationBlock:(IonAttributeGenerationBlock) generationBlock {
    IonKVPAccessBasedGenerationMap* group;
    if ( !groupKey  )
        return NULL;
    
    // Get the group
    group = [self resolveMapAttribute: groupKey];
    if ( !group )
        return NULL;
    
    return [self resolveAttributeInContext: [group rootMap]
                                 withGroup: group
                                     value: valueKey
                        andGenerationBlock: generationBlock];
}

/**
 * This will resolve an attribute in the root map with a group key, a value key, and a optional generation block.
 * @param {IonKVPAccessBasedGenerationMap*} the context to provide the generation block.
 * @param {IonKVPAccessBasedGenerationMap*} the group key to look in.
 * @param {NSString*} the value key to look for.
 * @praam {IonGenerationBlock} the optional generation block to use.
 * @returns {id} the resulting object, or NULL if invalid
 */
- (id) resolveAttributeInContext:(IonKVPAccessBasedGenerationMap*) context
                       withGroup:(IonKVPAccessBasedGenerationMap*) group
                           value:(NSString*) valueKey
              andGenerationBlock:(IonAttributeGenerationBlock) generationBlock {
    if ( !valueKey || !group || !context || !group )
        return NULL;
    
    // Get the object
    return [group objectForKey: valueKey usingGenerationBlock:^id(id data) {
        IonKeyValuePair* kvp = data;
        id result;
        
        kvp.attributes = context;
        result = kvp;
        
        // Generate the data
        if ( generationBlock )
            result = generationBlock( context, kvp );
        
        return result;
    }];
}



@end

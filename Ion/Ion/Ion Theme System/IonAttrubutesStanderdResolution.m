//
//  IonAttrubutesStanderdResolution.m
//  Ion
//
//  Created by Andrew Hurst on 7/19/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonAttrubutesStanderdResolution.h"

#import "IonKeyValuePair.h"
#import "UIColor+IonColor.h"
#import "IonStyle.h"
#import "IonGradientConfiguration.h"
#import "IonImageRef.h"
#import <objc/runtime.h>

static char* sParrentMap = "IonParrentMap";

@implementation IonKVPAccessBasedGenerationMap (StanderdResolution)

#pragma mark parrent Map

/**
 * This is the setter for the parrentMap
 * @returns {void}
 */
- (void) setParrentMap:(IonKVPAccessBasedGenerationMap *)parrentMap {
    objc_setAssociatedObject(self, sParrentMap, parrentMap,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    // Note Need to re-compile the style here
}

/**
 * This is the getter for the parrentMap
 * @returns {IonKVPAccessBasedGenerationMap*}
 */
- (IonKVPAccessBasedGenerationMap *)parrentMap {
    return objc_getAssociatedObject(self, sParrentMap);
}


#pragma mark Resolution


/**
 * This will resolve a color with the inputed key;
 * @param {NSString} the key to search for.
 * @return {UIColor} representation of the input, or NULL if invalid.
 */
- (UIColor*) resolveColorAttrubute:(NSString*) value {
    id result = [UIColor resolveWithValue: value andAttrubutes: self];
    
    if ( ![result isKindOfClass:[UIColor class]] )
        return NULL;
    
    return result;
}

/**
 * This resolves a gradient key into a gradientConfiguration
 * @param {NSString*} the key for us to look for.
 * @returns {IonGradientConfiguration*} representation of the input, or NULL if invalid.
 */
- (IonGradientConfiguration*) resolveGradientAttribute:(NSString*) value {
    id result = [self resolveAttributeInRootWithGroup: sGradientsGroupKey value: value andGenerationBlock: ^id(IonKVPAccessBasedGenerationMap *context, IonKeyValuePair *data) {
        return [data toGradientConfiguration];
    }];
    
    if ( ![result isKindOfClass:[IonGradientConfiguration class]] )
        return NULL;
    
    return result;
}

/**
 * This resolves a style key into a IonStyle object.
 * @param {NSString*} the key for us to look for.
 * @returns {IonStyle*} representation of the input, or NULL if invalid.
 */
- (IonStyle*) resolveStyleAttribute:(NSString*) value {
    id result = [self resolveAttributeInRootWithGroup: sStylesGroupKey value:value andGenerationBlock: ^id(IonKVPAccessBasedGenerationMap *context, IonKeyValuePair *data) {
        id style = [data toStyle];
        return style;
    }];
    
    if ( ![result isKindOfClass:[IonStyle class]] )
        return NULL;
    
    return result;
}

/**
 * This resolves a Image key into a UIImage object.
 * @param {NSString*} the key for us to look for.
 * @returns {UIImage*} representation of the input, or NULL if invalid.
 */
- (IonImageRef*) resolveImageAttribute:(NSString*) value {
    id result = [self resolveAttributeInRootWithGroup: sImagesGroupKey value:value andGenerationBlock:^id(IonKVPAccessBasedGenerationMap *context, IonKeyValuePair *data) {
        return [data toImageRef];
    }];
    
    if ( ![result isKindOfClass:[IonImageRef class]] )
        return NULL;
    
    return result;
}

/**
 * This resolves a KVP key into a KVP object.
 * @param {NSString*} the key for us to look for.
 * @returns {UIImage*} representation of the input, or NULL if invalid.
 */
- (IonKeyValuePair*) resolveKVPAttribute:(NSString*) value {
    id result = [self resolveAttributeInRootWithGroup: sKVPGroupKey value: value andGenerationBlock:NULL];
    
    if ( ![result isKindOfClass:[IonKeyValuePair class]] )
        return NULL;
    
    return result;
}

/**
 * This will resolve the map for the specified key.
 * @returns {IonKVPAccessBasedGenerationMap*} representation of the map, or NULL if invalid.
 */
- (IonKVPAccessBasedGenerationMap*) resolveMapAttribute:(NSString*) key {
    __weak typeof(self) weakSelf = self;
    id result = [self objectForKey: key usingGenerationBlock:^id(id data) {
        IonKVPAccessBasedGenerationMap* map = [((IonKeyValuePair*)data) toKVPAccessBasedGenerationMap];
        map.parrentMap = weakSelf;
        
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
                                       ((IonKeyValuePair*)data).attributes = weakSelf;
                                       return [(IonKeyValuePair*)data toColor];
                                   }];
    
    // continue resolution if we need to.
    if ( [result isKindOfClass:[NSString class]] )
        result = [self resolveColorAttrubute: result];

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
    
    while ( root.parrentMap )
        root = root.parrentMap;
    
    return root;
}


/**
 * This will resolve an attribute in the root map with a group key, a value key, and a optionial generation block.
 * @param {NSString*} the group key to look for.
 * @param {NSString*} the value key to look for.
 * @praam {IonGenerationBlock} the optionial generation block to use.
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
 * This will resolve an attribute in the root map with a group key, a value key, and a optionial generation block.
 * @param {IonKVPAccessBasedGenerationMap*} the context to provide the generation block.
 * @param {IonKVPAccessBasedGenerationMap*} the group key to look in.
 * @param {NSString*} the value key to look for.
 * @praam {IonGenerationBlock} the optionial generation block to use.
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

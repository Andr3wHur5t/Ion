//
//  NSDictionary+IonTypeExtension.m
//  Ion
//
//  Created by Andrew Hurst on 7/22/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "NSDictionary+IonTypeExtension.h"
#import "IonKeyValuePair.h"


@implementation NSDictionary (IonTypeExtension)

/**
 * Returns the specified keys' value as a UIColor.
 * @param {id} the key of the value.
 * @param {IonTheme*} the theme to get color refrences from.
 * @returns {UIColor*} the resulting color, or NULL if Invalid.
 */
- (UIColor*) colorForKey:(id) key usingTheme:(IonTheme*) theme {
    IonKeyValuePair* kvp;
    if ( !key || !theme )
        return NULL;
    
    kvp = [[IonKeyValuePair alloc] init];
    kvp.value = [self objectForKey: key];
    kvp.attributes = theme;
    if ( !kvp  )
        return NULL;
    
    return [kvp toColor];
}

/**
 * Gets the CGPoint Equivlent of the value.
 * @param {id} the key to get the value from.
 * @returns {CGPoint} a valid CGPoint, or a CGPointUndefined.
 */
- (CGPoint) pointForKey:(id) key {
    IonKeyValuePair* kvp;
    if ( !key )
        return CGPointUndefined;
    
    kvp = [[IonKeyValuePair alloc] init];
    kvp.value = [self objectForKey: key];
    
    return  [kvp toPoint];
}

/**
 * Gets the CGSize Equivlent of the value.
 * @param {id} the key to get the value from.
 * @returns {CGPoint} a valid CGSize, or a CGPointUndefined.
 */
- (CGSize) sizeForKey:(id) key {
    IonKeyValuePair* kvp;
    if ( !key )
        return CGSizeUndefined;
    
    kvp = [[IonKeyValuePair alloc] init];
    kvp.value = [self objectForKey: key];
    
    return  [kvp toSize];
}

/**
 * Gets the CGRect Equivlent of the value.
 * @param {id} the key to get the value from.
 * @returns {CGPoint} a valid CGSize, or a CGPointUndefined.
 */
- (CGRect) rectForKey:(id) key {
    IonKeyValuePair* kvp;
    if ( !key )
        return CGRectUndefined;
    
    kvp = [[IonKeyValuePair alloc] init];
    kvp.value = [self objectForKey: key];
    
    return  [kvp toRect];
}

@end

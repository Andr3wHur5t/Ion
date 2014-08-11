//
//  ImageManifest.m
//  Ion
//
//  Created by Andrew Hurst on 8/8/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "ImageManifest.h"
#import "NSDictionary+IonTypeExtension.h"

static NSString* sIonImageManifestItem_FileName = @"fileName";
static NSString* sIonImageManifestItem_InfoObject = @"info";

@implementation NSDictionary (ImageManifest)
#pragma mark Item Management

/**
 * gets an item for the specified key.
 * @param {NSString*} the key of the item to get.
 * @returns {NSDictionary*} the item
 */
- (NSDictionary*) itemForKey:(NSString*) key {
    return [self dictionaryForKey: key];
}

#pragma mark Path

/**
 * Gets the file name for the specified key.
 * @param {NSString*} the key of the item you want the path of.
 * @returns {NSString*} the path.
 */
- (NSString*) fileNameForKey:(NSString*) key {
    NSDictionary* item;
    
    item = [self itemForKey: key];
    if ( !item )
        return NULL;
    
    return [item stringForKey: sIonImageManifestItem_FileName];
}

#pragma mark Info
/**
 * Gets the info object for the specified key.
 * @param {NSString*} the key of the item you want the path of.
 * @returns {NSString*} the path.
 */
- (NSDictionary*) infoForKey:(NSString*) key {
    NSDictionary* item;
    
    item = [self itemForKey: key];
    if ( !item )
        return NULL;
    
    return [item dictionaryForKey: sIonImageManifestItem_InfoObject];
}

@end

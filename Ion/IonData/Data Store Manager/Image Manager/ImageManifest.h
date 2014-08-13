//
//  ImageManifest.h
//  Ion
//
//  Created by Andrew Hurst on 8/8/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString* sIonImageManifestItem_FileName = @"fileName";
static NSString* sIonImageManifestItem_InfoObject = @"info";

@interface NSDictionary (ImageManifest)
#pragma mark Item Management

/**
 * gets an item for the specified key.
 * @param {NSString*} the key of the item to get.
 * @returns {NSDictionary*} the item
 */
- (NSDictionary*) itemForKey:(NSString*) key;

#pragma mark Path

/**
 * Gets the file name for the specified key.
 * @param {NSString*} the key of the item you want the path of.
 * @returns {NSString*} the path.
 */
- (NSString*) fileNameForKey:(NSString*) key;


#pragma mark Info
/**
 * Gets the info object for the specified key.
 * @param {NSString*} the key of the item you want the path of.
 * @returns {NSString*} the path.
 */
- (NSDictionary*) infoForKey:(NSString*) key;

@end

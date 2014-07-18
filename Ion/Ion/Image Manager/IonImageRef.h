//
//  IonImageRef.h
//  Ion
//
//  Created by Andrew Hurst on 7/18/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IonImage.h"

@class IonThemeAttributes;
@interface IonImageRef : NSObject

/** This is the name of the image we want to get.
 */
@property (strong, nonatomic) NSString* fileName;

/**
 * This is where we hold the parent attributes refrence.
 */
@property (strong, nonatomic) IonThemeAttributes* attributes;

/**
 * This will resolve a Image object using a map and an Attrbute Set.
 * @param {NSString*} the value to process
 * @param {IonThemeAttributes*} the theme attrubute set to do our searches on if needed.
 * @returns {IonImageRef*} representation, or NULL of invalid
 */
+ (IonImageRef*) resolveWithValue:(NSString*) value andAttrubutes:(IonThemeAttributes*) attributes;

@end

//
//  IonThemePointer.h
//  Ion
//
//  Created by Andrew Hurst on 7/18/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IonThemeAttributes;

@interface IonThemePointer : NSObject

/**
 * This resolves pointers into objects
 * @param {NSDictionary*} representation of a valid pointer.
 * @param {IonThemeAttributes*} the attrubute we should resolve with.
 * @returns {id} the resulting object, or NULL if invalid.
 */
+ (id) resolvePointer:(NSDictionary*) pointer withAttributes:(IonThemeAttributes*) attributes;

@end

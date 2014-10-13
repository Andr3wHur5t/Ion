//
//  IonKVP+IonTheme.h
//  Ion
//
//  Created by Andrew Hurst on 7/23/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IonData/IonData.h>

@interface IonKeyValuePair (IonTheme)
/**
 * This gets the UIColor form of our value.
 * @returns {UIColor*} representation, or NULL if incorect type.
 */
- (UIColor*) toColor;

/**
 * This gets the IonStyle form of our value.
 * @returns {IonStyle*} representation, or NULL if incorect type.
 */
- (IonStyle*) toStyle;

/**
 * This gets the IonThemePointer form of our value.
 * @returns {IonThemePointer*} representation, or NULL if incorect type.
 */
- (IonThemePointer*) toThemePointer;

/**
 * This gets the IonThemePointer form of our value.
 * @returns {IonThemePointer*} representation, or NULL if incorect type.
 */
- (IonThemePointer*) toThemePointerWithAttrbutes:(IonKVPAccessBasedGenerationMap*) attributes;



@end

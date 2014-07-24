//
//  NSDictionary+IonThemeResolution.h
//  Ion
//
//  Created by Andrew Hurst on 7/23/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IonTheme.h"

@interface NSDictionary (IonThemeResolution)

/**
 * This returns the specified value as a UIColor after resolving it.
 * @param {id} the key of the value.
 * @param {IonTheme*} the theme to get color refrences from.
 * @returns {UIColor*} the resulting color, or NULL if Invalid.
 */
- (UIColor*) colorForKey:(id) key usingTheme:(IonTheme*) theme;

@end

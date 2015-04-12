//
//  SPAppTheme.h
//  Sandbox
//
//  Created by Andrew Hurst on 10/19/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPAppTheme : NSObject

/**
 * Our applications composite theme.
 */
+ (NSDictionary *)theme;

/**
 * Our applications color swatch.
 */
+ (NSDictionary *)colors;

/**
 * Our applications styles.
 */
+ (NSDictionary *)styles;

@end

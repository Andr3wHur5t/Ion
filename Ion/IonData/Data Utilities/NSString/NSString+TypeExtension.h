//
//  NSString+TypeExtension.h
//  Ion
//
//  Created by Andrew Hurst on 8/20/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>

// Conversion keys
static NSString* sIonTextAlignment_Centered = @"CENTER";
static NSString* sIonTextAlignment_Right = @"RIGHT";
static NSString* sIonTextAlignment_Left = @"LEFT";
static NSString* sIonTextAlignment_Justified = @"JUSTIFIED";
static NSString* sIonTextAlignment_Natural = @"NATURAL";

@interface NSString (TypeExtension)


#pragma mark UI Conversions

/**
 * Converts a string to text alignment.
 * @returns {NSTextAlignment}
 */
- (NSTextAlignment) toTextAlignment;

@end

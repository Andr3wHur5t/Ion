//
//  NSString+TypeExtension.m
//  Ion
//
//  Created by Andrew Hurst on 8/20/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "NSString+TypeExtension.h"

@implementation NSString (TypeExtension)


#pragma mark UI Conversions

/**
 * Converts a string to text alignment.
 * @returns {NSTextAlignment}
 */
- (NSTextAlignment) toTextAlignment {
    NSString* uppercase = self.uppercaseString;
    
    // NOTE: Constants manualy uppercased
    if ( [uppercase isEqualToString: sIonTextAlignment_Centered] )
        return NSTextAlignmentCenter;
    else if ( [uppercase isEqualToString: sIonTextAlignment_Right] )
        return NSTextAlignmentRight;
    else if ( [uppercase isEqualToString: sIonTextAlignment_Left] )
        return NSTextAlignmentLeft;
    else if ( [uppercase isEqualToString: sIonTextAlignment_Justified] )
        return NSTextAlignmentJustified;
    else
        return NSTextAlignmentNatural;
}



@end

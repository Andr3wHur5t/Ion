//
//  UIColor+FOColor.m
//  FOUtilities
//
//  Created by Andrew Hurst on 10/9/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "UIColor+FOColor.h"
#import "NSString+FOTypeExtension.h"

@implementation UIColor (FOColor)
#pragma mark Conversion

- (NSString*) toHex {
    NSString* result = NULL;
    CGFloat red, green, blue, alpha;
    int r, g, b, a;
    
    if ( [self getRed:&red green:&green blue:&blue alpha:&alpha] ) {
        r = (int)(255.0 * red);
        g = (int)(255.0 * green);
        b = (int)(255.0 * blue);
        a = (int)(255.0 * alpha);
        
        result = [NSString stringWithFormat:@"#%02X%02X%02X%02X",r,g,b,a];
    }
    
    return result;
}

+ (UIColor*) colorFromHexString:(NSString*) hexString {
    CGFloat alpha, red, blue, green;
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#"
                                                                  withString: @""] uppercaseString];
    colorString = [colorString cleanedHex];
    switch ( [colorString length] ) {
        case 3: // #RGB
            red   = [colorString colorComponentAt: 0 length: 1];
            green = [colorString colorComponentAt: 1 length: 1];
            blue  = [colorString colorComponentAt: 2 length: 1];
            alpha = 1.0f;
            break;
        case 4: // #RGBA
            red =   [colorString colorComponentAt: 0 length: 1];
            green = [colorString colorComponentAt: 1 length: 1];
            blue =  [colorString colorComponentAt: 2 length: 1];
            alpha = [colorString colorComponentAt: 3 length: 1];
            break;
        case 6: // #RRGGBB
            red   = [colorString colorComponentAt: 0 length: 2];
            green = [colorString colorComponentAt: 2 length: 2];
            blue  = [colorString colorComponentAt: 4 length: 2];
            alpha = 1.0f;
            break;
        case 8: // #RRGGBBAA
            red =   [colorString colorComponentAt: 0 length: 2];
            green = [colorString colorComponentAt: 2 length: 2];
            blue =  [colorString colorComponentAt: 4 length: 2];
            alpha = [colorString colorComponentAt: 6 length: 2];
            break;
        default:
            NSLog( @"Invalid Hex \"%@\" incorrect char count.", hexString);
            return NULL;
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

@end



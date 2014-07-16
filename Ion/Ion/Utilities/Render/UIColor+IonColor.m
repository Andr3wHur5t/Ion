//
//  UIColor+IonColor.m
//  Ion
//
//  Created by Andrew Hurst on 7/14/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "UIColor+IonColor.h"

@implementation UIColor (IonColor)

/**
 * This converts a UIColor to a #RRGGBBAA hex string.
 * @returns {NSString*} the hex string representing the color object.
 */
- (NSString*) toHex {
    NSString* result = NULL;
    CGFloat red, green, blue, alpha;
    int r, g, b, a;
    
    if ( [self getRed:&red green:&green blue:&blue alpha:&alpha] ) {
        r = (int)(255.0 * red);
        g = (int)(255.0 * green);
        b = (int)(255.0 * blue);
        a = (int)(255.0 * alpha);
        
        result = [NSString stringWithFormat:@"#%02x%02x%02x%02x",r,g,b,a];
    }
    
    return result;
}

/**
 * This converts a NSString in Hex Format to a UIColor
 * Hex String to UIColor From Stack overflow: http://stackoverflow.com/a/7180905/3624745
 * @param {NSString*} the string to generate the color from.
 * @retuns {UIColor*} the generated color.
 */
+ (UIColor*) colorFromHexString:(NSString*) hexString {
    CGFloat alpha, red, blue, green;
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#"
                                                                  withString: @""] uppercaseString];
    
    switch ( [colorString length] ) {
        case 3: // #RGB
            red   = [self colorComponentFrom: colorString start: 0 length: 1];
            green = [self colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
            alpha = 1.0f;
            break;
        case 4: // #RGBA
            red =   [self colorComponentFrom: colorString start: 0 length: 1];
            green = [self colorComponentFrom: colorString start: 1 length: 1];
            blue =  [self colorComponentFrom: colorString start: 2 length: 1];
            alpha = [self colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            red   = [self colorComponentFrom: colorString start: 0 length: 2];
            green = [self colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self colorComponentFrom: colorString start: 4 length: 2];
            alpha = 1.0f;
            break;
        case 8: // #RRGGBBAA
            red =   [self colorComponentFrom: colorString start: 0 length: 2];
            green = [self colorComponentFrom: colorString start: 2 length: 2];
            blue =  [self colorComponentFrom: colorString start: 4 length: 2];
            alpha = [self colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            [NSException raise:@"Invalid color value" format: @"Color value %@ is invalid.  It should be a hex value of the form #RBG, #RGBA, #RRGGBB, or #RRGGBBAA", hexString];
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

/**
 * This converts a NSString at an inputted range in to an RGBA Element.
 * Hex String to UIColor From Stack overflow: http://stackoverflow.com/a/7180905/3624745
 * @param {NSInteger} the starting index
 * @param {NSInteger} the ammount of char to use to get the element
 * @retuns {CGFloat} the net color componet
 */
+ (CGFloat) colorComponentFrom:(NSString*) string start:(NSUInteger) start length:(NSUInteger) length {
    unsigned hexComponent;
    NSString *substring, *fullHex;
    
    substring = [string substringWithRange: NSMakeRange(start, length)];
    fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    
    return hexComponent / 255.0;
}
@end

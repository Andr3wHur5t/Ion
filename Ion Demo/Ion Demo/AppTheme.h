//
//  AppTheme.h
//  Ion Demo
//
//  Created by Andrew Hurst on 10/11/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppTheme : NSObject
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

@implementation AppTheme

+ (NSDictionary *)theme {
    return @{
             @"colors": [AppTheme colors],
             @"styles": [AppTheme styles]
             };
}

+ (NSDictionary *)colors {
    return @{
             @"BaseColor": @"SpottrNorm",
             @"DefaultBody": @"#000",
             
             @"PlaceHolderColor": @"Gray",
             @"SearchIconColor": @"GrayExtraDark",
             
             @"Clear": @"#0000",
             @"CleanWhite": @"#F5F5F5",
             
             @"SpottrNorm": @"#F2393B",
             @"SpottrDark": @"#210F27",
             @"GrayExtraDark": @"#929497",
             @"GrayDark": @"#818285",
             @"Gray": @"#BCBDBF",
             @"GrayLight": @"#939598",
             @"GrayExtraLight": @"#ECEDEE",
             @"WhiteClear": @"#F7F9F9",
             @"WhiteCream": @"#F5F5F6",
             
             @"GoodStateColor": @"#7AC581",
             @"WarningStateColor": @"#FDC482",
             @"BadStateColor": @"#F36C57",
             @"OkeyStateColor": @"#76BEE4",
             @"SpecialStateColor": @"#C37EB3",
             
             @"SystemTextColor": @"CleanWhite",
             @"SystemPrimaryTextColor": @"GrayDark",
             @"SyetemSecondaryTextColor": @"GrayLight",
             @"SyetemPlaceholderColor":@"Gray",
             @"SystemSeperatorColor": @"GrayExteaLight",
             @"SystemButtonNorm": @"CleanWhite",
             @"SystemButtonDown": @"GrayLight",
             @"SystemButtonSelected": @"GrayDark",
             @"SystemButtonDisabled": @"GrayDark",
             @"SystemLineNavTextColor": @"GrayExtraDark",
             @"SystemLineNavBackgroundColor": @"",
             
             @"TitleBarColor": @"BaseColor",
             @"TitleTextColor": @"CleanWhite",
             @"TitleButtonStateNorm": @"CleanWhite",
             @"TitleButtonStateDown": @"SystemButtonDown",
             @"TitleButtonStateSelected": @"SystemButtonSelected",
             @"TitleButtonStateDisabled": @"SystemButtonDisabled",
             
             @"SubBarColor" : @"#F2393B99"
             };
}

+ (NSDictionary *)styles {
    return @{
             @"background": @{ @"type": @"color", @"name": @"CleanWhite" },
             
             @"buttonStats": @{
                 @"norm": @"SystemButtonNorm",
                 @"down": @"SystemButtonDown",
                 @"selected": @"SystemButtonSelected",
                 @"disabled": @"SystemButtonDisabled"
             },
             
             @"textColor": @"SystemTextColor",
             @"font": @{ @"name": @"Helvetica Neue", @"size": @12 },
             @"textAlignment": @"left",
             @"animationDuration": @0.3,
             
             @"placeholderFont": @{ @"name": @"Helvetica Neue", @"size": @12 },
             @"placeholderColor": @"SyetemPlaceholderColor",
             
             @"cornerRadius": @0.0,
             @"styleMargin": @{ @"width": @18.0, @"height": @10.0},
             @"stylePadding": @{ @"width": @18.0, @"height": @5.0},
             
             @"button": @{
                 @"size": @{ @"width": @25, @"height": @25}
             },
             
             @"iconSize": @{ @"width": @20, @"height": @20},
             
             @"titleBar": @{
                 @"contentStatusBarOffset": @(-6.0),
                 @"contentHeight": @45.0,
             },
             
             @"keyboard": @{
                 @"keyboardType": @"default",
                 @"keyboardAppearence": @"dark",
                 @"returnKeyType": @"done",
                 
                 @"autoCapitalizationType": @"sentences",
                 @"autocorrectType": @"default",
                 @"spellCheck": @"default"
             },
             @"inputFilter": @{
                 @"filterExpression": @{ @"type": @"literal", @"content": @""},
                 @"minChars": @1,
                 @"maxChars": @128
             },
             
             @"children": @{
                 @"scrollView" : @{
                     @"KeyboardDismissMode": @"onDrag"
                 },
                 @"scrollRefreshBackground": @{
                     @"background": @{ @"type": @"color", @"name": @"GrayExtraLight" },
                     @"styleMargin": @{ @"height": @25.0},
                 },
                 @"cell": @{
                     @"background": @{ @"type": @"color", @"name": @"CleanWhite" },
                     @"stylePadding": @{ @"width": @0.0, @"height": @5.0},
                     @"styleMargin": @{ @"width": @18.0, @"height": @5.0},
                     @"children": @{
                         @"cls_exposeHint": @{
                             @"background": @{ @"type": @"color", @"name": @"Clear" },
                             @"cornerRadius": @2
                         },
                         @"cls_profileImage": @{
                             @"cornerRadius": @32.5,
                             @"background": @{ @"type": @"color", @"name": @"SpecialStateColor" },
                             @"styleMargin": @{ @"height": @20.0, @"width": @10.0},
                         },
                         @"cls_nameLabel": @{
                             @"textColor": @"SystemPrimaryTextColor",
                             @"font": @{ @"name": @"Helvetica Neue", @"size": @18 },
                         },
                     }
                 },
                 @"cls_seperator": @{
                     @"background": @{ @"type": @"color", @"name": @"GrayExtraLight" },
                 },
                 @"label": @{
                     @"background": @{ @"type": @"color", @"name": @"Clear" }
                 },
                 @"textField": @{
                     @"background": @{ @"type": @"color", @"name": @"CleanWhite" },
                     @"cornerRadius": @0,
                     
                     @"textColor": @"SystemPrimaryTextColor",
                     @"font": @{ @"name": @"Helvetica Neue", @"size": @16 },
                     @"placeholderFont": @{ @"name": @"Helvetica Neue", @"size": @16 },
                     @"placeholderColor": @"SyetemPlaceholderColor",
                 },
                 @"cls_peopleSearch": @{
                     @"background": @{ @"type": @"color", @"name": @"CleanWhite" },
                     @"cornerRadius": @15,
                     @"keyboard": @{
                         @"keyboardType": @"default",
                         @"returnKeyType": @"next",
                         @"autoCapitalizationType": @"words",
                     },
                     @"stylePadding": @{ @"width": @0.0, @"height": @5.0},
                     
                     @"children": @{
                         @"icon": @{
                             @"cornerRadius": @0.0,
                             @"background": @{ @"type": @"color", @"name": @"SystemPrimaryTextColor" },
                             @"iconImage": @"General_Search",
                             @"styleMargin": @{ @"width": @8.0}
                         }
                     }
                 },
                 @"titleBar": @{
                     @"background": @{ @"type": @"color", @"name": @"TitleBarColor" },
                     
                     @"font": @{ @"size": @18 },
                     @"textAlignment": @"center",
                     
                     @"buttonStats": @{
                         @"norm": @"TitleButtonStateNorm",
                         @"down": @"TitleButtonStateDown",
                         @"selected": @"TitleButtonStateSelected",
                         @"disabled": @"TitleButtonStateDisabled"
                     },
                     @"button": @{ @"size": @{ @"width": @30, @"height": @30} },
                     @"styleMargin": @{ @"width": @8.0}
                 },
                 @"sub-bar": @{
                     @"background": @{ @"type": @"color", @"name": @"SubBarColor" },
                     @"stylePadding": @{ @"width": @18.0, @"height": @7.0},
                 },
                 @"button": @{
                     @"background": @{ @"type": @"color", @"name": @"CleanWhite" }
                 },
                 @"body": @{
                     @"background": @{ @"type": @"color", @"name": @"CleanWhite" }
                 }
             }

             };
}

@end
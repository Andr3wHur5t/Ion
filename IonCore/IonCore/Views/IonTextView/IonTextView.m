//
//  IonTextView.m
//  IonCore
//
//  Created by Andrew Hurst on 10/27/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "IonTextView.h"
#import <IonCore/IonCore.h>

@implementation IonTextView

@synthesize textHeightConstrainedByWidth = _textHeightConstrainedByWidth;

#pragma mark Construction

- (instancetype)init {
    self = [super init];
    if ( self )
        [self construct];
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder: aDecoder];
    if ( self )
        [self construct];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if ( self )
        [self construct];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer {
    self = [super initWithFrame: frame textContainer: textContainer];
    if ( self )
        [self construct];
    return self;
}

- (void)construct {
    self.themeElement = @"textView";
}

#pragma mark Text Guides

- (void) setText:(NSString *)text {
    [super setText: text];
    
    if ( ![text isKindOfClass: [NSString class]] )
        return;
    
    // Height
    self.textHeightConstrainedByWidth.position = self.font.lineHeight * self.textContainer.size.height;
}

- (IonGuideLine *)textHeightConstrainedByWidth {
    if ( !_textHeightConstrainedByWidth )
        _textHeightConstrainedByWidth = [[IonGuideLine alloc] init];
    return _textHeightConstrainedByWidth;
}

#pragma mark Style Application

- (void)applyStyle:(IonStyle *)style {
    [super applyStyle: style];
    if ( ![style isKindOfClass:[IonStyle class]] )
        return;
    
    /** Text */
    // Text Color
    self.textColor = [style.configuration colorForKey: sIonThemeText_Color usingTheme: style.theme];
    
    // Font
    self.font = [style.configuration fontForKey: sIonThemeText_Font];
    
    // Alignment
    self.textAlignment = [style.configuration textAlignmentForKey: sIonThemeText_Alignment];
}

@end

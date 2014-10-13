//
//  IonTextBar.h
//  Ion
//
//  Created by Andrew Hurst on 9/12/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <IonCore/IonCore.h>

@interface IonTextBar : IonView
/**
 * The Icon to be presented within the bar.
 */
@property (strong, nonatomic, readonly) IonView *icon;

// Note these are simply proxies to the text field.
#pragma mark Placeholder
/**
 * The placeholder text.
 */
@property (weak, nonatomic, readwrite) NSString *placeholder;

/**
 * The placeholder text color.
 */
@property (weak, nonatomic, readwrite) UIColor *placeholderTextColor;

/**
 * The placeholder font.
 */
@property (weak, nonatomic, readwrite) UIFont *placeholderFont;

#pragma mark Valadation
/**
 * The input filter configuration.
 */
@property (weak, nonatomic, readwrite) IonInputFilter *inputFilter;

#pragma mark Events
/**
 * The target action set to call when the enter key is pressed.
 */
@property (weak, nonatomic, readwrite) id enterKeyTargetAction;

@end

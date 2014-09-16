//
//  IonTextForm.h
//  Ion
//
//  Created by Andrew Hurst on 9/8/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IonInputManager.h"

@class IonInputManager;
@class IonInputFilter;

/** Keys */
static NSString *sIonTextField_KeyboardKey =                    @"keyboard";
static NSString *sIonTextField_KeyboardTypeKey =                @"keyboardType";
static NSString *sIonTextField_KeyboardAppearanceKey =          @"keyboardAppearance";
static NSString *sIonTextField_SpellCheckTypeKey =              @"spellCheckType";
static NSString *sIonTextField_AutoCorrectionTypeKey =          @"autoCorrectionType";
static NSString *sIonTextField_AutoCapitalizationTypeKey =      @"autoCapitalizationType";
static NSString *sIonTextField_ReturnKeyTypeKey =               @"returnKeyType";
static NSString *sIonTextField_InputFilterKey =                 @"inputFilter";


static NSString *sIonTextField_ResignBehaviorKey =              @"ResignBehavior";
static NSString *sIonTextField_ResignBehavior_NoValidation =    @"canResignWithoutValidation";


/** Behavior Reason Keys */
static NSString *sIonTextFieldBehavior_Reason_ReturnHit = @"returnHit";
static NSString *sIonTextFieldBehavior_Reason_ExternalResign = @"externalResign";

@interface IonTextField : UITextField <IonInputManagerFilterSpec>
#pragma mark Placeholder
/**
 * The placeholder text color.
 */
@property (strong, nonatomic, readwrite) UIColor *placeholderTextColor;

/**
 * The placeholder font.
 */
@property (strong, nonatomic, readwrite) UIFont *placeholderFont;

#pragma mark Validation
/**
 * The input filter configuration.
 */
@property (strong, nonatomic, readwrite) IonInputFilter *inputFilter;

#pragma mark Events
/**
 * The target action set to call when the enter key is pressed.
 */
@property (strong, nonatomic, readwrite) id enterKeyTargetAction;

#pragma mark Actions
/**
 * The dictionary which holds all of our behavior reasons, and associated configurations.
 */
@property (strong, nonatomic, readwrite) NSDictionary* behaviorDictionary;
@end

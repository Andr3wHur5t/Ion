//
//  IonTextForm.h
//  Ion
//
//  Created by Andrew Hurst on 9/8/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FOUtilities/FOUtilities.h>
#import "IonInputManager.h"

@class IonInputManager;
@class IonInputFilter;

/** Keys */
static NSString *sIonTextField_KeyboardKey =                                    @"keyboard";
static NSString *sIonTextField_KeyboardTypeKey =                                @"keyboardType";
static NSString *sIonTextField_KeyboardAppearanceKey =                          @"keyboardAppearance";
static NSString *sIonTextField_SpellCheckTypeKey =                              @"spellCheckType";
static NSString *sIonTextField_AutoCorrectionTypeKey =                          @"autoCorrectionType";
static NSString *sIonTextField_AutoCapitalizationTypeKey =                      @"autoCapitalizationType";
static NSString *sIonTextField_ReturnKeyTypeKey =                               @"returnKeyType";
static NSString *sIonTextField_InputFilterKey =                                 @"inputFilter";


static NSString *sIonTextField_ResignBehaviorKey =                              @"ResignBehavior";
static NSString *sIonTextField_ResignBehavior_NoValidation =                    @"canResignWithoutValidation";
static NSString *sIonTextField_ResignBehavior_ValidationFailedAnimation =       @"validationFailedAnimation";


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

/**
 * States if the text view can resign externally.
 */
@property (assign, nonatomic, readwrite) BOOL canResignExternally;

#pragma mark Events

/**
 * Adds the inputed target action set with the return key.
 * @param target - the target to associate with the action.
 * @param acton - the action to invoke on the target when the return key is pressed.
 */
- (void) addTarget:(id)target action:(SEL)action;

/**
 * Removes the inputted target action set associated with the return key.
 * @param target - the associated target to remove.
 * @param action - the associated action to remove.
 */
- (void) removeTarget:(id)target action:(SEL)action;

/**
 * Removes all target action sets associated with the return key.
 */
- (void) removeAllTargetActions;

#pragma mark Actions
/**
 * The dictionary which holds all of our behavior reasons, and associated configurations.
 */
@property (strong, nonatomic, readwrite) NSDictionary* behaviorDictionary;

/**
 * Forcefully resigns first responder by ignoring all checks.
 * @return {BOOL} if the super will resign first responder.
 */
- (BOOL) forcivlyResignFirstResponder;

@end

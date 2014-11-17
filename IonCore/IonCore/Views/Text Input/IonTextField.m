//
//  IonTextForm.m
//  Ion
//
//  Created by Andrew Hurst on 9/8/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonTextField.h"
#import "IonInputFilter.h"
#import <IonData/IonData.h>

#import "UIView+IonTheme.h"
#import "IonStyle.h"
#import "NSDictionary+IonThemeResolution.h"
#import "UIView+IonAnimation.h"


@interface IonTextField () {
    CGFloat _iAlpha; // ivar to hold our user set alpha so we can animate alpha while preserving user set states.
    
    UITapGestureRecognizer *tap;
}

/**
 * The target action set to call when the enter key is pressed.
 */
@property (strong, nonatomic, readonly) FOTargetActionList *enterKeyTargetActionList;

@end

@implementation IonTextField

@synthesize inputFilter = _inputFilter;
@synthesize behaviorDictionary = _behaviorDictionary;
@synthesize enterKeyTargetActionList = _enterKeyTargetActionList;

#pragma mark Constructors

- (instancetype) init {
    self = [super init];
    if ( self )
        [self construct];
    return self;
}

- (instancetype) initWithFrame:(CGRect) frame {
    self = [super initWithFrame: frame];
    if ( self )
        [self construct];
    return self;
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder: aDecoder];
    if ( self )
        [self construct];
    return self;
}

- (void) construct {
    // Set Defaults.
    _iAlpha = 1.0;
    self.canResignExternally = TRUE;
    
    // Set our theme properties.
    self.themeElement = sIonThemeElementTextField;
    self.delegate = [IonInputManager sharedManager];
}

#pragma mark Input Filter

- (IonInputFilter *)inputFilter {
    if ( !_inputFilter )
        _inputFilter = [[IonInputFilter alloc] init];
    return _inputFilter;
}

#pragma mark Style Integration

- (void) applyStyle:(IonStyle *)style {
    [super applyStyle: style];
    
    /** Text */
    // Text Color
    self.textColor = [style.configuration colorForKey: sIonThemeText_Color usingTheme: style.theme];
    
    // Font
    self.font = [style.configuration fontForKey: sIonThemeText_Font];
    
    // Alignment
    self.textAlignment = [style.configuration textAlignmentForKey: sIonThemeText_Alignment];
    
    /** Placeholder */
    // Placeholder Font
    self.placeholderFont = [style.configuration fontForKey: sIonThemeText_PlaceholderFont];
    
    // Placeholder Color
    self.placeholderTextColor = [style.configuration colorForKey: sIonThemeText_PlaceholderColor usingTheme: style.theme];
    
    /** Input */
    // Input Filter
    self.inputFilter = [style.configuration inputFilterForKey: sIonTextField_InputFilterKey];
    
    // Set bahaviors
    self.behaviorDictionary = [style.configuration dictionaryForKey: sIonTextField_ResignBehaviorKey];
    
    // Configure keyboard
    [self processKeybordConfiguration: [style.configuration dictionaryForKey: sIonTextField_KeyboardKey]];
}

- (void) processKeybordConfiguration:(NSDictionary *)config {
    if ( !config || ![config isKindOfClass: [NSDictionary class]] )
        return;
    
    // Keyboard Type
    self.keyboardType = [config keyboardTypeForKey: sIonTextField_KeyboardTypeKey];
    
    // Keyboard Appearence
    self.keyboardAppearance = [config keyboardAppearanceForKey: sIonTextField_KeyboardAppearanceKey];
    
    // Auto Correct type
    self.autocorrectionType = [config autocorrectionTypeForKey: sIonTextField_KeyboardAppearanceKey];
    
    // Spell Check type
    self.spellCheckingType = [config spellcheckTypeForKey: sIonTextField_SpellCheckTypeKey];
    
    // Auto Capitalization Type
    self.autocapitalizationType = [config autocapitalizationTypeForKey: sIonTextField_AutoCapitalizationTypeKey];

    // Return Key
    self.returnKeyType = [config returnKeyTypeForKey: sIonTextField_ReturnKeyTypeKey];
    
    // Reload to display changes
    [self reloadInputViews];
}

#pragma mark Input Processing Responses

- (void) inputDidFailFilter {
    [UIView animateWithDuration: self.animationDuration / 2 animations: ^{
        if ( super.alpha != _iAlpha )
            return;
        super.alpha = _iAlpha - 0.4f;
    } completion: ^(BOOL finished) {
        if ( !finished )
            return;
       [UIView animateWithDuration: self.animationDuration / 2 animations: ^{
            super.alpha = _iAlpha;
        }];
    }];
}

#pragma mark Enter Target Action

- (FOTargetActionList *)enterKeyTargetActionList {
    if ( !_enterKeyTargetActionList )
        _enterKeyTargetActionList = [[FOTargetActionList alloc] init];
    return _enterKeyTargetActionList;
}

- (void) addTarget:(id)target action:(SEL)action {
    [self.enterKeyTargetActionList addTarget: target andAction: action toGroup: @"all"];
}

- (void) removeTarget:(id)target action:(SEL)action {
    [self.enterKeyTargetActionList removeTarget: target andAction: action fromGroup: @"all"];
}

- (void) removeAllTargetActions {
    [self.enterKeyTargetActionList removeAllGroups];
}

#pragma mark First Responder Paths

- (void) inputReturnKeyDidGetPressed {
    [self resignFirstResponderWithReason: sIonTextFieldBehavior_Reason_ReturnHit]; // Attempt to resign using the return key action.
    [self.enterKeyTargetActionList invokeActionSetsInGroup: @"all"];
}

- (BOOL) resignFirstResponder {
    // Attempt to resign using an external call.
    if ( self.canResignExternally )
        return [self resignFirstResponderWithReason: sIonTextFieldBehavior_Reason_ExternalResign];
    else
        return FALSE;
}

- (BOOL) resignFirstResponderWithReason:(NSString *)action {
    if ( [self canResignFirstResponderWithoutInvalidCheckForReason: action] )
        return [self forcivlyResignFirstResponder]; // We don't need to run validation to resign.
    else if ( [self textIsValid] )
        return [self forcivlyResignFirstResponder]; // Text is valid, we can resign.
    else { // Text isn't valid, and we are required to have valid text to return.
        [self invokeErrorAnimationForAction: action]; // Present a validation error animation in the UI.
        return FALSE; // Report to caller
    }
}

- (BOOL) forcivlyResignFirstResponder {
    return [super resignFirstResponder];
}

#pragma mark Behavior Dictionary

+ (BOOL) automaticallyNotifiesObserversOfBehaviorDictionary { return FALSE; }

- (void) setBehaviorDictionary:(NSDictionary *)behaviorDictionary {
    if ( !behaviorDictionary || ![behaviorDictionary isKindOfClass: [NSDictionary class]] )
        return;
    [self willChangeValueForKey: @"behaviorDictionary"];
    _behaviorDictionary = behaviorDictionary;
    [self didChangeValueForKey: @"behaviorDictionary"];
}

- (NSDictionary *)behaviorDictionary {
    if ( !_behaviorDictionary ) // if the dictionary is empty, construct with the default one.
        _behaviorDictionary = @{
                                sIonTextFieldBehavior_Reason_ReturnHit: @{
                                        sIonTextField_ResignBehavior_NoValidation: @1 // False
                                        // No Animation
                                        },
                                sIonTextFieldBehavior_Reason_ExternalResign: @{
                                        sIonTextField_ResignBehavior_NoValidation: @1 // True
                                        // No Animation
                                        }
                                };
    return _behaviorDictionary;
}

- (BOOL) canResignFirstResponderWithoutInvalidCheckForReason:(NSString *)action {
    NSParameterAssert( action && [action isKindOfClass: [NSString class]] );
    if ( !action || ![action isKindOfClass: [NSString class]] )
        return FALSE;
    
    return [[self.behaviorDictionary dictionaryForKey: action] boolForKey: sIonTextField_ResignBehavior_NoValidation];
}

- (void) invokeErrorAnimationForAction:(NSString *)action {
    NSDictionary *animationPointer;
    NSParameterAssert( action && [action isKindOfClass: [NSString class]] );
    if ( !action || ![action isKindOfClass: [NSString class]] )
        return; // We can't do anything with our input, stop.
    
    // Get animation pointer if any.
    animationPointer = [[self.behaviorDictionary dictionaryForKey: action]
                        dictionaryForKey: sIonTextField_ResignBehavior_ValidationFailedAnimation];
    // Only invkoke if there is an animation set.
    if ( animationPointer )
        [self startAnimationWithPointerMap: animationPointer];
}

#pragma mark Text Validation

- (BOOL) textIsValid {
    return FALSE; // TODO Run a check.
}

#pragma mark Placeholder Integration

- (void) setPlaceholder:(NSString *)placeholder {
    if ( (!_placeholderTextColor && !_placeholderFont) || !placeholder )
        super.placeholder = placeholder; // Normal No customization.
    else // Attributed string (colors, and font)
        super.attributedPlaceholder = [[NSAttributedString alloc] initWithString: placeholder
                                                                      attributes: [self placeholderAttributes]];
}

- (NSDictionary *)placeholderAttributes {
    return @{
             NSForegroundColorAttributeName: self.placeholderTextColor ? self.placeholderTextColor : [UIColor grayColor],
             NSFontAttributeName: self.placeholderFont ? self.placeholderFont : self.font
             };
}

#pragma mark Placeholder Color

+ (BOOL) automaticallyNotifiesObserversOfPlaceholderTextColor { return FALSE; }

- (void) setPlaceholderTextColor:(UIColor *)placeholderTextColor {
    [self willChangeValueForKey: @"placeholderTextColor"];
    _placeholderTextColor = placeholderTextColor;
    [self didChangeValueForKey: @"placeholderTextColor"];
    
    // Update Placeholder text
    [self setPlaceholder: self.placeholder];
}

#pragma mark Placeholder Font

+ (BOOL) automaticallyNotifiesObserversOfPlaceholderFont { return FALSE; }

- (void) setPlaceholderFont:(UIFont *)placeholderFont {
    [self willChangeValueForKey: @"placeholderFont"];
    _placeholderFont = placeholderFont;
    [self didChangeValueForKey: @"placeholderFont"];
    
    // Update Placeholder text
    [self setPlaceholder: self.placeholder];
}

#pragma mark Alpha
/**
 * Collects when the user changes alpha so we can animate it correctly.
 */
- (void) setAlpha:(CGFloat) alpha {
    _iAlpha = alpha;
    [super setAlpha: alpha];
}

#pragma mark View Updates

- (void)addSubview:(UIView *)view {
  [super addSubview: view];
  [view setParentStyle: self.themeConfiguration.currentStyle ];
}


@end

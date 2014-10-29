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
/**
 * Default constructor  
 */
- (instancetype) init {
    self = [super init];
    if ( self )
        [self construct];
    return self;
}

/**
 * Constructs the field with the inputted frame.
 * @param frame - the frame to construct with.
 */
- (instancetype) initWithFrame:(CGRect) frame {
    self = [super initWithFrame: frame];
    if ( self )
        [self construct];
    return self;
}

/**
 * Constructs the field with the inputted coder.
 * @param aDecoder - the coder to decode, and construct with.  
 */
- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder: aDecoder];
    if ( self )
        [self construct];
    return self;
}


/**
 * Standard construction functions to be shared between the different constructors.
 */
- (void) construct {
    // Set Defaults.
    _iAlpha = 1.0;
    self.canResignExternally = TRUE;
    
    // Set our theme properties.
    self.themeElement = sIonThemeElementTextField;
    self.delegate = [IonInputManager sharedManager];
}

#pragma mark Input Filter
/**
 * Gets, or constructs the input filter.
 */
- (IonInputFilter *)inputFilter {
    if ( !_inputFilter )
        _inputFilter = [[IonInputFilter alloc] init];
    return _inputFilter;
}

#pragma mark Style Integration

/**
 * Process our style information
 * @param {IonStyle*} the style to apply.
 */
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

/**
 * Process the keybord configuration dictionary.
 * @param {NSDictionary*} the input configuration.
 */
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
/**
 * Gets called when we input fails our filter.
 */
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
/**
 * Gets called when the enter key is pressed.
 */
- (void) inputReturnKeyDidGetPressed {
    [self resignFirstResponderWithReason: sIonTextFieldBehavior_Reason_ReturnHit]; // Attempt to resign using the return key action.
    [self.enterKeyTargetActionList invokeActionSetsInGroup: @"all"];
}

/**
 * Attempts to resign first responder, using the external action.
 * @return {BOOL}
 */
- (BOOL) resignFirstResponder {
    // Attempt to resign using an external call.
    if ( self.canResignExternally )
        return [self resignFirstResponderWithReason: sIonTextFieldBehavior_Reason_ExternalResign];
    else
        return FALSE;
}

/**
 * Attempts to resign first responder using the specified reason.
 * @param {NSString*} the reason for resigning first responder.
 * @return {BOOL}
 */
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

/**
 * Forcevly resigns first responder by ingnoring all checks.
 * @return {BOOL} if the super will resign first responder.
 */
- (BOOL) forcivlyResignFirstResponder {
    return [super resignFirstResponder];
}

#pragma mark Behavior Dictionary
/**
 * Switch KVO to manual mode.
 */
+ (BOOL) automaticallyNotifiesObserversOfBehaviorDictionary { return FALSE; }

/**
 * Sets the behavior dictionary key.
 * @param {NSDictionary*}
 */
- (void) setBehaviorDictionary:(NSDictionary *)behaviorDictionary {
    if ( !behaviorDictionary || ![behaviorDictionary isKindOfClass: [NSDictionary class]] )
        return;
    [self willChangeValueForKey: @"behaviorDictionary"];
    _behaviorDictionary = behaviorDictionary;
    [self didChangeValueForKey: @"behaviorDictionary"];
}

/**
 * Gets, or constructs the acction dictionary.
 * @return {NSDictionary*}
 */
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

/**
 * Checks if we can resign first responder without checking if our text is valid for the specified reason,
 * from our behavior dictionary.
 * @param {NSString*} the action to invoke the animation for.
 * @return {BOOL}
 */
- (BOOL) canResignFirstResponderWithoutInvalidCheckForReason:(NSString *)action {
    NSParameterAssert( action && [action isKindOfClass: [NSString class]] );
    if ( !action || ![action isKindOfClass: [NSString class]] )
        return FALSE;
    
    return [[self.behaviorDictionary dictionaryForKey: action] boolForKey: sIonTextField_ResignBehavior_NoValidation];
}

/**
 * Invokes the error animation for the specified action if it exsists.
 * @param {NSString*} the action to invoke the animation for.
 */
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
/**
 * Checks if the raw text is valid.
 * @return {BOOL}
 */
- (BOOL) textIsValid {
    return FALSE; // TODO Run a check.
}

#pragma mark Placeholder Integration

/**
 * Sets the placeholder text.
 * @param {NSString*} the new placeholder text.
 */
- (void) setPlaceholder:(NSString *)placeholder {
    if ( (!_placeholderTextColor && !_placeholderFont) || !placeholder )
        super.placeholder = placeholder; // Normal No customization.
    else // Attributed string (colors, and font)
        super.attributedPlaceholder = [[NSAttributedString alloc] initWithString: placeholder
                                                                      attributes: [self placeholderAttributes]];
}

/**
 * Gets the placeholder attributes dictionary from the current settings.
 * @return {NSDictionary*} the attributes.
 */
- (NSDictionary *)placeholderAttributes {
    return @{
             NSForegroundColorAttributeName: self.placeholderTextColor ? self.placeholderTextColor : [UIColor grayColor],
             NSFontAttributeName: self.placeholderFont ? self.placeholderFont : self.font
             };
}

#pragma mark Placeholder Color
/**
 * Switches placeholder text color KVO to manual mode.
 * @return {BOOL}
 */
+ (BOOL) automaticallyNotifiesObserversOfPlaceholderTextColor { return FALSE; }

/**
 * Sets the placeholder text color.
 * @param {UIColor*} the new color.
 */
- (void) setPlaceholderTextColor:(UIColor *)placeholderTextColor {
    [self willChangeValueForKey: @"placeholderTextColor"];
    _placeholderTextColor = placeholderTextColor;
    [self didChangeValueForKey: @"placeholderTextColor"];
    
    // Update Placeholder text
    [self setPlaceholder: self.placeholder];
}

#pragma mark Placeholder Font
/**
 * Switches placeholder font KVO to manual mode.
 * @return {BOOL}
 */
+ (BOOL) automaticallyNotifiesObserversOfPlaceholderFont { return FALSE; }

/**
 * Sets the placeholder font.
 * @param {UIFont*} the new font.
 */
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

@end

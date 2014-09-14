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


@interface IonTextField () {
    CGFloat _iAlpha; // ivar to hold our user set alpha so we can animate alpha while preserving user set states.
    
    UITapGestureRecognizer *tap;
}

@end

@implementation IonTextField

@synthesize inputFilter = _inputFilter;

#pragma mark Constructors
/**
 * Default constructor
 * @returns {instancetype}
 */
- (instancetype) init {
    self = [super init];
    if ( self )
        [self construct];
    return self;
}

/**
 * Constructs the field with the inputted frame.
 * @param {CGRect} the frame to construct with.
 * @returns {instancetype}
 */
- (instancetype) initWithFrame:(CGRect) frame {
    self = [super initWithFrame: frame];
    if ( self )
        [self construct];
    return self;
}

/**
 * Constructs the field with the inputted coder.
 * @param {NSCoder*} the coder to decode, and construct with.
 * @returns {instancetype}
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
    self.keyboardAppearance = [config keyboardAppearenceForKey: sIonTextField_KeyboardAppearenceKey];
    
    // Auto Correct type
    self.autocorrectionType = [config autocorrectionTypeForKey: sIonTextField_KeyboardAppearenceKey];
    
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
        super.alpha = _iAlpha - 0.4;
    } completion: ^(BOOL finished) {
        if ( !finished )
            return;
       [UIView animateWithDuration: self.animationDuration / 2 animations: ^{
            super.alpha = _iAlpha;
        }];
    }];
}

/**
 * Gets called when the enter key is pressed.
 */
- (void) inputReturnKeyDidGetPressed {
    [self tryReturn]; // Attempt to return.
}

/**
 * Trys to invoke the return procedure.
 * Note: only will return if current input states are valid.
 */
- (BOOL) tryReturn {
    // Only Return if valid, and ! in forcive input mode
    if ( !true )
        return FALSE;
    
    // Call our target action set for return key.
    
    // Dissmiss keyboard on supper because self points the method twards this.
    return [super resignFirstResponder];
}

/**
 * Redirects to our return processor.
 */
- (BOOL) resignFirstResponder {
    return [self tryReturn]; // Attempt a return.
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
 * @returns {BOOL}
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
 * @returns {BOOL}
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

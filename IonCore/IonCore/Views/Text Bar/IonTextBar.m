//
//  IonTextBar.m
//  Ion
//
//  Created by Andrew Hurst on 9/12/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonTextBar.h"
#import "IonTextField.h"

#import "UIView+IonGuideGroup.h"
#import "IonCompleteGuideGroup.h"

@interface IonTextBar () {
    
}

/**
 * The views text field.
 */
@property (strong, nonatomic, readonly) IonTextField *textField;

@end

@implementation IonTextBar

@synthesize textField = _textField;
@synthesize icon = _icon;

#pragma mark Construction
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
 * Framed constructor.
 * @param {CGRect} the frame to construct with.  
 */
- (instancetype) initWithFrame:(CGRect) frame {
    self = [super initWithFrame: frame];
    if ( self )
        [self construct];
    return self;
}

/**
 * Construction method.
 */
- (void) construct {
    self.themeElement = @"textBar";
    [self addSubview: self.icon];
    [self addSubview: self.textField];
}

#pragma mark Text Field
/**
 * Gets, or constructs the text field.
 * @return {IonTextField*}
 */
- (IonTextField *)textField {
    if ( !_textField ) {
        _textField = [[IonTextField alloc] init];
        
        // Position the text field next to the Icon.
        [_textField setGuidesWithLocalHoriz: _textField.originGuideHoriz
                                  localVert: _textField.centerGuideVert
                                 superHoriz: self.icon.rightMargin
                               andSuperVert: self.centerGuideVert];
        
        // Size the text field to fit with in the icon and the padding.
        _textField.leftSizeGuide = self.icon.rightMargin;
        _textField.rightSizeGuide = self.rightAutoPadding;
        _textField.topSizeGuide = self.originGuideVert;
        _textField.bottomSizeGuide = self.sizeGuideVert;
    }
    return _textField;
}

#pragma mark Placeholder Text
/**
 * Sets the dependents on the placeholder text.
 * @return {NSSet*}
 */
+ (NSSet *)keyPathsForValuesAffectingPlaceholder {
    return [NSSet setWithArray:@[@"textField.placeholder"]];
}

/**
 * Sets our placeholder text.
 * @param {NSString*} the new placeholder text.
 */
- (void) setPlaceholder:(NSString *)placeholder {
    self.textField.placeholder = placeholder;
}

/**
 * Gets the placeholder text.
 */
- (NSString *)placeholder {
    return self.textField.placeholder;
}

#pragma mark Placeholder Text Color
/**
 * Sets the dependents on the placeholder color.
 * @return {NSSet*}
 */
+ (NSSet *)keyPathsForValuesAffectingPlaceholderTextColor {
    return [NSSet setWithArray:@[@"textField.placeholderTextColor"]];
}

/**
 * Sets our placeholder text color.
 * @param {UIColor*} the new placeholder text color.
 */
- (void) setPlaceholderTextColor:(UIColor *)placeholderTextColor {
    self.textField.placeholderTextColor = placeholderTextColor;
}

/**
 * Gets the placeholder text color.
 * @return {UIColor*}
 */
- (UIColor *)placeholderTextColor {
    return self.textField.placeholderTextColor;
}

#pragma mark Placeholder Font
/**
 * Sets the dependents on the placeholder font.
 * @return {NSSet*}
 */
+ (NSSet *)keyPathsForValuesAffectingPlaceholderFont{
    return [NSSet setWithArray:@[@"textField.placeholderFont"]];
}

/**
 * Sets our placeholder font.
 * @param {UIColor*} the new placeholder font.
 */
- (void) setPlaceholderFont:(UIFont *)placeholderFont {
    self.textField.placeholderFont = placeholderFont;
}

/**
 * Gets the placeholder font.
 * @return {UIFont*}
 */
- (UIFont *)placeholderFont{
    return self.textField.placeholderFont;
}

#pragma mark Input Filter
/**
 * Sets the dependents on the Input filter
 * @return {NSSet*}
 */
+ (NSSet *)keyPathsForValuesAffectingInputFilter{
    return [NSSet setWithArray:@[@"textField.InputFilter"]];
}

/**
 * sets the input filter to be used.
 * @param {IonInputFilter *}
 */
- (void) setInputFilter:(IonInputFilter *)inputFilter {
    self.textField.inputFilter = inputFilter;
}

/**
 * Gets the current input filter.
 * @return {IonInputFilter *}
 */
- (IonInputFilter *)inputFilter {
    return self.textField.inputFilter;
}

#pragma mark Enter Target Action
/**
 * Sets the key paths affecting the enter target action.
 * @return {NSSet*}
 */
+ (NSSet *)keyPathsForValuesAffectingEnterKeyTargetAction {
    return  [NSSet setWithArray:@[@"textField.enterKeyTargetAction"]];;
}

#pragma mark Icon
/**
 * Switch icon to manual KVO mode.
 * @return {BOOL}
 */
+ (BOOL) automaticallyNotifiesObserversOfIcon { return FALSE; }

/**
 * Sets and configures the icon.
 * @param {IonView *} the new icon view.
 */
- (void) setIcon:(IonView *)icon {
    [self willChangeValueForKey: @"icon"];
    _icon = icon;
    [self didChangeValueForKey: @"icon"];
    
    if ( !_icon )
        return;
    
    // Position
    [_icon setGuidesWithLocalHoriz: _icon.originGuideHoriz
                         localVert: _icon.centerGuideVert
                        superHoriz: self.leftAutoPadding
                      andSuperVert: self.centerGuideVert];
    if ( _textField )
        _textField.superHorizGuide = _textField.leftSizeGuide = self.icon.rightMargin;
}

/**
 * Gets, or constructs the icon.
 * @return {IonView *}
 */
- (IonView *)icon {
    if ( !_icon )
        self.icon = [[IonIcon alloc] init];
    return _icon;
}

#pragma mark Responder Management
/**
 * Sets the view as first responder.
 * @return {BOOL}
 */
- (BOOL) becomeFirstResponder {
    // Set the text field as the first responder so that we can accept input.
    return [self.textField becomeFirstResponder];
}

/**
 * Removes the view as first responder
 */
- (BOOL) resignFirstResponder {
    // We are simply a proxy the responder, send to the text field.
    return [self.textField resignFirstResponder];
}

- (BOOL) isFirstResponder {
    // We are a proxy to the text field, we need to control the flow of messages so we will take responsibility for the
    // fields actions.
    return [self.textField isFirstResponder];
}

@end

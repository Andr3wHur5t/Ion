//
//  IonInputManager.m
//  Ion
//
//  Created by Andrew Hurst on 9/9/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonInputManager.h"
#import "IonInputFilter.h"

@implementation IonInputManager
#pragma mark UITextField Delegate
/**
 * Gets called when a textField was provided input, where the replacement string is the string to set, or append.
 * @returns {BOOL} stating if the text field should allow the change to occur.
 */
- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    IonInputFilter *filter;
    BOOL canUseReplacement;
    
    // Check if this field conforms to a filter spec.
    if ( [textField conformsToProtocol: @protocol(IonInputManagerFilterSpec)] ) {
        // Get the filter from the view.
        filter = [textField performSelector: @selector(inputFilter)];
        if ( !filter )
            return TRUE; // If we dont have a filter then all text is good.
        
        // Dose then new conform to the forms' filter?
        canUseReplacement = [filter string: string ConformsWithRange: range];
        
        // If it doesn't report an error to the view so it can respond appropriately.
        if ( !canUseReplacement )
            if ( [textField respondsToSelector: @selector(inputDidFailFilter)] )
                [textField performSelector: @selector(inputDidFailFilter) withObject:NULL]; // Report that we did fail filter
        
        // Report if the input conforms to our filter.
        return canUseReplacement;
    }
    else
        return TRUE; // Return Default.
}

/**
 * Gets called went allow the text fields' enter key is pressed.
 * @returns {BOOL}
 */
- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    if ( !textField || ![textField isKindOfClass: [UITextField class]] )
        return TRUE;
    
    // Check if we can inform the text field that the enter key was pressed.
    if ( [textField conformsToProtocol: @protocol(IonInputManagerFilterSpec)] &&
        [textField respondsToSelector: @selector(inputReturnKeyDidGetPressed)] )
            [textField performSelector: @selector(inputReturnKeyDidGetPressed) withObject:NULL];
    return TRUE;
}

#pragma mark UITextView Delegate


@end

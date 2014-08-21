//
//  IonLabelOverflowBehavior.m
//  Ion
//
//  Created by Andrew Hurst on 8/20/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonLabelOverflowBehavior.h"

@interface IonLabelOverflowBehavior () {
    BOOL isAnimating;
}

@end

@implementation IonLabelOverflowBehavior

/**
 * Standard Constructor
 */
- (instancetype) init {
    self = [super init];
    if ( self )
        ;
    return self;
}


#pragma mark Protocol Implmentation

/**
 * Sets the Current managed views.
 * @param {UIView*} the containing view
 * @param {UILabel*} the label to manage
 * @returns {void}
 */
- (void) setContainer:(IonLabel*) view andLabel:(UILabel*) label {
    _label = label;
    _container = view;
}

/**
 * Informs the behavior deligate of an attribute change of the label.
 * @returns {void}
 */
- (void) updateStates {
    if ( ![self canPerformManagementFunctions] )
        return;
    [self updateLabelFrameToMatchContainer];
    
    if ( [self shouldAnimateText] )
        [self animateText];
}

#pragma mark Default Response

/**
 * Checks if we should animate the view
 * @returns {BOOL}
 */
- (BOOL) shouldAnimateText {
    return _container.frame.size.width + 5 < _label.frame.size.width;
}

/**
 * Executes the default scroll animation
 * @returns {void}
 */
- (void) animateText {
    CGFloat durration, delay;
    if ( isAnimating || ![self canPerformManagementFunctions] )
        return;
    
    durration = sIonTextScrollSpeed * _label.frame.size.width;
    delay = _container.frame.size.width * sIonTextScrollSpeed;
    isAnimating = TRUE;
    [UIView animateWithDuration: durration
                          delay: delay
                        options: UIViewAnimationOptionCurveEaseInOut
    animations: ^{
        [_label setFrame: (CGRect){ (CGPoint){  ( _label.frame.size.width * -1 ) + _container.frame.size.width - 5 ,0 },
            _label.frame.size }];
    }
    completion: ^(BOOL finished) {
        [UIView animateWithDuration: 0.2
                              delay: delay
                            options: UIViewAnimationOptionCurveEaseIn
        animations: ^{
            _label.alpha = 0.0f;
        }
        completion: ^(BOOL finished) {
            [_label setFrame: (CGRect){ CGPointZero, _label.frame.size }];
            [UIView animateWithDuration: 0.2
            animations: ^{
                _label.alpha = 1.0f;
            }
            completion: ^(BOOL finished) {
                isAnimating = FALSE;
                if ( [self shouldAnimateText] )
                    [self animateText];
            }];
        }];
    }];
}

#pragma mark Utilties

/**
 * Updates the label to match the container frame.
 * @returns {void}
 */
- (void) updateLabelFrameToMatchContainer {
    if ( ![self canPerformManagementFunctions] )
        return;
        
    self.label.frame = (CGRect){
        self.label.frame.origin,
        [self sugestedLabelSize]
    };
}

/**
 * Gets the Sugested Size of the label.
 * @returns {CGFloat}
 */
- (CGSize) sugestedLabelSize {
    CGSize textSize;
    if ( ![self canPerformManagementFunctions] )
        return CGSizeZero;
    
    
    textSize = [_label.text sizeWithAttributes:
                    @{ NSFontAttributeName: _label.font }];
    
    return (CGSize) {
        _container.frame.size.width >= textSize.width ? _container.frame.size.width : textSize.width,
        _container.frame.size.height
    };
}

/**
 * Check if we can perform managment functions.
 * @returns {BOOL}
 */
- (BOOL) canPerformManagementFunctions {
    return self.label && self.container;
}

@end

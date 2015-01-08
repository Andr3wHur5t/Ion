//
//  IonLabelOverflowBehavior.m
//  Ion
//
//  Created by Andrew Hurst on 8/20/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonLabelOverflowBehavior.h"

const NSTimeInterval aAnimatonDelay = 0.25;

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


#pragma mark Protocol Implementation

/**
 * Sets the Current managed views.
 * @param {UIView*} the containing view
 * @param {UILabel*} the label to manage  
 */
- (void) setContainer:(IonLabel*) view andLabel:(UILabel*) label {
    _label = label;
    _container = view;
}

/**
 * Informs the behavior delegate of an attribute change of the label.  
 */
- (void) updateStates {
    if ( ![self canPerformManagementFunctions] )
        return;
    [self updateLabelFrameToMatchContainer];
  
  [self performBlock:^{
    if ( [self shouldAnimateText] )
      [self animateText];
  } afterDelay:aAnimatonDelay];
}

#pragma mark Default Response

/**
 * Checks if we should animate the view
 * @return {BOOL}
 */
- (BOOL) shouldAnimateText {
  return FALSE;//_container.frame.size.width + 5 < _label.frame.size.width;
}

/**
 * Executes the default scroll animation  
 */
- (void) animateText {
    CGFloat durration, delay;
    if ( isAnimating || ![self canPerformManagementFunctions] )
        return;
    
    durration = sIonTextScrollSpeed * (_label.frame.size.width / _label.font.xHeight);
    delay = (_label.frame.size.width / _label.font.xHeight) * sIonTextScrollSpeed;
    isAnimating = TRUE;
    [UIView animateWithDuration: durration
                          delay: delay
                        options: UIViewAnimationOptionCurveEaseInOut
    animations: ^{
        [_label setFrame: (CGRect){ (CGPoint){  ( _label.frame.size.width * -1 ) + _container.frame.size.width - 5 ,0 },
            _label.frame.size }];
    }
    completion: ^(BOOL finished) {
      [UIView animateWithDuration: durration / 6
                       animations: ^{
                         [_label setFrame: (CGRect){ CGPointZero, _label.frame.size }];
                       }
                       completion: ^(BOOL fin) {
                         isAnimating = FALSE;
                         if ( [self shouldAnimateText] )
                           [self animateText];
                       }];
    }];
}

#pragma mark Utilities

/**
 * Updates the label to match the container frame.  
 */
- (void) updateLabelFrameToMatchContainer {
    if ( ![self canPerformManagementFunctions] )
        return;
        
    self.label.frame = (CGRect){
        self.label.frame.origin,
        [self suggestedLabelSize]
    };
}

/**
 * Gets the Suggested Size of the label.
 * @return {CGFloat}
 */
- (CGSize) suggestedLabelSize {
    CGSize textSize;
    if ( ![self canPerformManagementFunctions] )
        return CGSizeZero;
    
    if ( [_label.text respondsToSelector: @selector(sizeWithAttributes:)] )
        textSize = [_label.text sizeWithAttributes: @{ NSFontAttributeName: _label.font }];
    else
        textSize = [_label.text sizeWithFont: _label.font];
    
    return (CGSize) {
        _container.frame.size.width >= textSize.width ? _container.frame.size.width : textSize.width,
        _container.frame.size.height
    };
}

/**
 * Check if we can perform management functions.
 * @return {BOOL}
 */
- (BOOL) canPerformManagementFunctions {
    return self.label && self.container;
}

@end

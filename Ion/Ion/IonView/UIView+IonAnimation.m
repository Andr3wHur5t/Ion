//
//  IonAnimation.m
//  Ion
//
//  Created by Andrew Hurst on 7/13/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "UIView+IonAnimation.h"

@implementation UIView (IonAnimation)

/**
 * Dose a dual phase animation using the inputted duration, and option.
 * @param {void(^)( )} phaseOne animation
 * @param {void(^)( )} phaseOne animation
 * @param {CGFloat} durration
 * @param {UIAnimationOptions} options
 * @returns {void}
 */
+ (void) animationWithPhaseOne:(void(^)( )) phaseOne
                      phaseTwo:(void(^)( )) phaseTwo
                usingDuration:(CGFloat) durration
                 startingDelay:(CGFloat) startDelay
             intermediateDelay:(CGFloat) intermediateDelay
                       options:(UIViewAnimationOptions) options
                 andCompletion:(void(^)( )) completion {
    // Verify
    if ( !phaseOne || !phaseTwo )
        return;
    
    // Do Phase one
    [UIView animateWithDuration: durration
                          delay: startDelay
                        options: options
                     animations: phaseOne
                     completion: ^(BOOL finished) {
                         
                         // DO the phase two animation
                         [UIView animateWithDuration: durration
                                               delay: intermediateDelay
                                             options: options
                                          animations: phaseTwo
                                          completion: ^(BOOL finished) {
                                              // Invoke the phase two animation if
                                              if ( completion )
                                                  completion( );
                                          }];
                     }];
}

@end

//
//  IonAnimation.h
//  Ion
//
//  Created by Andrew Hurst on 7/13/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (IonAnimation)


#pragma mark Polyphase animations

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
                 andCompletion:(void(^)( )) completion;

@end

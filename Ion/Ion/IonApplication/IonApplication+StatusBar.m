//
//  IonApplication+StatusBar.m
//  Ion
//
//  Created by Andrew Hurst on 8/24/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonApplication+StatusBar.h"
#import <IonData/IonData.h>

/**
 * Keys
 */
static NSString* sIonApplication_StatusBarCurrentAnimationKey = @"StatusBarCurrentAnimation";

@implementation IonApplication (StatusBar)
#pragma mark Status Bar Frame
/**
 * Sets dependent variables for the frame
 */
+ (NSSet*) keyPathsForValuesAffectingStatusBarFrame {
    return [NSSet setWithArray:@[@"statusBarHidden"]];
}

/**
 * Gets the current real status bar frame.
 * @returns {CGRect}
 */
- (CGRect) statusBarFrame {
    CGRect frame;
    frame = [UIApplication sharedApplication].statusBarFrame;
    if ( self.statusBarHidden )
        frame.size.height = 0.0f;
    return frame;
}

#pragma mark inCallBarActive
/**
 * Checks if the height matches the InCall Height.
 * @warning Dose a literal Check. May Not work in future versions.
 * @returns {BOOL}
 */
- (BOOL) inCallBarActive {
    return [UIApplication sharedApplication].statusBarFrame.size.height != sIonNormalStatusBarHeight;
}

#pragma mark Status Bar Hidden
/**
 * Sets the status bar hidden variable to manual KVO mode
 */
+ (BOOL)automaticallyNotifiesObserversOfStatusBarHidden { return FALSE; }

/**
 * Sets the status bar to hidden.
 * @param {BOOl} the new state
 * @returns {void}
 */
- (void) setStatusBarHidden:(BOOL) statusBarHidden {
    [self willChangeValueForKey: @"statusBarHidden"];
    [[UIApplication sharedApplication] setStatusBarHidden: statusBarHidden];
    [self didChangeValueForKey: @"statusBarHidden"];
}

/**
 * Gets the current state.
 * @returns {BOOl}
 */
- (BOOL) statusBarHidden {
    return [UIApplication sharedApplication].statusBarHidden;
}

#pragma mark Status Bar Animation Duration
/**
 * Gets the status bar animation duration.
 * @returns {CGFloat}
 */
- (CGFloat) statusBarAnimationDuration {
    return 0.25f;
}


#pragma mark Current Status Bar Animation
/**
 * Updates the current status bar animation information.
 */
- (void) updateStatusBarAnimationTo:(UIStatusBarAnimation) animation {
    [self willChangeValueForKey:@"currentStatusBarAnimation"];
    [self.catagoryVariables setObject: [NSNumber numberWithInteger: animation]
                           forKey: sIonApplication_StatusBarCurrentAnimationKey];
    [self didChangeValueForKey:@"currentStatusBarAnimation"];
}

/**
 * Gets the current status bar animation type.
 */
- (UIStatusBarAnimation) currentStatusBarAnimation {
    return [[self.catagoryVariables numberForKey:sIonApplication_StatusBarCurrentAnimationKey] integerValue];
}

#pragma mark Status Bar Animations
/**
 * Runs a animation on the status bar that works with KVO.
 * @param {BOOL} states if the animation bar is to be hidden or not.
 * @param {UIStatusBarAnimation} the animation type to run on the status bar.
 * @returns {void}
 */
- (void) setStatusBarHidden:(BOOL) statusBarHidden withAnimation:(UIStatusBarAnimation) animation {
    if ( statusBarHidden == self.statusBarHidden )
        return;
    
    [self willChangeValueForKey: @"statusBarHidden"];
    [[UIApplication sharedApplication] setStatusBarHidden: statusBarHidden withAnimation: animation];
    [self didChangeValueForKey: @"statusBarHidden"];
    
    // Set the anumation key
    [self updateStatusBarAnimationTo: animation];
}

@end

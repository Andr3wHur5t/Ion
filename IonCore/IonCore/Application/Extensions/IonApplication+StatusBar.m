//
//  IonApplication+StatusBar.m
//  Ion
//
//  Created by Andrew Hurst on 8/24/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonApplication+StatusBar.h"
#import <IonCore/IonCore.h>
#import <IonData/IonData.h>

/**
 * Keys
 */
static NSString *sIonApplication_StatusBarCurrentAnimationKey = @"StatusBarCurrentAnimation";

@implementation IonApplication (StatusBar)
#pragma mark Status Bar Frame

+ (NSSet*) keyPathsForValuesAffectingStatusBarFrame {
    return [NSSet setWithArray:@[@"statusBarHidden"]];
}

- (CGRect) statusBarFrame {
    CGRect frame;
    frame = [UIApplication sharedApplication].statusBarFrame;
    if ( self.statusBarHidden )
        frame.size.height = 0.0f;
    return frame;
}

#pragma mark inCallBarActive

- (BOOL) inCallBarActive {
    return [UIApplication sharedApplication].statusBarFrame.size.height != sIonNormalStatusBarHeight;
}

#pragma mark Status Bar Hidden

+ (BOOL)automaticallyNotifiesObserversOfStatusBarHidden { return FALSE; }

- (void) setStatusBarHidden:(BOOL) statusBarHidden {
    [self willChangeValueForKey: @"statusBarHidden"];
    [[UIApplication sharedApplication] setStatusBarHidden: statusBarHidden];
    [self didChangeValueForKey: @"statusBarHidden"];
}

- (BOOL) statusBarHidden {
    return [UIApplication sharedApplication].statusBarHidden;
}

#pragma mark Status Bar Animation Duration

- (CGFloat) statusBarAnimationDuration {
    return 0.25f;
}

#pragma mark Current Status Bar Animation

- (void) updateStatusBarAnimationTo:(UIStatusBarAnimation) animation {
    [self willChangeValueForKey:@"currentStatusBarAnimation"];
    [self.categoryVariables setObject: [NSNumber numberWithInteger: animation]
                           forKey: sIonApplication_StatusBarCurrentAnimationKey];
    [self didChangeValueForKey:@"currentStatusBarAnimation"];
}

- (UIStatusBarAnimation) currentStatusBarAnimation {
    return [[self.categoryVariables numberForKey:sIonApplication_StatusBarCurrentAnimationKey] integerValue];
}

#pragma mark Status Bar Animations

- (void) setStatusBarHidden:(BOOL) statusBarHidden withAnimation:(UIStatusBarAnimation) animation {
    if ( statusBarHidden == self.statusBarHidden )
        return;
    
    [self willChangeValueForKey: @"statusBarHidden"];
    [[UIApplication sharedApplication] setStatusBarHidden: statusBarHidden withAnimation: animation];
    [self didChangeValueForKey: @"statusBarHidden"];
    
    // Set the animation key
    [self updateStatusBarAnimationTo: animation];
}

#pragma mark Status Bar Guide

- (IonGuideLine *)statusBarHeightGuide {
  IonGuideLine *guide = [self.categoryVariables objectForKey:@"statusBarHeightGuide"];
  if ( !guide ) {
    guide = [IonGuideLine guideWithTargetRectSize:self
                                 usingRectKeyPath:@"statusBarFrame"
                                           amount:1.0f
                                          andMode:IonGuideLineFrameMode_Vertical];
    [self.categoryVariables setObject: guide forKey:@"statusBarHeightGuide"];
  }
  return guide;
}

@end

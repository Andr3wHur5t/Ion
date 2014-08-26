//
//  IonTitleBar.h
//  Ion
//
//  Created by Andrew Hurst on 8/23/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <Ion/Ion.h>

@interface IonTitleBar : IonView

/**
 * The left View.
 */
@property (strong, nonatomic) UIView* leftView;

/**
 * The Center View.
 */
@property (strong, nonatomic) UIView* centerView;

/**
 * The Center View.
 */
@property (strong, nonatomic) UIView* rightView;

/**
 * The offset of the title bar content in comparason to the status bar.
 */
@property (assign, nonatomic) CGFloat statusBarContentOffset;

/**
 * The content height of the title bar
 */
@property (assign, nonatomic) CGFloat contentHeight;

/**
 * State if the title bar will respond to changes in the status bar.
 */
@property (assign, nonatomic) BOOL respondsToStatusBar;

/**
 * Updates the frame to match the current configuration.
 * @returns {void}
 */
- (void) updateFrame;

@end

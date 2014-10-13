//
//  IonTitleBar.h
//  Ion
//
//  Created by Andrew Hurst on 8/23/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <Ion/Ion.h>

@interface IonTitleBar : IonView
#pragma mark Views
/**
 * The left View.
 */
@property (strong, nonatomic, readwrite) UIView *leftView;

/**
 * The Center View.
 */
@property (strong, nonatomic, readwrite) UIView *centerView;

/**
 * The Center View.
 */
@property (strong, nonatomic, readwrite) UIView *rightView;

#pragma mark Status Bar Response Configuration

/**
 * The offset of the title bar content in comparason to the status bar.
 */
@property (assign, nonatomic, readwrite) CGFloat statusBarContentOffset;

/**
 * The content height of the title bar
 */
@property (assign, nonatomic, readwrite) CGFloat contentHeight;

/**
 * State if the title bar will respond to changes in the status bar.
 */
@property (assign, nonatomic, readwrite) BOOL respondsToStatusBar;

/**
 * Updates the of the title bar to fit the super view.
 * @param superview - the view the title bar will be put in.
 */
- (void) updateFrame;
@end

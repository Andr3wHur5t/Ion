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

@end

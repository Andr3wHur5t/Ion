//
//  IonTextView.h
//  IonCore
//
//  Created by Andrew Hurst on 10/27/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IonGuideLine;

@interface IonTextView : UITextView

#pragma mark Guides
/**
 * Guide representing the text height if it was restricted by its current width.
 */
@property (strong, nonatomic, readonly) IonGuideLine *textHeightConstrainedByWidth;

@end

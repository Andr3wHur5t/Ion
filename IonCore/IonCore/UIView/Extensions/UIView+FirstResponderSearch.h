//
//  UIView+FirstResponderSearch.h
//  Ion
//
//  Created by Andrew Hurst on 9/9/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FirstResponderSearch)
/**
 * Looks for the first responder within our subviews.
 * Using Ion prefix to ensure that we don't collide with apples private APIs
 * @return {UIView*} the first responder view if any.
 */
- (UIView *)ionFirstResponder;
@end

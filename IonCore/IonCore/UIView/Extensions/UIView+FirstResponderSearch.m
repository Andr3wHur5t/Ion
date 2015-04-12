//
//  UIView+FirstResponderSearch.m
//  Ion
//
//  Created by Andrew Hurst on 9/9/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "UIView+FirstResponderSearch.h"

@implementation UIView (FirstResponderSearch)
/**
 * Looks for the first responder within our subviews.
 * Using Ion prefix to ensure that we don't collide with apples private APIs
 * @return {UIView*} the first responder view if any.
 */
- (UIView *)ionFirstResponder {
  UIView *responder;
  if (self.isFirstResponder)
    return self;
  else
    for (UIView *subview in self.subviews) {
      responder = [subview ionFirstResponder];
      if (responder) return responder;
    }
  return NULL;
}
@end

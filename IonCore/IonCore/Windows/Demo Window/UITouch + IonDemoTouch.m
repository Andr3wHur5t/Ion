//
//  UITouch + IonDemoWindowTouchRepresentation.m
//  Ion
//
//  Created by Andrew Hurst on 7/10/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "UITouch + IonDemoTouch.h"
#import <objc/runtime.h>

static void *sTouchImageViewKey;

@implementation UITouch (IonDemoTouch)

- (UIView *)touchRepresentationView {
    return objc_getAssociatedObject(self, sTouchImageViewKey);
}

- (void)setTouchRepresentationView:(UIView*)newTouchRepresentationView {
    objc_setAssociatedObject(self, sTouchImageViewKey, newTouchRepresentationView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void) centerRepresentation {
    CGPoint point = [self locationInView: self.touchRepresentationView.superview];
    self.touchRepresentationView.frame = CGRectMake(point.x - 20, point.y - 20, 40, 40);
}

@end
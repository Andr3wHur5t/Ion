//
//  IonDemoUIWindow.m
//  Ion
//
//  Created by Andrew Hurst on 7/10/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//
//  This window will render touch points as an image in their position on the screen.
//

#import "IonDemoUIWindow.h"
#import "UITouch + IonDemoTouch.h"
#import <SimpleMath/SimpleMath.h>

@interface IonDemoUIWindow ()

/**
 * Gets the view used for touch.
 */
- (UIView *)getViewForTouchRepresentation;

@end

@implementation IonDemoUIWindow

- (void) sendEvent:(UIEvent *)event {
    // Intercepts all touch events and sends them to the processing function.
    [super sendEvent:event];
    if (event.type == UIEventTypeTouches) {
        for (UITouch *touch in [event allTouches]) {
            [self processTouchEvent:touch];
        }
    }
}

- (void) processTouchEvent:(UITouch *)touch {
  // I've tried animating this, it doesn't work very well..
    // Processes a touch event, and renders a view depending on the state of the touch.
    if (touch.phase == UITouchPhaseBegan) {
        touch.touchRepresentationView = [self getViewForTouchRepresentation];
        
        [touch centerRepresentation];
        
        // Add to view
        [self addSubview: touch.touchRepresentationView];
      
    }
    else if (touch.phase == UITouchPhaseCancelled || touch.phase == UITouchPhaseEnded) {
        // Remove representation
        [touch.touchRepresentationView removeFromSuperview];
    }
    else if (touch.phase == UITouchPhaseMoved) {
        [touch centerRepresentation];
    }
}


#pragma mark Touch View
- (UIView *)getViewForTouchRepresentation {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[IonDemoUIWindow imageForTouchRepresentation]];
    imageView.contentMode = UIViewContentModeRedraw;
    return imageView;
}

+ (UIImage *)imageForTouchRepresentation {
    static UIImage* imageForTouch;
    static dispatch_once_t imageForTouch_onceToken;
    
    dispatch_once( &imageForTouch_onceToken, ^{
        imageForTouch = [UIImage imageNamed: @"IonTouchRepresentation.png" ];
    });
    
    return imageForTouch;
}

@end

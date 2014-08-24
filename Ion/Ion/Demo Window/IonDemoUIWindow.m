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

@implementation IonDemoUIWindow


/**
 * This intercepts all touch events and sends them to the processing function.
 * @returns {void}
 */
- (void)sendEvent:(UIEvent *)event {
    [super sendEvent:event];
    
    if (event.type == UIEventTypeTouches) {
        for (UITouch *touch in [event allTouches]) {
            [self processTouchEvent:touch];
        }
    }
}

/**
 * This processes a touch event, and renders a view depending on the state of the touch.
 * @returns {void}
 */
- (void) processTouchEvent:(UITouch*)touch {
    if (touch.phase == UITouchPhaseBegan) {
        touch.touchRepresentationView = [self getViewForTouchReprsentation];
        
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

/**
 * This gets the view used for touch.
 * @returns {UIView*}
 */
- (UIView*) getViewForTouchReprsentation {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[IonDemoUIWindow imageForTouchRepresentation]];
    
    // Configure
    imageView.contentMode = UIViewContentModeRedraw;
    
    return imageView;
}


/**
 * This returns the singleton of the image that will be used for touch point representation.
 * @returns {UIImage*}
 */
+ (id)imageForTouchRepresentation {
    static UIImage* imageForTouch = nil;
    @synchronized(self) {
        if (imageForTouch == nil)
            imageForTouch = [UIImage imageNamed:@"IonTouchRepresentation.png"];
    }
    return imageForTouch;
}

@end

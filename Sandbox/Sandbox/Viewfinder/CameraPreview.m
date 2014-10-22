//
//  CameraPreview.m
//  Sandbox
//
//  Created by Andrew Hurst on 10/20/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "CameraPreview.h"

@interface CameraPreview ()

#pragma mark Simulator
/**
 * Animates the view between two colors because there is no camera to display.
 */
- (void) simulatorCameraLoop;

@end

@implementation CameraPreview

- (void) construct {
    [self simulatorCameraLoop];
}

#pragma mark Simulator
- (void) simulatorCameraLoop {
    __block void (^secondFrame)(void); __block void (^firstFrame)(void);
    NSTimeInterval animationDuration = 1.5;
    self.styleCanSetBackground = FALSE;
    
    
    // Setup Frames
    firstFrame = ^{
        [UIView animateWithDuration: animationDuration animations: ^{
            self.backgroundColor = UIColorFromRGB( 0xBCBDBF );
        } completion: ^(BOOL finished) {
            if ( finished )
                secondFrame();
        }];
    };
    secondFrame = ^{
        [UIView animateWithDuration: animationDuration animations: ^{
            self.backgroundColor = UIColorFromRGB( 0xECEDEE );
        } completion: ^(BOOL finished) {
            if ( finished )
                firstFrame();
        }];
    };
    
    // Start Loop
    firstFrame();
}

@end

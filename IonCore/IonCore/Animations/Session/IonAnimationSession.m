//
//  IonTransformAnimationMap.m
//  Ion
//
//  Created by Andrew Hurst on 8/12/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonAnimationSession.h"
#import "IonAnimationFrame.h"
#import <IonData/IonData.h>
#import "IonAnimationMap.h"

@implementation IonAnimationSession

#pragma mark Constructors
/**
 * Constructs the session with the specified view.
 * @param {UIView*} the view to construct with.  
 */
- (instancetype) initWithView:(UIView *)view {
    self = [super init];
    if ( self )
        _view = view;
    return self;
}

#pragma mark Execution
/**
 * Starts the animation at the entry points frame.
 * @param {NSString*} the name of the entry point frame.
 * @param {void(^)( )} the completion to be called at the end of the animation.
 */
- (void) startAtEntryPoint:(NSString *)entryPoint usingCompletion:(void(^)( )) completion {
    IonAnimationFrame* frame;
    if ( !entryPoint || ![entryPoint isKindOfClass: [NSString class]] )
        entryPoint = @"start"; // Set to default

    // Get the frame for the specified key.
    frame = [self.animationMap frameForKey: entryPoint];
    if ( !frame ) {
        NSLog( @"@s - Could not find frame for entry point %@, aborting animation.", entryPoint );
        return;
    }
    
    // Execute the frame on our view.
    [frame executeTransformationOn: self.view
                   withCompletion: ^( NSString *nextTarget ) {
                       // Check if we have finished.
                        if ( !nextTarget || ![nextTarget isKindOfClass: [NSString class]] ) {
                           if ( completion )
                               completion( );
                           return;
                       }
                                    
                       // Call the next frame recursivly.
                       [self startAtEntryPoint: nextTarget usingCompletion: completion];
                   }];
}

/**
 * Starts the sesion at the inputted entry point.
 * @param {NSString*} the frames' name which to start the animation at.
 */
- (void) startAtEntryPoint:(NSString *)entryPoint {
    [self startAtEntryPoint: entryPoint usingCompletion: NULL];
}

@end

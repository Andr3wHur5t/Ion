//
//  IonViewController.m
//  Ion
//
//  Created by Andrew Hurst on 7/13/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonViewController.h"
#import <IonData/IonData.h>
#import "IonApplication.h"
#import "IonViewMotionGestureManager.h"

@interface IonViewController () {
    CGRect oldFrame;
    
    /** Gesture Manager */
    IonViewMotionGestureManager* _viewMotionGestureManager;
}

/**
 * The gesture manager.
 */
@property (strong, nonatomic) IonViewMotionGestureManager* viewMotionGestureManager;

@end

@implementation IonViewController
#pragma mark Constructors

/**
 * The default constructor.
 * @returns {instancetype}
 */
- (instancetype)init {
    self = [super init];
    if (self) {
        oldFrame = CGRectUndefined;
        [self setDefaultThemeSystemNames];
    }
    return self;
}

#pragma mark View
/**
 * Overrides the view setter to only allow IonViews.
 * @param {IonView*} the new view.
 * @returns {void}
 */
- (void) setView:(IonView *)view {
    NSParameterAssert( view && [view isKindOfClass: [IonView class]] );
    if ( !view || ![view isKindOfClass: [IonView class]])
        return;
    
    super.view = view;
}

/**
 * Gets the current view, and forces it as a IonView.
 * @returns {IonView} the view
 */
- (IonView*) view {
    return (IonView*)super.view;
}

#pragma mark Motion Delegation

/**
 * Gets the current view motion manager, or constructs if if it doesn't exist.
 * @returns {IonViewMotionManager}
 */
- (IonViewMotionGestureManager*) viewMotionGestureManager {
    if ( !_viewMotionGestureManager )
        _viewMotionGestureManager = [[IonViewMotionGestureManager alloc] init];
    return _viewMotionGestureManager;
}

#pragma mark Delegation

/**
 * Adds the delegate to the correct manager
 * @param {id} the delegate to add.
 * @returns {void}
 */
- (void) addDelegateToManager:(id) delegate {
    NSParameterAssert( delegate );
    if ( !delegate )
        return;
    
    if ( [delegate conformsToProtocol: @protocol(IonViewMotionGestureDelegate)] )
        [self.viewMotionGestureManager addGestureDelegate: delegate];
}

/**
 * Removes the delegate from its manager.
 * @param {id} the delegate to add.
 * @returns {void}
 */
- (void) removeDelegateFromManager:(id) delegate {
    NSParameterAssert( delegate );
    if ( !delegate )
        return;
    
    if ( [delegate conformsToProtocol: @protocol(IonViewMotionGestureDelegate)] )
        [self.viewMotionGestureManager removeGestureDelegate: delegate];
}

#pragma mark Ion Controller Interface

/**
 * We layout views here.
 * @returns {void}
 */
- (void) shouldLayoutSubviews {
    NSLog(@"Layout");
}

/** Memory Management */

/**
 * We free non-critical objects here.
 * @returns {void}
 */
- (void) shouldFreeNonCriticalObjects {
    NSLog(@"Free Non-Critical Elements");
}

/**
 * We construct the subviews here.
 * @returns {void}
 */
- (void) constructViews {
    NSLog(@"Construct Views");
}

/**
 * Informs the controller that we are about to free the view.
 */
- (void) willFreeView {
    NSLog(@"Will Free View");
}

/** State Restoration */

/**
 * We encode the temporary state here.
 * @param {NSCoder} the object to encode our state with.
 * @returns {void}
 */
- (void) encodeTemporaryState:(NSCoder*) encoder {
    NSLog(@"Encode State");
}

/**
 * We decode the temporary state here.
 * @param {NSCoder} the object to decode our state with.
 * @returns {void}
 */
- (void) decodeTemporaryState:(NSCoder*) decoder {
    NSLog(@"Decode State");
}


#pragma mark Theme Utilities

/**
 * Sets the default value for the views' element, class, and id names.
 * @returns {void}
 */
- (void) setDefaultThemeSystemNames {
    self.view.themeElement = sIonThemeElementBody;
}

/**
 * Sets our view to the current system theme invoking internal system theme set.
 * @retruns {void}
 */
- (void) setViewThemeToSystem {
    IonApplication* appReference = [IonApplication sharedApplication];
    if ( !appReference )
        return;
    
    [self.view setIonTheme: appReference.window.systemTheme];
}

#pragma mark Standard Interface

/**
 * Prepare for being added to the view hierarchy.
 * @return {void}
 */
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    // Call to prepare the view controller for presentation.
    [self setViewThemeToSystem];
}

/**
 * Invokes our construction functions.
 * @return {void}
 */
- (void) loadView {
    CGRect frame;
    self.view =  [[IonView alloc] init];
    
    if ( [IonApplication sharedApplication].window )
        frame = [IonApplication sharedApplication].window.frame;
    
    self.view.frame = frame;
    [self constructViews];
}

/**
 * Invokes Layout management. 
 * This is called whenever the bounds of the view change.
 */
- (void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    // Call if there has been a frame change
    if ( !CGRectEqualToRect(oldFrame, self.view.frame ) )
        [self shouldLayoutSubviews];
    
    oldFrame = self.view.frame;
}

/**
 * Invoke memory management functions.
 * @return {void}
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self shouldFreeNonCriticalObjects];
    if ( [self.view window] == nil ) {
        [self willFreeView];
        self.view = nil;
    }
}

#pragma mark Motion Delegate Interface

/**
 * Enable the reciveing of motion events.
 */
- (BOOL) canBecomeFirstResponder {
    return TRUE;
}

/**
 * Reports motion began to the motion manager
 */
- (void) motionBegan:(UIEventSubtype) motion withEvent:(UIEvent *) event {
    [self.viewMotionGestureManager motionBegan: motion withEvent: event];
}

/**
 * Reports motion canceled to the motion manager
 */
- (void) motionCancelled:(UIEventSubtype) motion withEvent:(UIEvent *) event {
    [self.viewMotionGestureManager motionCancelled: motion withEvent: event];
}

/**
 * Reports motion ended to the motion manager
 */
- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    [self.viewMotionGestureManager motionEnded: motion withEvent: event];
}

#pragma mark State Restoration

/** TODO: provide a state restoration ID.*/

/**
 * Decodes a state restoration coder, and invokes processing methods.
 * @param {NSCoder*} the coder to decode from.
 * @retutns {void}
 */
- (void) decodeRestorableStateWithCoder:(NSCoder *)coder {
    // To-Do our decoding.
    [self decodeTemporaryState: coder];
}

/**
 * Encodes a state restoration coder, and invokes further encoding methods.
 * @param {NSCoder*} the coder to encode to.
 * @retutns {void}
 */
- (void) encodeWithCoder:(NSCoder*) aCoder {
    // To-Do our encoding.
    [self encodeTemporaryState: aCoder];
}
@end

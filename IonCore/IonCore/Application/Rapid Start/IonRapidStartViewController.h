//
//  IonRapidStartViewController.h
//  Ion
//
//  Created by Andrew Hurst on 6/26/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IonRapidStartViewController : UIViewController

/**
 * Sets the post appear callback which will be called after the view appears.
 # @return {void}
 */
- (void) setPostAppearCallback:(void(^)()) callback;

/**
 * Sets the finished dispatching callback which will be called after the view removes itself from root.
 # @return {void}
 */
- (void) setFinishedDispatchingCallback:(void(^)()) callback;

/**
 * Called when the manager tells us its time to dispatch from the view.
 * @param {UIViewController*} the controller we will be dispatching to.  
 */
- (void) prepareToDispatchWithNewController:(UIViewController *)vc;


#pragma mark public internal Interface

/**
 * Records if we are ready for automatic transition. (default is yes)
 */
@property (assign, nonatomic) bool readyForViewToDispatchToFRVC;

/**
 * Transmissions to the next root view controller if it has been loaded.
 * @return {bool} true if successful, otherwise false.
 */
- (bool) goToNextRootViewControllerIfReady;
@end




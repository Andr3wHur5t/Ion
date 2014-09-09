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
 * this sets the post appear callback which will be called after the view appears.
 # @returns {void}
 */
- (void) setPostAppearCallback:(void(^)()) callback;

/**
 * this sets the finished dispatching callback which will be called after the view removes itself from root.
 # @returns {void}
 */
- (void) setFinishedDispatchingCallback:(void(^)()) callback;

/**
 * This is called when the manager tells us its time to dispatch from the view.
 * @param {UIViewController*} the controller we will be dispatching to.
 * @returns {void}
 */
- (void) prepareToDispatchWithNewController:(UIViewController *)vc;


#pragma mark public internial Interface

// This records if we are ready for automatic transision. (default is yes)
@property (assign, nonatomic) bool readyForViewToDispatchToFRVC;

/**
 * This will Transision to the next root view controller if it has been loaded.
 * @returns {bool} true if successfull, else it failed.
 */
- (bool) goToNextRootViewControllerIfReady;
@end




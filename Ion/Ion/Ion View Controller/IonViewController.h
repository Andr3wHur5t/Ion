//
//  IonViewController.h
//  Ion
//
//  Created by Andrew Hurst on 7/13/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IonView.h" // load all extensions used in Ion View to extend the view controller.

@interface IonViewController : UIViewController

@property (strong, nonatomic) IonView* view;

/**
 * We layout views here.
 * @returns {void}
 */
- (void) shouldLayoutSubviews;

/** Memory Management */

/**
 * We free non-critical objects here.
 * @returns {void}
 */
- (void) shouldFreeNonCriticalObjects;

/**
 * We construct the subviews here.
 * @returns {void}
 */
- (void) constructViews;

/**
 * Informs the controller that we are about to free the view.
 */
- (void) willFreeView;

/** State Restoration */

/**
 * We encode the temporary state here.
 * @param {NSCoder} the object to encode our state with.
 * @returns {void}
 */
- (void) encodeTemporaryState:(NSCoder*) encoder;

/**
 * We decode the temporary state here.
 * @param {NSCoder} the object to decode our state with.
 * @returns {void}
 */
- (void) decodeTemporaryState:(NSCoder*) decoder;

#pragma mark Delegation

/**
 * Adds the delegate to the correct manager
 * @param {id} the delegate to add.
 * @returns {void}
 */
- (void) addDelegateToManager:(id) delegate;

/**
 * Removes the delegate from its manager.
 * @param {id} the delegate to add.
 * @returns {void}
 */
- (void) removeDelegateFromManager:(id) delegate;
@end

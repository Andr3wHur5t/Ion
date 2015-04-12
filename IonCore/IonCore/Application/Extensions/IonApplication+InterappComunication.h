//
//  IonApplication+InterappComunication.h
//  IonCore
//
//  Created by Andrew Hurst on 10/14/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <IonCore/IonApplication.h>

@class IACRouter;
@class IACLink;

@interface IonApplication (InterappComunication)

/**
 * Our application router, which all application communication should go
 * through.
 */
@property(nonatomic, readonly) IACRouter *router;

#pragma mark Controller Utilities

/**
 * Opens the provided view controller with the inputted sender link.
 * @param controller - the controller to transition to.
 * @param link - the link that was used to open the controller.
 */
- (void)openViewController:(UIViewController *)controller
                  withLink:(IACLink *)link;

@end

@interface UIViewController (IACLinkInvokation)
/**
 * The controllers router.
 */
@property(strong, nonatomic, readwrite) IACRouter *router;

/**
 * Informs the controller that it is about to be opened with the specified link.
 * @param link - the link that the controller will open with.
 */
- (BOOL)willOpenWithLink:(IACLink *)link;

/**
 * Informs the controller that it will be closed because of the specified link.
 * @param link - the link that caused the controller to be closed.
 */
- (BOOL)willCloseWithLink:(IACLink *)link;

/**
 * Informs the controller that it has been opened with the specified link.
 * @param link - the link that caused the controller to be opened.
 */
- (void)didOpenWithLink:(IACLink *)link;

/**
 * Informs the controller that it was closed because of the specified link.
 * @param link - the link that caused the link to be opened.
 */
- (void)didCloseWithLink:(IACLink *)link;

@end

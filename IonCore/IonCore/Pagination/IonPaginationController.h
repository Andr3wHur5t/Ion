//
//  IonPaginationController.h
//  IonCore
//
//  Created by Andrew Hurst on 10/20/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <IonCore/IonScrollView.h>
#import <IonCore/IonViewController.h>

@protocol IonPaginationControllerDelegate <NSObject>

/**
 * Gets invoked when we change pages to another index.
 */
- (void) didNavigateToPageAtIndex:(NSUInteger) index;

@end


@interface IonPaginationController : IonScrollView

/**
 * Constructs with the specified mode.
 * @param mode - true if horizontal, or false if vertical.
 */
- (instancetype) initWithHorizontalMode:(BOOL) mode;

#pragma mark Configuration
/**
 * States if the current configuration is horizontal, or vertical.
 */
@property (assign, nonatomic, readonly) BOOL isHorizontal;

/**
 * Our Change Delegate.
 */
@property (weak, nonatomic, readwrite) id<IonPaginationControllerDelegate> delegate;

#pragma mark Page Management
/**
 * Our array of registered page names.
 */
@property (strong, nonatomic, readonly) NSMutableArray *pageNames;

/**
 * Our array of page controllers
 */
@property (strong, nonatomic, readonly) NSMutableArray *pages;

/**
 * Adds the inputted view controller with the specified name.
 * @param pageController - the view controller representing the page.
 * @param name - the name of the controller to be used in referencing.
 */
- (void) addPage:(IonViewController *)page withName:(NSString *)name;

/**
 * Removes the page with the specified name.
 * @param name - the name of the controller to remove.
 */
- (void) removePageWithName:(NSString *)name;

#pragma mark Navigation

- (void) navigateToPageWithName:(NSString *)name animated:(BOOL) animated;
/**
 * Goes to the page with the specified name.
 * @param name - the name of the controller to navigate to.
 */
- (void) navigateToPageWithName:(NSString *)name;

- (void) navigateToPageAtIndex:(NSUInteger) index animated:(BOOL) animated;

/**
 * Goes to the page at the specified index.
 * @param index - the page index to navigate to.
 */
- (void) navigateToPageAtIndex:(NSUInteger) index;
@end

//
//  IonPaginationController.h
//  IonCore
//
//  Created by Andrew Hurst on 10/20/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <IonCore/IonScrollView.h>
#import <IonCore/IonViewController.h>

@class IonGuideLine;
@class IACRouter;
@class IACLink;

@protocol IonPaginationControllerDelegate <NSObject>

/*!
 @brief Invoked when the pagination view changes its' current index.
 
 @param index The new index.
 */
- (void)didNavigateToPageAtIndex:(NSUInteger)index;

@optional

/*!
 @brief Invoked when a subcontrollers' router was invoked as an endpoint before the subcontroller is notified.
 
 @param link The link that opened the subcontroller.
 */
- (void)willOpenSubControllerWithLink:(IACLink *)link;


/*!
 @brief Invoked when a subcontrollers' router was invoked as an endpoint after the subcontroller is notified.
 
 @param link The link that opened the subcontroller.
 */
- (void)didOpenSubControllerWithLink:(IACLink *)link;

@end

@interface IonPaginationController : IonScrollView <UIScrollViewDelegate>

/**
 * Constructs with the specified mode.
 * @param mode - true if horizontal, or false if vertical.
 */
- (instancetype)initWithHorizontalMode:(BOOL)mode;

/*!
 @brief  Initializes a pagination controller with the inputted router.

 @param router The router to be used as the parent router for children
 controllers.
 @param mode   The mode specifying if the pages should be presented in vertical
 or horizontal mode.

 @return The initialized controller.
 */
- (instancetype)initWithRouter:(IACRouter *)router andHorizontalMode:(BOOL)mode;

/*!
 @brief  Initializes a pagination controller with the inputted router.

 @param router The router to be used as the parent router for children
 controllers.

 @return The initialized controller.
 */
- (instancetype)initWithRouter:(IACRouter *)router;

#pragma mark Configuration
/*!
 @brief  States if the current configuration is horizontal, or vertical.
 */
@property(assign, nonatomic, readonly) BOOL isHorizontal;

/*!
 @brief Our index update delegate.
 */
@property(weak, nonatomic, readwrite)
    id<IonPaginationControllerDelegate> pageDelegate;

/*!
 @brief The router used as the parrent router for all sub controllers.

 @discussion This can be a parent controllers' router, thus allowing invokation
 from that parrent.
 */
@property(strong, nonatomic, readonly) IACRouter *router;

/*!
 @brief The current index that the page is on.
 */
@property(assign, nonatomic, readonly) NSUInteger currentIndex;

#pragma mark Page Management
/*!
 @brief Gets the index of the object with the specified name.

 @param name The name to get the index for.

 @return The index of the object with the specified name.
 */
- (NSUInteger)indexOfName:(NSString *)name;

/*!
 @brief An array of the controllers currently registered names.
 */
@property(strong, nonatomic, readonly) NSMutableArray *pageNames;

/*!
 @brief An array of registered controller identifiers used by this controller.
 */
@property(strong, nonatomic, readonly) NSMutableArray *pages;

/*!
 @brief  Adds a page to the controller.

 @discussion Contrurcts the controller when needed using the inputted controller
 class.

 @param controllerClass The class used to construct the controller.
 @param name            The string used to refrence the class.
 */
- (void)addPageControllerClass:(Class)controllerClass withName:(NSString *)name;

#pragma mark Navigation

/*!
 @brief Navigates the controllers view to expose the page with the inputted
 identifier.

 @param name     The page identifier that you wish to navigate to.
 @param animated States if the transision is animated or not.
 */
- (void)navigateToPageWithName:(NSString *)name animated:(BOOL)animated;

/*!
 @brief Navigates to the controller with the specified identifier animated.

 @param name The identifier o the page you want to navigate to.
 */
- (void)navigateToPageWithName:(NSString *)name;

/*!
 @brief Navigates to the page at the specified index.

 @param index    The index you want to transision to.
 @param animated States if the transision is animatied or not.
 */
- (void)navigateToPageAtIndex:(NSUInteger)index animated:(BOOL)animated;

/*!
 @brief Navigates to the page at the specified index animated.

 @param index  The index you want to transision to.
 */
- (void)navigateToPageAtIndex:(NSUInteger)index;

#pragma mark Start

/*!
 @brief Marks the start of pagination usage.

 @discussion This seeds the loading process of the controller. It constructs,
 and loads the page with the specified name.

 @param name The name of the page to start with.
 */
- (void)startAtPageWithName:(NSString *)name;

/*!
 @brief  Marks the start of pagination usage.

 @discussion This seeds the loading process of the controller. It constructs,
 and loads the page with the specified index. Then after first presentation
 starts loading the next controller.

 @param index The index of the controller to start with.
 */
- (void)startAtIndex:(NSUInteger)index;

#pragma mark Guides
/*!
 @brief Guide representing our page count.
 */
@property(strong, nonatomic, readonly) IonGuideLine *pageCountGuide;

/*!
 @brief Guide representing what the content width should be if we are in
 horizontal mode.
 */
@property(strong, nonatomic, readonly) IonGuideLine *contentWidthGuide;

/*!
 @brief Guide representing the current page in realtime.

 @discussion This could be used to make a scroll indicator, it updates in
 realtime the position within the content size. while being restricted to the
 size of the view.
 */
@property(strong, nonatomic, readonly) IonGuideLine *scrollGuide;

/*!
 @brief Guide representing the content offset within the size of the view.
 */
@property(strong, nonatomic, readonly) IonGuideLine *pagePosition;

@end

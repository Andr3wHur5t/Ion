//
//  IonTableView.h
//  IonCore
//
//  Created by Andrew Hurst on 11/9/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//
#import "IonScrollView.h"

@class FODataModel;
@class IonCell;


@protocol IonTableViewDelegate <NSObject>
@optional
/*!
 @brief Gets invoked when the user taps the cell.
 
 @param cell The cell the user tapped
 */
- (void)didTapCell:(IonCell *)cell;

@end

@interface IonTableView : IonScrollView
#pragma mark Delegate
/*!
 @brief The table delegate.
 */
@property (strong, nonatomic, readwrite) id<IonTableViewDelegate> tableDelegate;

#pragma mark Data Model
/*!
 @brief The tabel views data model.
 */
@property (strong, nonatomic, readwrite) FODataModel *dataModel;

#pragma mark Cell Bindings
/*!
 @brief Binds a data model class to a cell class.
 
 @param dataModelClass The data model class to bind.
 @param cellClass The cell class to be used for the data model class.
 */
- (void)bindDataClass:(Class)dataModelClass toCellClass:(Class)cellClass;

/*!
 @brief Removes binding to the specified data model class.
 
 @param dataModelClass The data model class to remove bindings for.
 */
- (void)removeBindingForDataClass:(Class)dataModelClass;

/*!
 @brief Removes all data model, and cell bindings.
 */
- (void)removeAllCellBindings;

@end

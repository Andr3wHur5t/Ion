//
//  FODataModel.h
//  IonCore
//
//  Created by Andrew Hurst on 11/9/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol FODataModelDelegate <NSObject>
@optional
/*!
 @brief Gets invoked when the data model appends data.
 
 @param data The data that was appended.
 */
- (void)didAddData:(id) data;

/*!
 @brief Gets invoked when the data was inserted.
 
 @param data  The data that was inserted.
 @param index The index the data was inserted at.
 */
- (void)didInsertData:(id)data atIndex:(NSUInteger) index;

/*!
 @brief Gets invoked when the data model replaces data.
 
 @param data  The new data.
 @param index The index that the data was replaced at.
 */
- (void)didReplaceData:(id)data atIndex:(NSUInteger) index;

/*!
 @brief Gets invoked when the data model removes data.
 
 @param index The index the data was removed at.
 */
- (void)didRemoveDataAtIndex:(NSUInteger) index;

/*!
 @brief Gets invoked when the data model removes all data.
 */
- (void)didRemoveAllData;

@end


@interface FODataModel : NSObject
/*!
 @brief Array of all of the data models data.
 */
@property (weak, nonatomic, readonly) NSArray *data;

/*!
 @brief Number of indexes in the data model.
 */
@property ( nonatomic, readonly) NSUInteger count;

/*!
 @brief The data models delegate;
 */
@property (weak, nonatomic, readwrite) id<FODataModelDelegate> delegate;

#pragma mark Data Manipulation
/*!
 @brief Appends current data with inputted data.

 @param data The data to add to the data model.
 */
- (void)addData:(id)data;

/*!
 @brief Inserts the data at the inputted index, and shifts the data currently at the inputted index up
 
 @param data  The data to insert
 @param index The index to insert the data at.
 */
- (void)insertData:(id)data atIndex:(NSUInteger) index;

/*!
 @brief Replaces the data at the inputted index with the inputted data.
 
 @param data  The data to replace with.
 @param index The index to replace the data at.
 */
- (void)replaceData:(id)data atIndex:(NSUInteger) index;

/*!
 @brief Removes the data at the specified index.
 
 @param index The index to remove the data from.
 */
- (void)removeDataAtIndex:(NSUInteger) index;

/*!
 @brief Removes all data from the data model.
 */
- (void)removeAllData;

@end




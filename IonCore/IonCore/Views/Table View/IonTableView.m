//
//  IonTableView.m
//  IonCore
//
//  Created by Andrew Hurst on 11/9/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "IonTableView.h"
#import <IonCore/IonCore.h>

@interface IonTableView () <FODataModelDelegate>

#pragma mark Cell Management
/*!
 @brief Index of the top cells' data model.
 */
@property(assign, nonatomic, readwrite) NSUInteger topCellIndex;

/*!
 @brief Index of the bottom cells' data model.
 */
@property(assign, nonatomic, readwrite) NSUInteger bottomCellIndex;

/*!
 @brief An array of active Cells.
 */
@property(strong, nonatomic, readonly) NSMutableArray *activeCells;

/*!
 @brief Converts a data model index into an active cell index.

 @param index The data mode index to convert.

 @return the active index, or NSUIntegerMax if out of bounds.
 */
- (NSUInteger)activeIndexFromIndex:(NSUInteger)index;

#pragma mark Bindings
/*!
 @brief Our dictionary of data model, and cell bindings.
 */
@property(strong, nonatomic, readonly) NSMutableDictionary *dataBindings;

/*!
 @brief Gets the registered cell class for the specified data class.

 @param dataClass The data model class to get the cell class from.

 @return The correct cell class.
 */
- (Class)cellClassForDataClass:(Class)dataClass;

@end

@implementation IonTableView

@synthesize dataBindings = _dataBindings;
@synthesize activeCells = _activeCells;

#pragma mark Construct

- (instancetype)init {
  self = [super init];
  if (self)
    [self iConstruct];
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self)
    [self iConstruct];
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self)
    [self iConstruct];
  return self;
}

// Internal Construction
- (void)iConstruct {
  self.themeElement = @"tableView";
  self.forceScrollVert = TRUE;
}

#pragma mark Scroll View Interface

- (void)setContentOffset:(CGPoint)contentOffset {
  [super setContentOffset:contentOffset];

  // ANDREW, Uncomment this to add cell streaming
  /*if ( [self firstCellHasPassedRemoveThreshold] ) {
    // Remove the current first cell
    [self unbindCell: [self.activeCells firstObject]];
    [self.activeCells removeObjectAtIndex: 0];

    self.topCellIndex += 1;
  } else if ( [self firstCellHasPassedAddThreshold] && self.topCellIndex != 0 )
  {
    // Add the cell before the current first cell

    self.topCellIndex -= 1;
  }
  if ( [self lastCellHasPassedRemoveThreshold] ) {
    // Remove the current last cell
    [self unbindCell: [self.activeCells lastObject]];
    [self.activeCells removeLastObject];

    self.bottomCellIndex -= 1;
  }
  else if ( [self lastCellHasPassedAddThreshold]
           && self.bottomCellIndex < self.dataModel.count ) {
    // Add the cell after the current last cell

    self.bottomCellIndex += 1;
  }
  NSLog( @"Table %@,%@", @(self.topCellIndex), @(self.bottomCellIndex) );*/
}

- (CGFloat)topThreshold {
  return (CGFloat)self.contentOffset.y + self.frame.size.height * -0.5f;
}

- (CGFloat)bottomThreshold {
  return (CGFloat)self.contentOffset.y + self.frame.size.height * 1.5f;
}

- (BOOL)firstCellHasPassedRemoveThreshold {
  IonCell *firstCell = [self.activeCells firstObject];
  if ([firstCell isKindOfClass:[IonCell class]])
    return firstCell.frame.origin.y + firstCell.frame.size.height <
           [self topThreshold];
  else
    return FALSE;
}

- (BOOL)firstCellHasPassedAddThreshold {
  IonCell *firstCell = [self.activeCells firstObject];
  if ([firstCell isKindOfClass:[IonCell class]])
    return firstCell.frame.origin.y < [self topThreshold];
  else
    return FALSE;
}

- (BOOL)lastCellHasPassedRemoveThreshold {
  IonCell *lastCell = [self.activeCells lastObject];
  if ([lastCell isKindOfClass:[IonCell class]])
    return lastCell.frame.origin.y > [self bottomThreshold];
  else
    return FALSE;
}

- (BOOL)lastCellHasPassedAddThreshold {
  IonCell *lastCell = [self.activeCells lastObject];
  if ([lastCell isKindOfClass:[IonCell class]])
    return lastCell.frame.origin.y + lastCell.frame.size.height >
           [self bottomThreshold];
  else
    return FALSE;
}

#pragma mark Cell Reuse

- (void)unbindCell:(IonCell *)cell {
  NSString *dataModelClassString;
  if (![cell isKindOfClass:[IonCell class]])
    return;

  // Remove it
  [cell removeFromSuperview];

  // Get data model class string
  for (NSString *key in self.dataBindings.allKeys)
    if ([[self.dataBindings objectForKey:key]
            isEqualToString:NSStringFromClass([cell class])])
      dataModelClassString = key;

  // Unbind it
  [cell unbindFromDataModel];

  // Regster the cell using the data
  if ([dataModelClassString isKindOfClass:[NSString class]])
    ; // Add To reuse dictionary
}

- (IonCell *)cellForDataModel:(id)dataModel {
  NSString *dataModelClassString;
  IonCell *cell;
  Class cellClass;
  if (!dataModel)
    return NULL;

  if (dataModel)
    dataModelClassString = NSStringFromClass([dataModel class]);

  // Get from Reuse Dictionary
  if ([dataModelClassString isKindOfClass:[NSString class]])
    cell = NULL;

  // None Avalable Create one
  if (!cell) {
    cellClass = [self cellClassForDataClass:[dataModel class]];
    if (!cellClass)
      return NULL; // No registered cell for data model class

    // Construct cell
    cell = [[cellClass alloc] init];
    [cell.tapGestureRecognizer addTarget: self action: @selector(cellWasTapped:)];
  } else {
    // Unregister if for reuse.
    if ([dataModelClassString isKindOfClass:[NSString class]])
      ;
  }

  // Bind the cell to its data model
  if ([cell isKindOfClass:[IonCell class]])
    [cell bindToDataModel:dataModel];
  return cell;
}

#pragma mark Active Cells

- (NSMutableArray *)activeCells {
  if (!_activeCells)
    _activeCells = [[NSMutableArray alloc] init];
  return _activeCells;
}

- (void)addActiveCellFromDataIndex:(NSUInteger)index
                     toActiveIndex:(NSUInteger)activeIndex {
  id dataModel;
  IonCell *cell;

  if (self.dataModel.count > index)
    dataModel = [self.dataModel.data objectAtIndex:index];
  if (dataModel)
    cell = [self cellForDataModel:dataModel];

  // ANDREW YOU LEFT OFF HERE, you need to make it so that this adds to the
  // correct active index as well as making sure that the first cell orgin is
  // correct.
}

#pragma mark Cell Management
- (void)configureCellAtActiveIndex:(NSUInteger)index {
  IonGuideLine *topGuide;
  IonCell *currentCell;

  if (self.activeCells.count > index)
    currentCell = [self.activeCells objectAtIndex:index];
  if (self.activeCells.count > index - 1)
    topGuide =
        ((IonCell *)[self.activeCells objectAtIndex:index - 1]).bottomMargin;

  if (!topGuide)
    topGuide = self.topAutoPadding;

  // Position, And Size Cell
  [currentCell setGuidesWithLocalHoriz:currentCell.originGuideHoriz
                             localVert:currentCell.originGuideVert
                            superHoriz:self.leftAutoPadding
                             superVert:*&topGuide
                                  left:self.leftAutoPadding
                                 right:self.rightAutoPadding
                                   top:[@0 toGuideLine]
                             andBottom:currentCell.preferredHeightGuide];
}

- (void)addCellWithData:(id)data atIndex:(NSUInteger)index {
  IonCell *cellAtIndex, *nextCell;
  NSUInteger activeIndex = [self activeIndexFromIndex:index];
  if (activeIndex == NSUIntegerMax)
    return;

  if (activeIndex < self.activeCells.count)
    cellAtIndex = [self.activeCells objectAtIndex:index];

  if (activeIndex + 1 < self.activeCells.count)
    nextCell = [self.activeCells objectAtIndex:index + 1];

  // Remove Current Cell.
  if ([cellAtIndex isKindOfClass:[IonCell class]]) {
    [self unbindCell:cellAtIndex];
    cellAtIndex = NULL;
  }

  // ANDREW, Uncomment the if statement to enable cell streaming
  // Incrment if we have not passed our threshold
  // if ( ![self lastCellHasPassedRemoveThreshold] )
  self.bottomCellIndex += 1;

  // Get New Cell
  cellAtIndex = [self cellForDataModel:data];
  [self addSubview:cellAtIndex];
  if (self.activeCells.count >= activeIndex)
    [self.activeCells setObject:cellAtIndex atIndexedSubscript:activeIndex];

  // Configure next and previous cells.
  [self configureCellAtActiveIndex:activeIndex];
  if ([nextCell isKindOfClass:[IonCell class]])
    [self configureCellAtActiveIndex:activeIndex + 1];

  // Set content size
  self.contentSizeVert =
      ((IonCell *)[self.activeCells lastObject]).bottomMargin;
}

- (void)replaceCellWithData:(id)data atIndex:(NSUInteger)index {
  NSUInteger activeIndex = [self activeIndexFromIndex:index];
  if (activeIndex == NSUIntegerMax)
    return;

  // TODO: This
}

- (void)removeCellAtIndex:(NSUInteger)index {
  NSUInteger activeIndex = [self activeIndexFromIndex:index];
  if (activeIndex == NSUIntegerMax)
    return;

  // TODO: This
}

- (NSUInteger)activeIndexFromIndex:(NSUInteger)index {
  if (self.bottomCellIndex != 0 &&
      (index > self.bottomCellIndex || index <= self.topCellIndex))
    return NSUIntegerMax;
  return index - self.topCellIndex;
}

#pragma mark Data Model Interface

+ (BOOL)automaticallyNotifiesObserversOfDataModel {
  return FALSE;
}

- (void)setDataModel:(FODataModel *)dataModel {
  [self willChangeValueForKey:@"dataModel"];
  _dataModel = dataModel;
  [self didChangeValueForKey:@"dataModel"];

  if (![_dataModel isKindOfClass:[FODataModel class]])
    return;
  _dataModel.delegate = self;

  // Add Initial Data
  for (id data in _dataModel.data)
    [self didAddData:data];
}

- (void)didAddData:(id)data {
  if (self.dataModel.count >= self.bottomCellIndex || self.dataModel.count == 0)
    [self addCellWithData:data atIndex:self.dataModel.count - 1];
}

- (void)didInsertData:(id)data atIndex:(NSUInteger)index {
  if (index >= self.topCellIndex && index <= self.bottomCellIndex)
    [self addCellWithData:data atIndex:index];
}

- (void)didReplaceData:(id)data atIndex:(NSUInteger)index {
  if (index >= self.topCellIndex && index <= self.bottomCellIndex)
    [self replaceCellWithData:data atIndex:index];
}

- (void)didRemoveDataAtIndex:(NSUInteger)index {
  if (index >= self.topCellIndex && index <= self.bottomCellIndex)
    [self removeCellAtIndex:index];
}

- (void)didRemoveAllData {
  for (NSUInteger i = self.topCellIndex; i <= self.bottomCellIndex; ++i)
    [self removeCellAtIndex:i];
}

#pragma mark Cell Bindings

- (NSMutableDictionary *)dataBindings {
  if (!_dataBindings)
    _dataBindings = [[NSMutableDictionary alloc] init];
  return _dataBindings;
}

- (void)bindDataClass:(Class)dataModelClass toCellClass:(Class)cellClass {
  NSString *dataClassString, *cellClassString;
  NSParameterAssert(dataModelClass);
  NSParameterAssert(cellClass);
  if (!dataModelClass || !cellClass)
    return;

  dataClassString = NSStringFromClass(dataModelClass);
  if (![dataClassString isKindOfClass:[NSString class]]) {
    NSAssert(
        true,
        @"Failed to retrieve class string from inputted data model class.");
    return;
  }

  if (![cellClass isSubclassOfClass:[IonCell class]]) {
    NSAssert(true, @"Cell class must be a subclass of IonCell.");
    return;
  }

  cellClassString = NSStringFromClass(cellClass);
  if (![dataClassString isKindOfClass:[NSString class]]) {
    NSAssert(true,
             @"Failed to retrieve class string from inputted cell class.");
    return;
  }

  [self.dataBindings setObject:cellClassString
             forKeyedSubscript:dataClassString];
}

- (void)removeBindingForDataClass:(Class)dataModelClass {
  NSString *classString;
  NSParameterAssert(dataModelClass);
  if (!dataModelClass)
    return;

  classString = NSStringFromClass(dataModelClass);
  if (![classString isKindOfClass:[NSString class]]) {
    NSAssert(true, @"Failed to retrieve class string from inputted class.");
    return;
  }

  [self.dataBindings removeObjectForKey:classString];
}

- (void)removeAllCellBindings {
  [self.dataBindings removeAllObjects];
}

- (Class)cellClassForDataClass:(Class)dataClass {
  NSString *dataClassString, *cellClassString;
  NSParameterAssert(dataClass);
  if (!dataClass)
    return NULL;

  dataClassString = NSStringFromClass(dataClass);
  if (![dataClassString isKindOfClass:[NSString class]]) {
    NSAssert(
        true,
        @"Failed to retrieve class string from inputted data model class.");
    return NULL;
  }

  cellClassString = [self.dataBindings objectForKey:dataClassString];
  if (![cellClassString isKindOfClass:[NSString class]])
    return NULL;

  return NSClassFromString(cellClassString);
}

#pragma mark Delegate Methods

- (void)cellWasTapped:(UITapGestureRecognizer *)sender {
  if ([sender.view isKindOfClass:[IonCell class]] &&
      [self.tableDelegate respondsToSelector:@selector(didTapCell:)])
    [self.tableDelegate didTapCell:(IonCell *)sender.view];
}

@end

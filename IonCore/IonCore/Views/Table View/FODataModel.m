//
//  FODataModel.m
//  IonCore
//
//  Created by Andrew Hurst on 11/9/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "FODataModel.h"

@interface FODataModel ()

/*!
 @brief Array of our internal data.
 */
@property(strong, readonly) NSMutableArray *iData;

@end

@implementation FODataModel

@synthesize iData = _iData;

#pragma mark Data

- (NSMutableArray *)iData {
  if (!_iData) _iData = [[NSMutableArray alloc] init];
  return _iData;
}

- (NSUInteger)count {
  return self.iData.count;
}

- (NSArray *)data {
  // TODO: Check memory efficiency
  return self.iData;
}

#pragma mark Data Manipulation

- (void)addData:(id)data {
  NSParameterAssert(data);
  if (!data) return;

  [self.iData addObject:data];
  if ([self.delegate respondsToSelector:@selector(didAddData:)])
    [self.delegate didAddData:data];
}

- (void)insertData:(id)data atIndex:(NSUInteger)index {
  NSParameterAssert(data);
  if (!data) return;

  if (self.iData.count < index) {
    [self addData:data];
    return;
  }

  [self.iData insertObject:data atIndex:index];

  __block id sData = data;
  //  dispatch_async(dispatch_get_main_queue(), ^{
  if ([self.delegate respondsToSelector:@selector(didInsertData:atIndex:)])
    [self.delegate didInsertData:sData atIndex:index];
  //  });
}

- (void)replaceData:(id)data atIndex:(NSUInteger)index {
  NSParameterAssert(data);
  if (!data) return;

  if (self.iData.count < index) {
    [self addData:data];
    return;
  }

  [self.iData setObject:data atIndexedSubscript:index];

  __block id sData = data;
  //  dispatch_async(dispatch_get_main_queue(), ^{
  if ([self.delegate respondsToSelector:@selector(didReplaceData:atIndex:)])
    [self.delegate didReplaceData:sData atIndex:index];
  //  });
}

- (void)removeDataAtIndex:(NSUInteger)index {
  if (self.iData.count < index) return;

  [self.iData removeObjectAtIndex:index];

  __block NSUInteger sIndex = index;
  //  dispatch_async(dispatch_get_main_queue(), ^{
  if ([self.delegate respondsToSelector:@selector(didRemoveDataAtIndex:)])
    [self.delegate didRemoveDataAtIndex:sIndex];
  //  });
}

- (void)removeAllData {
  [self.iData removeAllObjects];
  //  dispatch_async(dispatch_get_main_queue(), ^{
  if ([self.delegate respondsToSelector:@selector(didRemoveAllData)])
    [self.delegate didRemoveAllData];
  //  });
}

@end

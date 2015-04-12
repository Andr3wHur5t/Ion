//
//  TVPCellOne.m
//  TableViewProto
//
//  Created by Andrew Hurst on 12/8/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "TVPCellOne.h"
#import "TVPDataOne.h"

@implementation TVPCellOne

- (void)bindToDataModel:(id)dataModel {
  if ( [dataModel isKindOfClass:[TVPDataOne class]] )
    self.themeClass = ((TVPDataOne *)dataModel).cls;
}

@end

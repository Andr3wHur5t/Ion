//
//  TVPDataOne.m
//  TableViewProto
//
//  Created by Andrew Hurst on 12/8/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "TVPDataOne.h"

@implementation TVPDataOne
- (instancetype)initWithCls:(NSString *)cls {
  self = [super init];
  if ( self )
    _cls = cls;
  return self;
}
@end

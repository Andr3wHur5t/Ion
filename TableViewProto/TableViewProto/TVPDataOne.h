//
//  TVPDataOne.h
//  TableViewProto
//
//  Created by Andrew Hurst on 12/8/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TVPDataOne : NSObject
-(instancetype) initWithCls:(NSString *)cls;
@property (strong, nonatomic, readonly) NSString *cls;
@end

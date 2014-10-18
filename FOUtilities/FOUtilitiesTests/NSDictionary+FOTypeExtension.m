//
//  NSDictionary+FOTypeExtension.m
//  FOUtilities
//
//  Created by Andrew Hurst on 10/10/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSDictionary+FOTypeExtension.h"

@interface NSDictionary_FOTypeExtension : XCTestCase

@end

@implementation NSDictionary_FOTypeExtension

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


#pragma mark Dictionary Overwrite

- (void)testDictionaryOverwrite {
    NSDictionary *expected, *result;
    
    
    expected =  @{@"Override":@1,
                  @"Extra":@2,
                  @"stay":@5,
                  @"arr":@[
                          @1,
                          @2,
                          ],
                  @"Thing":@{
                          @"Me":@"hi",
                          }
                  };
    
    result = [@{@"Override":@0,
                @"stay":@5,
                @"arr":@[
                        @3,
                        @2,
                        ],
                @"Thing":@{
                        @"Me":@"NO",
                        @"You":@"Oh No!"
                        }
                } overriddenByDictionary:@{@"Override":@1,
                                           @"Extra":@2,
                                           @"arr":@[
                                                   @1,
                                                   @2,
                                                   ],
                                           @"Thing":@{
                                                   @"Me":@"hi",
                                                   }
                                           }];
    
    XCTAssert( [expected isEqualToDictionary: result] , @"Invalid result.");
}

- (void)testDictionaryRecursiveOverwrite {
    NSDictionary *expected, *result;
    
    
    expected =  @{@"Override":@1,
                  @"Extra":@2,
                  @"stay":@5,
                  @"arr":@[
                          @3,
                          @5
                          ],
                  @"Thing":@{
                          @"Me":@"hi",
                          @"you":@4,
                          @"yo":@2
                          }
                  };
    
    result = [@{@"Override":@0,
                @"stay":@5,
                @"arr":@[
                        @1,
                        @2
                        ],
                @"Thing":@{
                        @"you":@4,
                        @"yo":@6
                        }
                } overriddenByDictionaryRecursively: @{@"Override":@1,
                                                       @"Extra":@2,
                                                       @"arr":@[
                                                               @3,
                                                               @5
                                                               ],
                                                       @"Thing":@{
                                                               @"Me":@"hi",
                                                               @"yo":@2
                                                               }
                                                       }];
    NSLog(@"(fdsfdf)res:%@", result);
    
    XCTAssert( [expected isEqualToDictionary: result] , @"Invalid result.");
}

@end

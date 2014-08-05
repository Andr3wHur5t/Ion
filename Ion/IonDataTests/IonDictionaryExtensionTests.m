//
//  IonDictionaryExtensionTests.m
//  Ion
//
//  Created by Andrew Hurst on 8/3/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSDictionary+IonTypeExtension.h"

@interface IonDictionaryExtensionTests : XCTestCase

@end

@implementation IonDictionaryExtensionTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark Dictionary Overwrite

/**
 * Checks Shallow overwrite
 */
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


/**
 * Checks Recursive overwrite
 */
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
    NSLog(@"(fdsfdf)res:%@ exp:%@", result, expected);
    
    XCTAssert( [expected isEqualToDictionary: result] , @"Invalid result.");
}

@end

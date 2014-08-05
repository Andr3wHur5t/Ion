//
//  IonNSArrayExtensionTests.m
//  Ion
//
//  Created by Andrew Hurst on 8/3/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSArray+IonExtension.h"

@interface IonNSArrayExtensionTests : XCTestCase

@end

@implementation IonNSArrayExtensionTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


#pragma mark Overwriting

/**
 * Tests Recursive Overwrite
 */
- (void)testRecursiveOverwrite {
    NSArray *expected, *result;

    expected = @[ @[@1,@{@"yo":@"ho",@"me":@"my"},@3,@4], @{@"Hi":@"no",@"smell":@"oh",@"stay":@"show"} , @2, @6, @5 ];
    result = [@[ @[@1,@{@"me":@"my"},@3,@4], @{@"Hi":@"Hello",@"stay":@"show"} , @2, @6, @5 ] overwriteRecursivelyWithArray:@[ @[@1,@{@"yo":@"ho"},@3,@4], @{@"Hi":@"no",@"smell":@"oh"} , @2, @6, @5 ]];
    XCTAssert( [expected isEqualToArray: result] , @"Invalid Output");
}


@end

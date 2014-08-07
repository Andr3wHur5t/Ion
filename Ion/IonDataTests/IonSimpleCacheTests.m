//
//  IonSimpleCacheTests.m
//  Ion
//
//  Created by Andrew Hurst on 8/5/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "IonSimpleCache.h"

#define TestFileName @"test-this.thing"
#define TestFileContent @"Why Hello there good sir!"

@interface IonSimpleCacheTests : XCTestCase {
    IonSimpleCache* simpleCache;
}

@end

@implementation IonSimpleCacheTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    simpleCache = [IonSimpleCache cacheWithName:@"Test Cache"];
}

- (void)tearDown {
    simpleCache = NULL;
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

/**
 * This test a cache remove all, by adding an item, opening it to confirm it is valid, then deleting it, and atempting to open it again.
 */
- (void)testCacheRemoveAllObjects {
    __block id result;
    __weak IonSimpleCache* weakCache;
    __block XCTestExpectation* completionException;
    
    weakCache = simpleCache;
    result = @"hello!";
    completionException = [self expectationWithDescription:@"Delete Complete"];
    
    [simpleCache setObject: TestFileContent forKey:TestFileName withCompletion: ^(NSError *error) {
        [weakCache objectForKey: TestFileName withResultBlock: ^(id object) {
            [weakCache removeAllObjects:^(NSError *error) {
                [weakCache objectForKey: TestFileName withResultBlock: ^(id object) {
                    result = object;
                    [completionException fulfill];
                }];
            }];
        }];
    }];
    
    [self waitForExpectationsWithTimeout: 1 handler: ^(NSError *error) {
        XCTAssert( !result, @"The file still exsists!");
    }];
}

/**
 * Test the reading and weiteing of a file
 */
- (void) testFileReadWrite {
    __block NSString* result;
    __weak IonSimpleCache* weakCache;
    __block XCTestExpectation* completionException;
    
    weakCache = simpleCache;
    result = @"hello!";
    completionException = [self expectationWithDescription:@"Delete Complete"];
    
    [simpleCache setObject: TestFileContent forKey:TestFileName withCompletion: ^(NSError *error) {
        [weakCache objectForKey: TestFileName withResultBlock: ^(id object) {
            [weakCache removeAllObjects:^(NSError *error) {
                [weakCache objectForKey: TestFileName withResultBlock: ^(id object) {
                    result = object;
                    [completionException fulfill];
                }];
            }];
        }];
    }];
    
    [self waitForExpectationsWithTimeout: 1 handler: ^(NSError *error) {
        XCTAssert( [result isEqualToString: TestFileContent], @"The file still exsists!");
    }];

}



@end

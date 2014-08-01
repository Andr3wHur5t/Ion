//
//  IonAdaptedMutableDictionaryTests.m
//  Ion
//
//  Created by Andrew Hurst on 8/1/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "IonMutableDictionary.h"

@interface IonAdaptedMutableDictionaryTests : XCTestCase {
    IonMutableDictionary* target;
}

@end

@implementation IonAdaptedMutableDictionaryTests

- (void)setUp {
    [super setUp];
    
    target = [[IonMutableDictionary alloc] initWithDictionary: @{
                                                                 @"test":@"Hello",
                                                                 @"me":@{
                                                                         @"there":@"here"
                                                                         },
                                                                 @"you":@3.0
                                                                 }];
}

- (void)tearDown {
    target = NULL;
    [super tearDown];
}

/**
 * Test object retrieval
 */
- (void)testObjectRetrieval {
    __block NSString *result, *expected;
    XCTestExpectation *objectOpenExpectation = [self expectationWithDescription:@"document open"];
   
    
    expected = @"Hello";
    [target objectForKey: @"test" withResultBlock:^(id object) {
        if ( !object || ![object isKindOfClass: [NSString class]] )
            return;
        
        result = object;
        [objectOpenExpectation fulfill];
    }];
    
    
    [self waitForExpectationsWithTimeout:1 handler:^(NSError *error) {
        XCTAssert( [result isEqualToString: expected], @"Unexpected Output.");
    }];
    
}

/**
 * Test Object Placement, by placing an object and getting it.
 */
- (void)testObjectPlacement {
    __block IonMutableDictionary* blockTarget;
    __block NSString *result, *expected, *key;
    XCTestExpectation *objectOpenExpectation = [self expectationWithDescription:@"document open"];
    
    blockTarget = target;
    expected = @"Win";
    key = @"thatThingHere";
    
    
    [target setObject: expected forKey: key withCompletion:^(NSError *error) {
        [blockTarget objectForKey: key withResultBlock:^(id object) {
            if ( !object || ![object isKindOfClass: [NSString class]] )
                return;
            
            result = object;
            [objectOpenExpectation fulfill];
        }];
    }];
    

    
    
    [self waitForExpectationsWithTimeout:1 handler:^(NSError *error) {
        XCTAssert( [result isEqualToString: expected], @"Unexpected Output.");
    }];
    
}

/**
 * Test object removal by checking if the removed value still exsists.
 */
- (void)testObjectRemoval {
    __block IonMutableDictionary* blockTarget;
    __block NSString *result, *key;
    XCTestExpectation *objectOpenExpectation = [self expectationWithDescription:@"document open"];
    
    blockTarget = target;
    key = @"test";
    
    
    [target removeObjectForKey: key withCompletion:^(NSError *error) {
        [blockTarget objectForKey: key withResultBlock:^(id object) {
            result = object;
            [objectOpenExpectation fulfill];
        }];
    }];
    
    
    
    
    [self waitForExpectationsWithTimeout:1 handler:^(NSError *error) {
        XCTAssert( !result, @"Object Still Exsists.");
    }];
}

/**
 * Test all object removal
 */
- (void)testAllObjectRemoval {
    XCTestExpectation *objectOpenExpectation = [self expectationWithDescription:@"document open"];
    
    
    [target removeAllObjects:^(NSError *error) {
        [objectOpenExpectation fulfill];
    }];
    
    
    
    
    [self waitForExpectationsWithTimeout:1 handler:^(NSError *error) {
        XCTAssert( [target keyCount] == 0  , @"Still Keys.");
    }];
}


@end

//
//  FOTargetActionListTests.m
//  FOUtilities
//
//  Created by Andrew Hurst on 10/7/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FOTargetActionList.h"
#import "FOTargetActionSet.h"

@interface FOTargetActionListTests : XCTestCase {
  FOTargetActionList *targetActionList;
}

@end

@implementation FOTargetActionListTests

- (void)setUp {
  [super setUp];
  // Put setup code here. This method is called before the invocation of each
  // test method in the class.
  targetActionList = [[FOTargetActionList alloc] init];
}

- (void)tearDown {
  // Put teardown code here. This method is called after the invocation of each
  // test method in the class.
  targetActionList = NULL;
  [super tearDown];
}

#pragma mark inline Tests

- (void)testAdd {
  XCTestExpectation *finished =
      [self expectationWithDescription:@"document open"];
  [targetActionList addTarget:self
                    andAction:@selector(selectorOne:)
                      toGroup:@"a"];
  [targetActionList invokeActionSetsInGroup:@"a" withObject:finished];

  [self waitForExpectationsWithTimeout:1
                               handler:^(NSError *error) { XCTAssert(true); }];
}

- (void)testRemove {
  [targetActionList addTarget:self
                    andAction:@selector(selectorOne:)
                      toGroup:@"a"];
  [targetActionList removeTarget:self
                       andAction:@selector(selectorOne:)
                       fromGroup:@"a"];
  [targetActionList invokeActionSetsInGroup:@"a"];
}

- (void)testRemoveAll {
  [targetActionList addTarget:self
                    andAction:@selector(selectorOne:)
                      toGroup:@"a"];
  [targetActionList removeAllGroups];
  [targetActionList invokeActionSetsInGroup:@"a"];
}

#pragma mark Multithread Tests

- (void)testMultithreadAdd {
  XCTestExpectation *finished =
      [self expectationWithDescription:@"document open"];
  [targetActionList addTarget:self
                    andAction:@selector(selectorOne:)
                      toGroup:@"a"];
  [targetActionList invokeActionSetsInGroup:@"a" withObject:finished];

  [self waitForExpectationsWithTimeout:1
                               handler:^(NSError *error) { XCTAssert(true); }];
}

- (void)testMultithreadAddExsisting {
}

- (void)testMultiThreadRemove {
}

- (void)testMultiThreadRemoveAll {
}

- (void)testMultiThreadInvoke {
}

#pragma mark Test Selectiors

- (void)selectorOne:(XCTestExpectation *)response {
  [response fulfill];
}

- (void)selectiorTwo:(XCTestExpectation *)response {
  [response fulfill];
}

@end

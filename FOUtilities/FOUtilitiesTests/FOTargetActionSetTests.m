//
//  FOTargetActionSetTests.m
//  FOUtilities
//
//  Created by Andrew Hurst on 10/7/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FOTargetActionSet.h"

@interface FOTargetActionSetTests : XCTestCase

@end

@implementation FOTargetActionSetTests


- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark Construction Tests

- (void)testConstruction {
    FOTargetActionSet *testSet;
    
    testSet = [[FOTargetActionSet alloc] initWithTarget: self andAction: @selector(SelectorTest)];
    
    XCTAssert([testSet.target isEqual: self] && testSet.action == @selector(SelectorTest) , @"Pass");
}

- (void)testConstructionNegitive {
    FOTargetActionSet *testSet;
    testSet = [[FOTargetActionSet alloc] initWithTarget: self andAction: @selector(SelectorTest)];
    
    XCTAssert(!(![testSet.target isEqual: self] && testSet.action != @selector(SelectorTest)) , @"Pass");
}

#pragma mark Targeting Tests

- (void)testValid {
    FOTargetActionSet *testSet;
    testSet = [[FOTargetActionSet alloc] initWithTarget: self andAction: @selector(SelectorTest)];
    
    XCTAssert(testSet.isValid , @"Pass");
}

- (void)testValidNegitive {
    FOTargetActionSet *testSet;
    testSet = [[FOTargetActionSet alloc] init];
    
    XCTAssert(!testSet.isValid , @"Pass");
}

- (void)testEquality {
    FOTargetActionSet *oneTestSet, *twoTestSet;
    oneTestSet = twoTestSet = [[FOTargetActionSet alloc] initWithTarget: self
                                                               andAction: @selector(SelectorTest)];
    
    XCTAssert([oneTestSet isEqual: twoTestSet], @"Pass");
}

- (void)testRawEquality {
    FOTargetActionSet *oneTestSet;
    oneTestSet = [[FOTargetActionSet alloc] initWithTarget: self andAction: @selector(SelectorTest)];
    
    XCTAssert([oneTestSet isEqualToTarget: self andAction: @selector(SelectorTest)], @"Pass");
}


- (void)testRawEqualityNegitive {
    FOTargetActionSet *oneTestSet;
    oneTestSet = [[FOTargetActionSet alloc] initWithTarget: self andAction: @selector(SelectorTest)];
    
    XCTAssert(![oneTestSet isEqualToTarget: NULL andAction: NULL], @"Pass");
}

- (void)testRawEqualityNoSelectorNegitive {
    FOTargetActionSet *oneTestSet;
    oneTestSet = [[FOTargetActionSet alloc] initWithTarget: self andAction: @selector(SelectorTest)];
    
    XCTAssert(![oneTestSet isEqualToTarget: self andAction: NULL], @"Pass");
}

- (void)testRawEqualityNoTargetNegitive {
    FOTargetActionSet *oneTestSet;
    oneTestSet = [[FOTargetActionSet alloc] initWithTarget: self andAction: @selector(SelectorTest)];
    
    XCTAssert(![oneTestSet isEqualToTarget: NULL andAction: @selector(SelectorTest)], @"Pass");
}


- (void)testRawEqualityInvalidTargetNegitive {
    FOTargetActionSet *oneTestSet;
    oneTestSet = [[FOTargetActionSet alloc] initWithTarget: self andAction: @selector(SelectorTest)];
    
    XCTAssert(![oneTestSet isEqualToTarget: [[NSObject alloc] init] andAction: @selector(SelectorTest)], @"Pass");
}

- (void)testRawEqualityInvalidSelectorNegitive {
    FOTargetActionSet *oneTestSet;
    oneTestSet = [[FOTargetActionSet alloc] initWithTarget: self andAction: @selector(SelectorTest)];
    
    XCTAssert(![oneTestSet isEqualToTarget: self andAction: @selector(SelectorIncorrect)], @"Pass");
}


#pragma mark Dummy Targets
- (void) SelectorTest {
    
}

- (void) SelectorIncorrect {
    
}


@end

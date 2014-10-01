//
//  IonTargetActionSetTests.m
//  Ion
//
//  Created by Andrew Hurst on 10/1/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonTargetActionSet.h"
#import <XCTest/XCTest.h>

@interface IonTargetActionSetTests : XCTestCase

@end

@implementation IonTargetActionSetTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testConstruction {
    IonTargetActionSet *testSet;
    
    testSet = [[IonTargetActionSet alloc] initWithTarget: self andAction: @selector(SelectorTest)];
    
    XCTAssert([testSet.target isEqual: self] && testSet.action == @selector(SelectorTest) , @"Pass");
}

- (void)testConstructionNegitive {
    IonTargetActionSet *testSet;
    testSet = [[IonTargetActionSet alloc] initWithTarget: self andAction: @selector(SelectorTest)];
    
    XCTAssert(!(![testSet.target isEqual: self] && testSet.action != @selector(SelectorTest)) , @"Pass");
}

- (void)testValid {
    IonTargetActionSet *testSet;
    testSet = [[IonTargetActionSet alloc] initWithTarget: self andAction: @selector(SelectorTest)];
    
    XCTAssert(testSet.isValid , @"Pass");
}

- (void)testValidNegitive {
    IonTargetActionSet *testSet;
    testSet = [[IonTargetActionSet alloc] init];
    
    XCTAssert(!testSet.isValid , @"Pass");
}

- (void)testEquality {
    IonTargetActionSet *oneTestSet, *twoTestSet;
    oneTestSet = twoTestSet = [[IonTargetActionSet alloc] initWithTarget: self
                                                               andAction: @selector(SelectorTest)];
    
    XCTAssert([oneTestSet isEqual: twoTestSet], @"Pass");
}

- (void)testRawEquality {
    IonTargetActionSet *oneTestSet;
    oneTestSet = [[IonTargetActionSet alloc] initWithTarget: self andAction: @selector(SelectorTest)];
    
    XCTAssert([oneTestSet isEqualToTarget: self andAction: @selector(SelectorTest)], @"Pass");
}


- (void)testRawEqualityNegitive {
    IonTargetActionSet *oneTestSet;
    oneTestSet = [[IonTargetActionSet alloc] initWithTarget: self andAction: @selector(SelectorTest)];
    
    XCTAssert(![oneTestSet isEqualToTarget: NULL andAction: NULL], @"Pass");
}

- (void)testRawEqualityNoSelectorNegitive {
    IonTargetActionSet *oneTestSet;
    oneTestSet = [[IonTargetActionSet alloc] initWithTarget: self andAction: @selector(SelectorTest)];
    
    XCTAssert(![oneTestSet isEqualToTarget: self andAction: NULL], @"Pass");
}

- (void)testRawEqualityNoTargetNegitive {
    IonTargetActionSet *oneTestSet;
    oneTestSet = [[IonTargetActionSet alloc] initWithTarget: self andAction: @selector(SelectorTest)];
    
    XCTAssert(![oneTestSet isEqualToTarget: NULL andAction: @selector(SelectorTest)], @"Pass");
}


- (void)testRawEqualityInvalidTargetNegitive {
    IonTargetActionSet *oneTestSet;
    oneTestSet = [[IonTargetActionSet alloc] initWithTarget: self andAction: @selector(SelectorTest)];
    
    XCTAssert(![oneTestSet isEqualToTarget: [[NSObject alloc] init] andAction: @selector(SelectorTest)], @"Pass");
}

- (void)testRawEqualityInvalidSelectorNegitive {
    IonTargetActionSet *oneTestSet;
    oneTestSet = [[IonTargetActionSet alloc] initWithTarget: self andAction: @selector(SelectorTest)];
    
    XCTAssert(![oneTestSet isEqualToTarget: self andAction: @selector(SelectorIncorrect)], @"Pass");
}

- (void) SelectorTest {
    
}

- (void) SelectorIncorrect {
    
}

@end

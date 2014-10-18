//
//  PHDataTests.m
//  PHDataTests
//
//  Created by Andrew Hurst on 10/7/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PHName.h"

@interface PHNameTests : XCTestCase

@end

@implementation PHNameTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark Name Components
- (void)testRandomFirstName {
    // only checks if it can return
    XCTAssert( [PHName randomFirstName], @"Pass");
}

- (void)testRandomMasculineFirstName {
    // only checks if it can return
    XCTAssert( [PHName randomMasculineFirstName], @"Pass");
}

- (void)testRandomFeminineFirstName {
    // only checks if it can return
    XCTAssert( [PHName randomFeminineName], @"Pass");
}

- (void)testRandomLastName {
    // only checks if it can return
    XCTAssert( [PHName randomLastName], @"Pass");
}

#pragma mark Genteration
- (void)testRandomGeneratedName {
    // only checks if it can return
    XCTAssert( [PHName randomName] , @"Pass");
}

- (void)testRandomGeneratedMasculineName {
    // only checks if it can return
    XCTAssert( [PHName randomMasculineName] , @"Pass");
}

- (void)testRandomGeneratedFeminineName {
    // only checks if it can return
    XCTAssert( [PHName randomFeminineName] , @"Pass");
}

#pragma mark Composite Methods

- (void)testCompositeWithDefaultOptions {
    
}

@end

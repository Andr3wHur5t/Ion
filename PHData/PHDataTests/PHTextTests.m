//
//  PHTextTests.m
//  PHData
//
//  Created by Andrew Hurst on 10/7/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PHText.h"

@interface PHTextTests : XCTestCase

@end

@implementation PHTextTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testLourumSmall {
    NSAssert([[PHText loremWithWordCount: 5] componentsSeparatedByString:@" "].count == 5, @"Pass");
}

- (void)testLourumLarge {
    // Checking 51 because there is an extra string in the split.
    XCTAssert( [[PHText loremWithWordCount: 50] componentsSeparatedByString:@" "].count == 51, @"Pass");
}

@end

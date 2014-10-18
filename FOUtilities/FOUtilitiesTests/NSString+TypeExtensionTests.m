//
//  NSString+TypeExtensionTests.m
//  FOUtilities
//
//  Created by Andrew Hurst on 10/9/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+FOTypeExtension.h"

@interface NSString_TypeExtensionTests : XCTestCase

@end

@implementation NSString_TypeExtensionTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


#pragma mark Color Hex
/**
 * Test Hex Validator with 8value
 */
- (void)testHexValidation8ValueHex{
    XCTAssert( [@"#F2393B99" IsValidHex], @"Incorrect result");
}

/**
 * Test Hex Validator with 8value
 */
- (void)testHexValidation6ValueHex{
    XCTAssert( [@"#F2393B" IsValidHex], @"Incorrect result");
}

/**
 * Test Hex Validator with 8value
 */
- (void)testHexValidation4ValueHex{
    XCTAssert( [@"#FFFF" IsValidHex], @"Incorrect result");
}

/**
 * Test Hex Validator with 8value
 */
- (void)testHexValidation3ValueHex{
    XCTAssert( [@"#000" IsValidHex], @"Incorrect result");
}

@end

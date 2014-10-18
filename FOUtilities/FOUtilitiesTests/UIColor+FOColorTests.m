//
//  UIColor+FOColorTests.m
//  FOUtilities
//
//  Created by Andrew Hurst on 10/9/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIColor+FOColor.h"

@interface UIColor_FOColorTests : XCTestCase

@end

@implementation UIColor_FOColorTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

/**
 * This checks if geting a hex string matches the actual objects hex.
 */
- (void)testColorToHexEncoding{
    UIColor* testColor = UIColorFromRGB(0x39B54A);
    NSString *expectedResult = @"#39B54AFF".uppercaseString;
    
    NSString *testResult = [testColor toHex].uppercaseString;
    
    XCTAssert([testResult isEqualToString: expectedResult],@"Color To Hex String Got:%@ Wanted:%@",testResult,expectedResult);
}

/**
 * This checks if seting a color via a hex string sets the object correctly.
 */
- (void) testHexToColor {
    UIColor* testColor = [UIColor colorFromHexString:@"#39B54A"];
    UIColor* expectedColor = UIColorFromRGB(0x39B54A);
    
    XCTAssert( [[testColor toHex] isEqualToString: [expectedColor toHex]], @"Hex To Color");
}

/**
 * Tests 8 Value Color Encodeing
 */
- (void)testColorTo8ValueHex{
    UIColor* testColor = [UIColorFromRGB(0x39B54A) colorWithAlphaComponent: 0.6];
    NSString *expectedResult = @"#39B54A99".uppercaseString;
    
    NSString *testResult = [testColor toHex].uppercaseString;
    
    XCTAssert([testResult isEqualToString: expectedResult],@"Color To Hex String Got:%@ Wanted:%@",testResult,expectedResult);
}

/**
 * Tests 8 Value Color Decodeing
 */
- (void)testColorFrom8ValueHex{
    UIColor* testColor = [UIColor colorFromHexString:@"#F2393B99"];
    UIColor* expectedColor = [UIColorFromRGB(0xF2393B) colorWithAlphaComponent: 0.6];
    
    XCTAssert( [[testColor toHex] isEqualToString: [expectedColor toHex]], @"Hex To Color");
}

@end

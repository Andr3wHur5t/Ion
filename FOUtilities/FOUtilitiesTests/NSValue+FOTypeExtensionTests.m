//
//  NSValue+FOTypeExtensionTests.m
//  FOUtilities
//
//  Created by Andrew Hurst on 10/10/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSValue+FOTypeExtension.h"

@interface NSValue_FOTypeExtensionTests : XCTestCase

@end

@implementation NSValue_FOTypeExtensionTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCGFloatConversion {
    NSValue* valObj;
    CGFloat valIn, valOut;
    valIn = 2;
    
    valObj = [NSValue valueWithFloat: valIn];
    valOut = [valObj toFloat];
    
    XCTAssert( valIn == valOut, @"Pass");
}

@end

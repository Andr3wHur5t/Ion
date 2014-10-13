//
//  NSData+FOTypeExtensionTests.m
//  FOUtilities
//
//  Created by Andrew Hurst on 10/10/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSData+FOTypeExtension.h"

@interface NSData_FOTypeExtensionTests : XCTestCase {
    NSData *targetData;
}
@end

@implementation NSData_FOTypeExtensionTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    targetData = NULL;
    [super tearDown];
}


/**
 * Tests data and string conversion by encoding and decoding the data and checking the result.
 */
- (void) testDataStringConversion {
    NSString *result, *expected;
    
    expected = @"Hi There :)";
    targetData = [NSData dataFromString: expected];
    result = [targetData toString];
    
    XCTAssert( [expected isEqualToString: result] , @"Conversion output incorrect.");
}

/**
 * Tests data to JSON dictionary conversions by encoding and decoding the data.
 */
- (void) testDataToJSONDictionary {
    NSDictionary *result, *expected;
    
    
    expected = @{
                 @"test":@"Hello",
                 @"me":@{
                         @"there":@"here"
                         },
                 @"you":@3.0
                 };
    targetData = [NSData dataFromJsonEncodedDictionary: expected makePretty: TRUE];
    result = [targetData toJsonDictionary];
    
    XCTAssert( [expected isEqualToDictionary: result] , @"Conversion output incorrect.");
}

@end

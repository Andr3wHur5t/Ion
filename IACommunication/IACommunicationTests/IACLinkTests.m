//
//  IACLinkTests.m
//  IACommunication
//
//  Created by Andrew Hurst on 10/7/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "IACLink.h"


static NSString *testPath = @"ion:///main/home/?test=yes&there=0";
static NSString *testReason = @"Because";

@interface IACLinkTests : XCTestCase {
    IACLink *link;
}

@end

@implementation IACLinkTests

- (void)setUp {
    [super setUp];
    link = [[IACLink alloc] initWithURLString: testPath andReason: testReason];
}

- (void)tearDown {
    link = NULL;
    [super tearDown];
}

#pragma mark Construction Tests

- (void)testConstruction {
    // Test that construction works (constructed in setup)
    XCTAssert( link && [[link reason] isEqualToString: testReason], @"Pass");
}

- (void)testLinkWithoutFirstComponent {
    IACLink *otherLink;
    otherLink = [link linkWithoutFirstComponent];
    
    XCTAssert( otherLink.pathComponents.count == 1, @"Pass");
}


#pragma mark Utilities Test

- (void)testURLFromArray {
    NSArray *inputs;
    NSString *expected;
    inputs = @[ @"thing", @"stuff"];
    expected = @"iac:///thing/stuff/";
    
    XCTAssert( [[IACLink urlStringFromComponents: inputs] isEqualToString: expected] , @"Pass");
}

- (void)testURLFromString {
    NSString *input, *expected;
    input = @"/thing/stuff/";
    expected = @"iac:///thing/stuff/";
    XCTAssert( [[IACLink urlStringFromPath: input] isEqualToString: expected] , @"Pass");
}

- (void)testURLDecoding {
  NSString *input, *expected;
  input = @"tipmonkey:///history?item=356&ref=blockparty%3A%2F%2F%2Fmain%2Factivity%3Fitem%3D33";
  expected = @"tipmonkey:///history?item=356&ref=blockparty:///main/activity?item=33";

  XCTAssert( [[IACLink decodeURLString: input] isEqualToString: expected] , @"Pass");
}

- (void)testURLEncodedURL {
  NSString *input, *expected;
  IACLink *link;
  input = @"tipmonkey:///history?item=356&ref=blockparty%3A%2F%2F%2Fmain%2Factivity%3Fitem%3D33";
  
  link = [IACLink linkWithURLString:input andReason:@"thing"];
  
//  XCTAssert( [ isEqualToString: expected] , @"Pass");
}

@end

//
//  IonLink.m
//  Ion
//
//  Created by Andrew Hurst on 10/5/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonLink.h"
#import <XCTest/XCTest.h>

static NSString *testPath = @"ion:///main/home/?test=yes&there=0";
static NSString *testReason = @"Because";

@interface IonLinkTests : XCTestCase {
    IonLink *link;
}

@end

@implementation IonLinkTests

- (void)setUp {
    [super setUp];
    link = [[IonLink alloc] initWithURLString: testPath andReason: testReason];
}

- (void)tearDown {
    link = NULL;
    [super tearDown];
}

- (void)testConstruction {
    // Test that construction works (constructed in setup)
    XCTAssert( link && [[link reason] isEqualToString: testReason], @"Pass");
}

- (void)testLinkWithoutFirstComponent {
    IonLink *otherLink;
    otherLink = [link linkWithoutFirstComponent];
    
    XCTAssert( otherLink.pathComponents.count == 1, @"Pass");
}


#pragma mark Utilties

- (void)testURLFromArray {
    NSArray *inputs;
    NSString *expected;
    inputs = @[ @"thing", @"stuff"];
    expected = @"ion:///thing/stuff/";
    
    XCTAssert( [[IonLink urlStringFromComponents: inputs] isEqualToString: expected] , @"Pass");
}

- (void)testURLFromString {
    NSString *input, *expected;
    input = @"/thing/stuff/";
    expected = @"ion:///thing/stuff/";
    XCTAssert( [[IonLink urlStringFromPath: input] isEqualToString: expected] , @"Pass");
}

@end

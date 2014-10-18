//
//  NSString+RegularExpression.m
//  FOUtilities
//
//  Created by Andrew Hurst on 10/9/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+RegularExpression.h"

@interface NSString_RegularExpression : XCTestCase

@end

@implementation NSString_RegularExpression

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark Contains Non White Space Charcters

- (void)testContainsNonWhiteSpaceCharacters{
    NSString* testString = @"  /t/r";
    XCTAssert( ![testString containsNonWhiteSpaceCharacters] , @"Incorrect Output");
}

- (void)testContainsNonWhiteSpaceCharactersEmpty{
    NSString* testString = @"";
    XCTAssert( ![testString containsNonWhiteSpaceCharacters] , @"Incorrect Output");
}

- (void)testContainsNonWhiteSpaceCharactersNegative{
    NSString* testString = @"a";
    XCTAssert( [testString containsNonWhiteSpaceCharacters] , @"Incorrect Output");
}

- (void)testContainsNonWhiteSpaceCharactersNegativeWithChars{
    NSString* testString = @"  a/t";
    XCTAssert( [testString containsNonWhiteSpaceCharacters] , @"Incorrect Output");
}

#pragma mark Conformity Tests

- (void) testStringConformity {
    NSString *testString = @"ag"; // Should conform
    NSRegularExpression* expression = [[NSRegularExpression alloc] initWithPattern: @"[1234567890-]+"
                                                                           options: 0
                                                                             error: NULL];
    XCTAssert( [testString conformsToExpression: expression] , @"Incorrect Output");
}

- (void) testStringConformityNegitive {
    NSString *testString = @"ag-2345"; // Added Symbols shoul not conform
    NSRegularExpression* expression = [[NSRegularExpression alloc] initWithPattern: @"[1234567890-]+"
                                                                           options: 0
                                                                             error: NULL];
    XCTAssert( ![testString conformsToExpression: expression] , @"Incorrect Output");
}

#pragma mark Delete Matches tests

- (void) testDeleteMatches {
    NSString *testString = @"ag"; // Should delete nothing
    NSRegularExpression* expression = [[NSRegularExpression alloc] initWithPattern: @"[1234567890-]+"
                                                                           options: 0
                                                                             error: NULL];
    NSLog(@"Val %@", [testString deleteMatches: expression] );
    XCTAssert( [[testString deleteMatches: expression] isEqualToString: testString] , @"Incorrect Output");
}

- (void) testDeleteMatchesNegitve {
    NSString *testString = @"ag-2345"; // Should delete nothing
    NSRegularExpression* expression = [[NSRegularExpression alloc] initWithPattern: @"[1234567890-]+"
                                                                           options: 0
                                                                             error: NULL];
    XCTAssert( ![[testString deleteMatches: expression] isEqualToString: testString] , @"Incorrect Output");
}


@end

//
//  IonMathTests.m
//  Ion
//
//  Created by Andrew Hurst on 8/1/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "IonMath.h"

@interface IonMathTests : XCTestCase

@end

@implementation IonMathTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark Conversions

/**
 * Checks that we can convert degrees and radians correctly.
 */
- (void)testDegreeAndRadianConversions {
    CGFloat result, expected;
    
    expected = 87.564;
    result = DegreesToRadians( expected );
    result = RadiansToDegrees( result );
    
    
    XCTAssertEqualWithAccuracy( result, expected, 0.001f, @"Output Invalid, Expected %f, got %f", expected, result );
}

#pragma mark Rect Math
/**
 *
 */

#pragma mark Rounding
/**
 * Checks if founded numbers work.
 */
- (void) testRoundedNumers {
    CGFloat expected, input, result;
    
    expected = 1453.3f;
    input = 1453.3453325353;
    result = [IonMath roundNumber: input usingAccuracy: 1];
    
    XCTAssert( expected == result, @"Invalid output, exp:%f res:%f", expected, result );
}

/**
 * Checks if rounded points work.
 */
- (void) testRoundedPoint {
    CGPoint expected, input, result;
    
    expected = (CGPoint){ 10.0, 1.0 };
    input = (CGPoint){ 10.024554, 1.0265768 };
    result = [IonMath roundPoint: input usingAccuracy: 0];
    
    XCTAssert( CGPointEqualToPoint( expected, result ), @"Invalid output, exp:%@ res:%@", NSStringFromCGPoint( expected ), NSStringFromCGPoint( result ) );
}

#pragma mark Point Comparison Utilities

/**
 * Checks if rounded point comparisons work.
 */
- (void) testRoundedPointComparisons {
    CGPoint inputa, inputb;
    
    inputa = (CGPoint){ 10.0245547567657, 1.02657687567657 };
    inputb = (CGPoint){ 10.0245545646645, 1.02657643654767 };
    
    XCTAssert( [IonMath comparePoint: inputa withPoint: inputb], @"Invalid output" );
}

#pragma mark Floating Point Utilities
/**
 * Checks floating point comparason
 */


@end

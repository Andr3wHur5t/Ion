//
//  IonKVPvectorConversionTests.m
//  Ion
//
//  Created by Andrew Hurst on 7/22/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "IonKeyValuePair.h"

@interface IonKVPvectorConversionTests : XCTestCase

@end

@implementation IonKVPvectorConversionTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testToPointConversion {
    CGPoint result;
    NSNumber *x, *y;
    NSDictionary* dict;
    IonKeyValuePair* kvp;
    
    // Set
    x = [[NSNumber alloc] initWithFloat: 2306.2f];
    y = [[NSNumber alloc] initWithFloat: 12552.5f];
    dict = @{ @"x":x, @"y":y };
    kvp = [[IonKeyValuePair alloc] init];
    kvp.value = dict;
    
    // Run
    result = [kvp toPoint];
    
    XCTAssert( CGPointEqualToPoint( result, (CGPoint){ [x floatValue], [y floatValue] } ) , @"Incorect Result");
}


- (void)testToSizeConversion {
    CGSize result;
    NSNumber *x, *y;
    NSDictionary* dict;
    IonKeyValuePair* kvp;
    
    // Set
    x = [[NSNumber alloc] initWithFloat: 2306.2f];
    y = [[NSNumber alloc] initWithFloat: 12552.5f];
    dict = @{ @"width":x, @"height":y };
    kvp = [[IonKeyValuePair alloc] init];
    kvp.value = dict;
    
    // Run
    result = [kvp toSize];
    
    XCTAssert( CGSizeEqualToSize( result, (CGSize){ [x floatValue], [y floatValue] } ) , @"Incorect Result");
}

- (void)testToRectConversion {
    CGRect result;
    NSNumber *x, *y, *width, *height;
    NSDictionary* dict;
    IonKeyValuePair* kvp;
    
    // Set
    x = @25435346.2f;
    y = @344.5f;
    width = @44;
    height = @6256.5f;
    dict = @{ @"width":width, @"height":height, @"x":x, @"y": y };
    kvp = [[IonKeyValuePair alloc] init];
    kvp.value = dict;
    
    // Run
    result = [kvp toRect];
    
    XCTAssert( CGRectEqualToRect( result, (CGRect){ [x floatValue], [y floatValue],
                                            [width floatValue], [height floatValue] } ) , @"Incorect Result");
}




@end

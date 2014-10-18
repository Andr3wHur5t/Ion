//
//  IonStyleTests.m
//  Ion
//
//  Created by Andrew Hurst on 8/1/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "IonStyle.h"
#import "IonStyle+IonStdStyleApplyMethods.h"

@interface IonStyleTests : XCTestCase

@end

@implementation IonStyleTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark Style Inharitance

/**
 * Checks if style overwrrite works.
 */
- (void) testStyleOverrideWorksWithValidData {
    IonStyle *expected, *intermediateOne, *intermedieatTwo, *result;
    
    expected = [[IonStyle alloc] initWithDictionary: @{
                                                       sStyleSTDBackgroundKey: @"Red",
                                                       sStyleSTDCornerRadiusKey: @30,
                                                       sStyleSTDShadowKey:@{
                                                               sShadowColorKey:@"Black",
                                                               sShadowOffsetKey:@{ @"x":@20,@"y":@15 },
                                                               sShadowRadiusKey: @13
                                                               }
                                                       }];
    intermediateOne = [[IonStyle alloc] initWithDictionary: @{
                                                              sStyleSTDBackgroundKey: @"Red",
                                                              sStyleSTDCornerRadiusKey: @10,
                                                              sStyleSTDShadowKey:@{
                                                                      sShadowColorKey:@"Black",
                                                                      sShadowOffsetKey:@{ @"x":@40,@"y":@10 },
                                                                      sShadowRadiusKey: @13
                                                                      }
                                                              }];
    intermedieatTwo = [[IonStyle alloc] initWithDictionary: @{
                                                              sStyleSTDCornerRadiusKey: @30,
                                                              sStyleSTDShadowKey:@{
                                                                      sShadowColorKey:@"Black",
                                                                      sShadowOffsetKey:@{ @"x":@20,@"y":@15 },
                                                                      }
                                                              }];
    result = [intermediateOne overrideStyleWithStyle: intermedieatTwo];
    
    XCTAssert( [expected isEqualToStyle: result] , @"Invalid result.");
}

#pragma mark Style comparison
/**
 * Checks if style comparison works.
 */
- (void)testStyleComparisonValid {
    IonStyle *expected, *result;
    
    expected = [[IonStyle alloc] initWithDictionary: [IonStyleTests staticTestStyle]];
    result = [[IonStyle alloc] initWithDictionary: [IonStyleTests staticTestStyle]];
    
    
    XCTAssert( [expected isEqualToStyle: result] , @"Invalid result.");
}

/**
 * Checks if style comparison works.
 */
- (void)testStyleComparisonInvalid {
    IonStyle *expected, *result;
    
    expected = [[IonStyle alloc] initWithDictionary: [IonStyleTests staticTestStyle]];
    result = [[IonStyle alloc] initWithDictionary: @{@"t":@"fdsfds"}]; // pipe in some BS data
    
    
    XCTAssert( ![expected isEqualToStyle: result] , @"Invalid result.");
}

#pragma Generation 

/**
 * Gets a static resolved style.
 */
+ (NSDictionary*) staticTestStyle {
    return @{
            
             };
}
@end

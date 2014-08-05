//
//  IonGradientConfigurationTests.m
//  Ion
//
//  Created by Andrew Hurst on 8/1/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "IonGradientConfiguration.h"
#import "IonMath.h"


@interface IonGradientConfigurationTests : XCTestCase

@end

@implementation IonGradientConfigurationTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


#pragma mark Base Gradient Configuration

/**
 * Checks Construction of base gradient.
 */
- (void) testBaseGradientConstructionWithValidData {
    BOOL pass;
    IonGradientConfiguration *target;
    NSArray *colorWeights;
    
    // construct
    pass = TRUE;
    colorWeights = [IonGradientConfigurationTests colorWeights];
    target = [[IonGradientConfiguration alloc] initWithColorWeights: colorWeights];
    
    // Check
    for ( IonColorWeight* colorWeight in target.colorWeights )
        if ( ![colorWeights containsObject: colorWeight] ) {
            pass = FALSE;
            break;
        }
    
    XCTAssert( pass && target , @"Failed to generate from valid data.");
}

/**
 * Checks if similarities Pass
 */
- (void) testBaseGradientCompare {
    IonGradientConfiguration *itemOne, *itemTwo;
    NSArray *colorWeights;
    
    // construct
    colorWeights = [IonGradientConfigurationTests colorWeights];
    itemOne = [[IonGradientConfiguration alloc] initWithColorWeights: colorWeights];
    itemTwo = [[IonGradientConfiguration alloc] initWithColorWeights: colorWeights];
    
    XCTAssert( [itemOne isEqual: itemTwo] , @"Comparison Failed.");
}

/**
 * Checks if dif angle causes fail
 */
- (void) testBaseGradientDifColorWeights {
    IonGradientConfiguration *itemOne, *itemTwo;
    NSArray *colorWeightsOne, *colorWeightsTwo;
    
    // construct
    colorWeightsOne = [IonGradientConfigurationTests colorWeights];
    colorWeightsTwo = @[[[IonColorWeight alloc] initWithColor: [UIColor redColor] andWeight: 0.9f],
                        [[IonColorWeight alloc] initWithColor: [UIColor yellowColor] andWeight: 0.9f]];
    itemOne = [[IonGradientConfiguration alloc] initWithColorWeights: colorWeightsOne];
    itemTwo = [[IonGradientConfiguration alloc] initWithColorWeights: colorWeightsTwo];
    
    XCTAssert( ![itemOne isEqual: itemTwo] , @"Comparison succeeded when it should have failed.");
    
}

#pragma mark Linear Base Configuration

/**
 * Checks Construction of Linear gradient.
 * Note: Dependent on Base Gradient configuration.
 */
- (void) testLinearGradientConstructionWithValidData {
    IonLinearGradientConfiguration *target;
    NSArray *colorWeights;
    CGFloat angle;
    
    // construct
    angle = 68.9f;
    colorWeights = [IonGradientConfigurationTests colorWeights];
    target = [[IonLinearGradientConfiguration alloc] initWithColor:[IonGradientConfigurationTests colorWeights] andAngel:angle ];
  
    XCTAssertEqualWithAccuracy( target.angle, angle, 0.1f, @"Failed to generate from valid data; Result:%f expected:%f", target.angle, angle);
}

/**
 * Checks if similarities Pass
 */
- (void) testLinearGradientCompare {
    IonLinearGradientConfiguration *itemOne, *itemTwo;
    CGFloat angle;
    
    // construct
    angle = 45.5f;
    itemOne = [[IonLinearGradientConfiguration alloc] initWithColor:[IonGradientConfigurationTests colorWeights] andAngel:angle ];
    itemTwo = [[IonLinearGradientConfiguration alloc] initWithColor:[IonGradientConfigurationTests colorWeights] andAngel:angle ];
    
    // Test
    XCTAssert( [itemOne isEqual: itemTwo] , @"Comparison Failed.");
}

/**
 * Checks if dif angle causes fail
 */
- (void) testLinearGradientDifAngle {
    IonLinearGradientConfiguration *itemOne, *itemTwo;
    CGFloat angleOne, angleTwo;
    
    // construct
    angleOne = 45.5f;
    angleTwo = 90.0f;
    itemOne = [[IonLinearGradientConfiguration alloc] initWithColor:[IonGradientConfigurationTests colorWeights] andAngel: angleOne ];
    itemTwo = [[IonLinearGradientConfiguration alloc] initWithColor:[IonGradientConfigurationTests colorWeights] andAngel: angleTwo ];
    
    // Test
    XCTAssert( ![itemOne isEqual: itemTwo] , @"Comparison succeeded when it should have failed.");
}

#pragma mark Color Weights

/**
 * Checks Construction of colorWeight.
 * Note: Dependent on Color Hex Conversion.
 */
- (void) testColorWeightConstructionWithValidData {
    BOOL correctColor, correctWeight;
    IonColorWeight *target;
    UIColor* color;
    CGFloat weight;
    
    // construct
    correctWeight = correctColor = FALSE;
    weight = 0.48f;
    color = [UIColor redColor];
    target = [[IonColorWeight alloc] initWithColor: color andWeight: weight];
    
    correctColor = [color isEqual: target.color];
    correctWeight = (weight == target.weight);
    
    XCTAssert( correctColor && correctWeight, @"Failed To construct with valid data; Color Correct %i Weight correct %i", correctColor, correctWeight );
}


/**
 * Checks if similarities Pass
 */
- (void) testColorWeightCompare {
    IonColorWeight *itemOne, *itemTwo;
    UIColor* color;
    CGFloat weight;
    
    // Create
    color = [UIColor purpleColor];
    weight = 0.7;
    itemOne = [[IonColorWeight alloc] initWithColor: color andWeight: weight];
    itemTwo = [[IonColorWeight alloc] initWithColor: color andWeight: weight];
    
    // Check
    XCTAssert( [itemOne isEqual: itemTwo] , @"Comparison Failed.");
}


/**
 * Checks if weight change causes Fail
 */
- (void) testColorWeightCompareDifWeights {
    IonColorWeight *itemOne, *itemTwo;
    UIColor* color;
    CGFloat weightOne, weightTwo;
    
    // Create
    color = [UIColor purpleColor];
    weightOne = 0.7;
    weightTwo = 0.6;
    itemOne = [[IonColorWeight alloc] initWithColor: color andWeight: weightOne];
    itemTwo = [[IonColorWeight alloc] initWithColor: color andWeight: weightTwo ];
    
    // Check
    XCTAssert( ![itemOne isEqual: itemTwo] , @"Comparison succeeded when it should have failed.");
}


/**
 * Checks if color change causes Fail
 */
- (void) testColorWeightCompareDifColors {
    IonColorWeight *itemOne, *itemTwo;
    UIColor *colorOne, *colorTwo;
    CGFloat weight;
    
    // Create
    colorOne = [UIColor purpleColor];
    colorTwo = [UIColor redColor];
    weight = 0.7;
    itemOne = [[IonColorWeight alloc] initWithColor: colorOne andWeight: weight];
    itemTwo = [[IonColorWeight alloc] initWithColor: colorTwo andWeight: weight];
    
    // Check
    XCTAssert( ![itemOne isEqual: itemTwo] , @"Comparison succeeded when it should have failed.");
}


#pragma mark Utilties

/**
 * A Default array of color weights to test from.
 */
+ (NSArray*) colorWeights {
    return @[ [[IonColorWeight alloc] initWithColor: [UIColor redColor] andWeight: 0.9f],
              [[IonColorWeight alloc] initWithColor: [UIColor yellowColor] andWeight: 0.9f],
              [[IonColorWeight alloc] initWithColor: [UIColor greenColor] andWeight: 0.5f],
              [[IonColorWeight alloc] initWithColor: [UIColor brownColor] andWeight: 0.1f],
              [[IonColorWeight alloc] initWithColor: [UIColor brownColor] andWeight: -0.1f],
             ];
}

@end

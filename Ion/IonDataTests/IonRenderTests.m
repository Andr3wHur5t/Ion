//
//  IonRenderTests.m
//  Ion
//
//  Created by Andrew Hurst on 7/16/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "IonRenderUtilities.h"
#import "IonGradientConfiguration.h"

@interface IonRenderTests : XCTestCase

// Consistant Context size for rendering
@property (assign, nonatomic) CGSize contextSize;

// Consistant Color Weights
@property (strong, nonatomic) NSArray* colorWeights;

+ (UIImage *)imageWithColor:(UIColor *)color;
@end

@implementation IonRenderTests

- (void)setUp {
    [super setUp];
    // use a consistant size to ensure that we are comparable.
    _contextSize = CGSizeMake(300, 300);
    
    //
    _colorWeights = [[IonGradientConfiguration alloc] init].colorWeights;
}

- (void)tearDown {
    _contextSize = CGSizeZero;
    _colorWeights = NULL;
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}



#pragma mark gradients

/**
 * Checks if the gradient refrence generation function generates a valid object
 */
- (void) testLinearGradientConfigurationToRefrence {
    CGGradientRef testRefrence = [IonRenderUtilities referenceGradientFromColorWeights: _colorWeights];
    
    XCTAssert( testRefrence , @"Generated Gradient Refrence is NULL");
}


/**
 * Tests for the speed of rendering a gradient.
 */
- (void) testGradientRenderPerformance {
    __block UIImage *result;
    __block CGSize targetSize;
    __block IonLinearGradientConfiguration* linGrad;
    
    linGrad = [[IonLinearGradientConfiguration alloc] init];
    targetSize = CGSizeMake(500, 500);
    
    [self measureBlock:^{
        __block XCTestExpectation *renderCompleteExpectation = [self expectationWithDescription:@"Render Complete"];
        [IonRenderUtilities renderLinearGradient: linGrad
                                      resultSize: targetSize
                                 withReturnBlock: ^(UIImage *image) {
                                     result = image;
                                     [renderCompleteExpectation fulfill];
                                  }];
        
        [self waitForExpectationsWithTimeout:1 handler:^(NSError *error) {
            XCTAssert( !CGSizeEqualToSize(result.size, _contextSize),
                      @"Net image size is incorrect.");
        }];
    }];
}

/**
 * Test Image resizing.
 * Note: we rerender the gradient here for an image, then resize it.
 */
- (void) testImageResizeing {
    __block UIImage *result, *input;
    __block CGSize targetSize;
    __block IonLinearGradientConfiguration* linGrad;
    linGrad = [[IonLinearGradientConfiguration alloc] init];
    
    targetSize = CGSizeMake(500, 500);
    input = [IonRenderTests imageWithColor: [UIColor redColor]];
    
    
    [self measureBlock:^{
        
        __block XCTestExpectation *renderCompleteExpectation = [self expectationWithDescription:@"Render Complete"];
        [IonRenderUtilities renderImage: NULL
                           withSize: targetSize
                     andReturnBlock:^(UIImage *image) {
                         result = image;
                         [renderCompleteExpectation fulfill];
                     }];
    
        [self waitForExpectationsWithTimeout:1 handler: ^(NSError *error) {
            XCTAssert( !CGSizeEqualToSize(result.size, _contextSize),
                  @"Net image size is incorrect.");
        }];
        
    }];
}


/**
 * Image generation Utility
 */
+ (UIImage *)imageWithColor:(UIColor*) color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end

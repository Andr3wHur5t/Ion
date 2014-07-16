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
 * This checks if the gradient refrence generation function generates a valid object
 */
- (void)testLinearGradientConfigurationToRefrence {
    CGGradientRef testRefrence = [IonRenderUtilities refrenceGradientFromColorWeights:_colorWeights];
    
    XCTAssert( testRefrence , @"Generated Gradient Refrence is NULL");
}


/**
 * This tests for the speed of rendering a gradient.
 */
- (void)testGradientRenderInBlockPerformance {
    [IonRenderUtilities renderTestingInMainBlock:^{
        IonContextState currentState = currentContextStateWithSize(_contextSize);
        
         [self measureBlock:^{
            [IonRenderUtilities linearGradientWithContextState: currentState
                                          gradientColorWeights: _colorWeights
                                                         angle: M_PI/2 ];
         }];
        
    }
                               inContextWithSize:_contextSize
                                           scale:1.0f
                                    thatHasAlpha:true
                                  andReturnBlock:^(UIImage *image) {
                                      XCTAssert(image.size.width == _contextSize.width &&
                                                image.size.height == _contextSize.height,
                                                @"Net Image Size Is Correct");
                                  }];
}

@end

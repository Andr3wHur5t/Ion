//
//  IonGuideLineTest.m
//  Ion
//
//  Created by Andrew Hurst on 8/21/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "IonGuideLine.h"
#import "IonGuideLine+DependentGuides.h"
#import "IonGuideLine+DefaultConstructors.h"
#import "IonView.h"

@interface IonGuideLineTest : XCTestCase

@property (assign) CGFloat testFloat;
@property (strong, nonatomic) IonView* testRect;
@end

@implementation IonGuideLineTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    _testRect = NULL;
    [super tearDown];
}

/**
 * Tests creation of guideline
 */
- (void)testGuideLineFloat {
    IonGuideLine* line;
    _testFloat = 1;
    
    line = [[IonGuideLine alloc] init];
    [line setTarget: self usingKeyPath: @"testFloat"];
    self.testFloat = 2;
    
    XCTAssert( line.position == self.testFloat , @"Values do not match.");
}



/**
 * Tests Size Amount Response
 */
- (void)testGuideLineFrameSizeAmount {
    IonGuideLine* line;
    CGFloat amount;
    _testRect = [[IonView alloc] initWithFrame: (CGRect){ CGPointZero , (CGSize){ 10,10 } }];
    amount = 0.75;
    
    line = [IonGuideLine guideFromViewFrameSize: _testRect usingAmount: amount andMode: IonGuideLineFrameMode_Horizontal];
    self.testRect.frame = (CGRect){ CGPointZero, (CGSize){100, 100}};
    
    XCTAssert( line.position == self.testRect.frame.size.height * amount , @"Values do not match.");
}


/**
 * Tests Corner Radius Response
 */
- (void)testGuideLineCornerRadius {
    IonGuideLine* line;
    _testRect = [[IonView alloc] initWithFrame: (CGRect){ CGPointZero , (CGSize){ 10,10 } }];
    _testRect.layer.cornerRadius = 2;
    
    line = [IonGuideLine guideFromViewCornerRadius: _testRect usingMode: IonGuideLineFrameMode_Horizontal];
    _testRect.layer.cornerRadius = 4;
    
    XCTAssert( line.position == _testRect.layer.cornerRadius  , @"Values do not match.");
}

/**
 * Tests Style margin Response
 */
- (void)testGuideLineStyleMargin {
    IonGuideLine* line;
    _testRect = [[IonView alloc] initWithFrame: (CGRect){ CGPointZero , (CGSize){ 10,10 } }];
    _testRect.styleMargin = (CGSize){ 2, 4 };
    
    line = [IonGuideLine guideFromViewStyleMargin: _testRect usingMode: IonGuideLineFrameMode_Horizontal];
    _testRect.styleMargin = (CGSize){ 8, 6 };
    
    XCTAssert( line.position == _testRect.styleMargin.width  , @"Values do not match.");
}

/**
 * Tests Auto Style margin Response
 */
- (void)testGuideLineStyleAutoMarginFromStyleMargin {
    IonGuideLine* line;
    _testRect = [[IonView alloc] initWithFrame: (CGRect){ CGPointZero , (CGSize){ 10,10 } }];
    _testRect.styleMargin = (CGSize){ 2, 4 };
    
    line = [IonGuideLine guideFromViewAutoMargin:_testRect usingMode: IonGuideLineFrameMode_Horizontal];
    _testRect.styleMargin = (CGSize){ 8, 6 };
    
    XCTAssert( line.position == _testRect.styleMargin.width  , @"Values do not match.");
}

/**
 * Tests Auto Style corner radius Response
 */
- (void)testGuideLineStyleAutoMarginFromCornerRadius {
    IonGuideLine* line;
    _testRect = [[IonView alloc] initWithFrame: (CGRect){ CGPointZero , (CGSize){ 10,10 } }];
    _testRect.styleMargin = (CGSize){ 2, 4 };
    _testRect.layer.cornerRadius = 10;
    
    
    line = [IonGuideLine guideFromViewAutoMargin:_testRect usingMode: IonGuideLineFrameMode_Horizontal];
    XCTAssert( line.position == _testRect.layer.cornerRadius  , @"Values do not match.");
}

/**
 * Test Position Inheritance.
 */
- (void)testGuideLineInheritance {
    IonGuideLine *line, *childLine;
    CGFloat amount;
    amount = 5;
    _testFloat = 15.0;
    
    line = [IonGuideLine guideWithTarget: self andKeyPath:@"testFloat"];
    childLine = [line guideAsChildUsingCalcBlock: ^CGFloat(CGFloat target) {
        return target + amount;
    }];
    _testFloat = 50.0f;
    
    XCTAssert( line.position + amount == childLine.position   , @"Values do not match.");
}

/**
 * Test Guide Dependence.
 */
- (void)testGuideLineDependence {
    IonGuideLine *lineOne;
    CGFloat val = 5;
    _testFloat = 15.0;
    
    lineOne = [IonGuideLine guideWithStaticValue: val];
    [lineOne addDependentTarget: self andKeyPath: @"testFloat"];
    [lineOne setCalcBlock: ^CGFloat( CGFloat target ){
        return target * 2;
    }];
    
    // Try to force a recalc
    self.testFloat = 50;
    
    XCTAssert( lineOne.position == val * 2 , @"Values do not match.");
}

/**
 * Test Guide Dependence.
 */
- (void)testGuideLineModifications {
    IonGuideLine *lineOne, *lineTwo, *resultLine;
    _testFloat = 15.0;
    
    lineOne = [IonGuideLine guideWithStaticValue: 5];
    lineTwo = [IonGuideLine guideWithTarget: self andKeyPath:@"testFloat"];
    
    resultLine = [IonGuideLine guideWithGuide: lineOne
                                      modType: IonValueModType_Add
                               andSecondGuide: lineTwo];
    
    self.testFloat = 50;

    XCTAssert( resultLine.position == lineOne.position + lineTwo.position   , @"Values do not match.");
}

@end

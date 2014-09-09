//
//  IonGuideSetTests.m
//  Ion
//
//  Created by Andrew Hurst on 8/27/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "IonViewGuideSet.h"
#import "IonGuideLine+DefaultConstructors.h"

@interface IonGuideSetTests : XCTestCase

@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;
@property (assign, nonatomic) CGFloat lx;
@property (assign, nonatomic) CGFloat ly;

@end

@implementation IonGuideSetTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

/**
 * Test Creation
 */
- (void)testGuideSetCreation {
    XCTAssert( [[IonViewGuideSet alloc] init] , @"Failed To Create Guides");
}


/**
 * Test Static Mounting
 */
- (void)testStaticMounting {
    IonGuideLine *sX, *sY, *lX, *lY;
    IonViewGuideSet* staticMountSet;
    staticMountSet = [[IonViewGuideSet alloc] init];
    
    sX = [IonGuideLine guideWithStaticValue: 10];
    sY = [IonGuideLine guideWithStaticValue: 1003];
    lX = [IonGuideLine guideWithStaticValue: 10];
    lY = [IonGuideLine guideWithStaticValue: 105];
    
    [staticMountSet setLocalPairWithVert: lY andHoriz: lX];
    [staticMountSet setSuperPairWithVert: sY andHoriz: sX];
    
    XCTAssert( CGPointEqualToPoint( [staticMountSet toPoint], (CGPoint){ sX.position - lX.position, sY.position - lY.position} ) , @"Invalid point response");
}

/**
 * Test Default Local Static Mounting
 */
- (void)testDefaultLocalStaticMounting {
    IonGuideLine *sX, *sY;
    IonViewGuideSet* staticMountSet;
    staticMountSet = [[IonViewGuideSet alloc] init];
    
    sX = [IonGuideLine guideWithStaticValue: 10];
    sY = [IonGuideLine guideWithStaticValue: 1003];
    [staticMountSet setSuperPairWithVert: sY andHoriz: sX];
    
    XCTAssert( CGPointEqualToPoint( [staticMountSet toPoint], (CGPoint){ sX.position , sY.position} ) , @"Invalid point response");
}

/**
 * Test Dynamic Super Mounting
 */
- (void)testDynamicSuperMounting {
    IonGuideLine *sX, *sY;
    IonViewGuideSet* staticMountSet;
    staticMountSet = [[IonViewGuideSet alloc] init];
    
    sX = [IonGuideLine guideWithTarget: self andKeyPath: @"x"];
    sY = [IonGuideLine guideWithTarget: self andKeyPath: @"y"];
    [staticMountSet setSuperPairWithVert: sY andHoriz: sX];
    
    
    self.x = 1000;
    self.y = 2356.0364;
    
    XCTAssert( CGPointEqualToPoint( [staticMountSet toPoint], (CGPoint){ self.x, self.y } ) , @"Invalid point response");
}



@end

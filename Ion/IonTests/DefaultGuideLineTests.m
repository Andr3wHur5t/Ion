//
//  DefaultGuideLineTests.m
//  Ion
//
//  Created by Andrew Hurst on 8/27/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "IonCompleteGuideGroup.h"
#import "UIView+IonGuideGroup.h"
#import "UIView+IonTheme.h"

@interface DefaultGuideLineTests : XCTestCase

@end

@implementation DefaultGuideLineTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


#pragma mark Guide Group
- (void)testGuideGroupFrameCreation{
    IonGuideGroup* gg;
    CGRect frame;
    
    frame = (CGRect) { (CGPoint){ 100, 10}, (CGSize){ 100, 30} };
    gg = [[IonGuideGroup alloc] initWithFrame: frame];
    
    XCTAssert( CGRectEqualToRect( gg.frame , frame), @"Not Same");
}


/** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
 *                                               Internal Guides
 * = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = */


#pragma mark Internal Guides

- (void)testGuideGroupOrginHoriz{
    IonGuideGroup* gg;
    CGRect frame;
    
    frame = (CGRect) { (CGPoint){ 100, 10}, (CGSize){ 100, 30} };
    gg = [[IonGuideGroup alloc] initWithFrame: frame];
    
    XCTAssertEqualWithAccuracy( gg.originGuideHoriz.position, 0 , 0.2, @"Not Same");
}

- (void)testGuideGroupOrginVert{
    IonGuideGroup* gg;
    CGRect frame;
    
    frame = (CGRect) { (CGPoint){ 100, 10}, (CGSize){ 100, 30} };
    gg = [[IonGuideGroup alloc] initWithFrame: frame];
    
    XCTAssertEqualWithAccuracy( gg.originGuideVert.position, 0, 0.2, @"Not Same");
}

- (void)testGuideGroupSizeHoriz{
    IonGuideGroup* gg;
    CGRect frame;
    
    frame = (CGRect) { (CGPoint){ 100, 10}, (CGSize){ 100, 30} };
    gg = [[IonGuideGroup alloc] initWithFrame: frame];
    
    XCTAssertEqualWithAccuracy( gg.sizeGuideHoriz.position, frame.size.width, 0.2, @"Not Same");
}

- (void)testGuideGroupSizeVert{
    IonGuideGroup* gg;
    CGRect frame;
    
    frame = (CGRect) { (CGPoint){ 100, 10}, (CGSize){ 100, 30} };
    gg = [[IonGuideGroup alloc] initWithFrame: frame];
    
    XCTAssertEqualWithAccuracy( gg.sizeGuideVert.position,  frame.size.height, 0.2, @"Not Same");
}


- (void)testGuideGroupCenterHoriz{
    IonGuideGroup* gg;
    CGRect frame;
    
    frame = (CGRect) { (CGPoint){ 100, 10}, (CGSize){ 100, 30} };
    gg = [[IonGuideGroup alloc] initWithFrame: frame];
    
    XCTAssertEqualWithAccuracy( gg.centerGuideHoriz.position, (frame.size.width / 2), 0.2, @"Not Same");
}


- (void)testGuideGroupCenterVert{
    IonGuideGroup* gg;
    CGRect frame;
    
    frame = (CGRect) { (CGPoint){ 100, 10}, (CGSize){ 100, 30} };
    gg = [[IonGuideGroup alloc] initWithFrame: frame];
    
    XCTAssertEqualWithAccuracy( gg.centerGuideVert.position, (frame.size.height / 2), 0.2, @"Not Same");
}


- (void)testGuideGroupOneThirdHoriz{
    IonGuideGroup* gg;
    CGRect frame;
    
    frame = (CGRect) { (CGPoint){ 100, 10}, (CGSize){ 100, 30} };
    gg = [[IonGuideGroup alloc] initWithFrame: frame];
    
    XCTAssertEqualWithAccuracy( gg.oneThirdGuideHoriz.position,  (frame.size.width / 3), 0.2, @"Not Same");
}

- (void)testGuideGroupOneThirdVert{
    IonGuideGroup* gg;
    CGRect frame;
    
    frame = (CGRect) { (CGPoint){ 100, 10}, (CGSize){ 100, 30} };
    gg = [[IonGuideGroup alloc] initWithFrame: frame];
    
    XCTAssertEqualWithAccuracy( gg.oneThirdGuideVert.position,  (frame.size.height / 3), 0.2, @"Not Same");
}

- (void)testGuideGroupTwoThirdHoriz{
    IonGuideGroup* gg;
    CGRect frame;
    
    frame = (CGRect) { (CGPoint){ 100, 10}, (CGSize){ 100, 30} };
    gg = [[IonGuideGroup alloc] initWithFrame: frame];
    
    XCTAssertEqualWithAccuracy( gg.twoThirdsGuideHoriz.position, ( 2 * frame.size.width / 3), 0.2, @"Not Same");
}

- (void)testGuideGroupTwoThirdVert{
    IonGuideGroup* gg;
    CGRect frame;
    
    frame = (CGRect) { (CGPoint){ 100, 10}, (CGSize){ 100, 30} };
    gg = [[IonGuideGroup alloc] initWithFrame: frame];
    
    XCTAssertEqualWithAccuracy( gg.twoThirdsGuideVert.position,  ( 2 * frame.size.height / 3), 0.2, @"Not Same");
}

- (void)testGuideGroupOneFourthHoriz{
    IonGuideGroup* gg;
    CGRect frame;
    
    frame = (CGRect) { (CGPoint){ 100, 10}, (CGSize){ 100, 30} };
    gg = [[IonGuideGroup alloc] initWithFrame: frame];
    
    XCTAssertEqualWithAccuracy( gg.oneForthGuideHoriz.position, (frame.size.width / 4), 0.2, @"Not Same");
}

- (void)testGuideGroupOneFourthVert{
    IonGuideGroup* gg;
    CGRect frame;
    
    frame = (CGRect) { (CGPoint){ 100, 10}, (CGSize){ 100, 30} };
    gg = [[IonGuideGroup alloc] initWithFrame: frame];
    
    XCTAssertEqualWithAccuracy( gg.oneForthGuideVert.position,  (frame.size.height / 4), 0.2, @"Not Same");
}

- (void)testGuideGroupThreeFourthsHoriz{
    IonGuideGroup* gg;
    CGRect frame;
    
    frame = (CGRect) { (CGPoint){ 100, 10}, (CGSize){ 100, 30} };
    gg = [[IonGuideGroup alloc] initWithFrame: frame];
    
    XCTAssertEqualWithAccuracy( gg.threeForthsGuideHoriz.position,  ( 3 * frame.size.width / 4), 0.2, @"Not Same");
}

- (void)testGuideGroupThreeFourthsVert{
    IonGuideGroup* gg;
    CGRect frame;
    
    frame = (CGRect) { (CGPoint){ 100, 10}, (CGSize){ 100, 30} };
    gg = [[IonGuideGroup alloc] initWithFrame: frame];
    
    XCTAssertEqualWithAccuracy( gg.threeForthsGuideVert.position,  ( 3 * frame.size.height / 4), 0.2, @"Not Same");
}


/** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
 *                                               External Guides
 * = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = */

#pragma mark External Guides
- (void)testGuideGroupOrginHorizExternal{
    IonGuideGroup* gg;
    CGRect frame;
    
    frame = (CGRect) { (CGPoint){ 100, 10}, (CGSize){ 100, 30} };
    gg = [[IonGuideGroup alloc] initWithFrame: frame];
    
    XCTAssert( gg.originExternalGuideHoriz.position == frame.origin.x , @"Not Same");
}

- (void)testGuideGroupOrginVertExternal{
    IonGuideGroup* gg;
    CGRect frame;
    
    frame = (CGRect) { (CGPoint){ 100, 10}, (CGSize){ 100, 30} };
    gg = [[IonGuideGroup alloc] initWithFrame: frame];
    
    XCTAssertEqualWithAccuracy( gg.originExternalGuideVert.position, frame.origin.y , 0.2, @"Not Same");
}

- (void)testGuideGroupSizeHorizExternal{
    IonGuideGroup* gg;
    CGRect frame;
    
    frame = (CGRect) { (CGPoint){ 100, 10}, (CGSize){ 100, 30} };
    gg = [[IonGuideGroup alloc] initWithFrame: frame];
    
    XCTAssertEqualWithAccuracy( gg.sizeExternalGuideHoriz.position, frame.origin.x + frame.size.width, 0.2, @"Not Same");
}

- (void)testGuideGroupSizeVerExternalt{
    IonGuideGroup* gg;
    CGRect frame;
    
    frame = (CGRect) { (CGPoint){ 100, 10}, (CGSize){ 100, 30} };
    gg = [[IonGuideGroup alloc] initWithFrame: frame];
    
    XCTAssertEqualWithAccuracy( gg.sizeExternalGuideVert.position, frame.origin.y + frame.size.height, 0.2, @"Not Same");
}


- (void)testGuideGroupCenterHorizExternal{
    IonGuideGroup* gg;
    CGRect frame;
    
    frame = (CGRect) { (CGPoint){ 100, 10}, (CGSize){ 100, 30} };
    gg = [[IonGuideGroup alloc] initWithFrame: frame];
    
    XCTAssertEqualWithAccuracy( gg.centerExternalGuideHoriz.position, frame.origin.x + (frame.size.width / 2), 0.2, @"Not Same");
}


- (void)testGuideGroupCenterVertExternal{
    IonGuideGroup* gg;
    CGRect frame;
    
    frame = (CGRect) { (CGPoint){ 100, 10}, (CGSize){ 100, 30} };
    gg = [[IonGuideGroup alloc] initWithFrame: frame];
    
    XCTAssertEqualWithAccuracy( gg.centerExternalGuideVert.position, frame.origin.y + (frame.size.height / 2), 0.2, @"Not Same");
}


- (void)testGuideGroupOneThirdHorizExternal{
    IonGuideGroup* gg;
    CGRect frame;
    
    frame = (CGRect) { (CGPoint){ 100, 10}, (CGSize){ 100, 30} };
    gg = [[IonGuideGroup alloc] initWithFrame: frame];
    
    XCTAssertEqualWithAccuracy( gg.oneThirdExternalGuideHoriz.position, frame.origin.x + (frame.size.width / 3), 0.2, @"Not Same");
}

- (void)testGuideGroupOneThirdVertExternal{
    IonGuideGroup* gg;
    CGRect frame;
    
    frame = (CGRect) { (CGPoint){ 100, 10}, (CGSize){ 100, 30} };
    gg = [[IonGuideGroup alloc] initWithFrame: frame];
    
    XCTAssertEqualWithAccuracy( gg.oneThirdExternalGuideVert.position, frame.origin.y + (frame.size.height / 3), 0.2, @"Not Same");
}

- (void)testGuideGroupTwoThirdHorizExternal{
    IonGuideGroup* gg;
    CGRect frame;
    
    frame = (CGRect) { (CGPoint){ 100, 10}, (CGSize){ 100, 30} };
    gg = [[IonGuideGroup alloc] initWithFrame: frame];
    
    XCTAssertEqualWithAccuracy( gg.twoThirdsExternalGuideHoriz.position, frame.origin.x + ( 2 * frame.size.width / 3), 0.2, @"Not Same");
}

- (void)testGuideGroupTwoThirdVertExternal{
    IonGuideGroup* gg;
    CGRect frame;
    
    frame = (CGRect) { (CGPoint){ 100, 10}, (CGSize){ 100, 30} };
    gg = [[IonGuideGroup alloc] initWithFrame: frame];
    
    XCTAssertEqualWithAccuracy( gg.twoThirdsExternalGuideVert.position, frame.origin.y + ( 2 * frame.size.height / 3), 0.2, @"Not Same");
}

- (void)testGuideGroupOneFourthHorizExternal{
    IonGuideGroup* gg;
    CGRect frame;
    
    frame = (CGRect) { (CGPoint){ 100, 10}, (CGSize){ 100, 30} };
    gg = [[IonGuideGroup alloc] initWithFrame: frame];
    
    XCTAssertEqualWithAccuracy( gg.oneForthExternalGuideHoriz.position, frame.origin.x + (frame.size.width / 4), 0.2, @"Not Same");
}

- (void)testGuideGroupOneFourthVertExternal{
    IonGuideGroup* gg;
    CGRect frame;
    
    frame = (CGRect) { (CGPoint){ 100, 10}, (CGSize){ 100, 30} };
    gg = [[IonGuideGroup alloc] initWithFrame: frame];
    
    XCTAssertEqualWithAccuracy( gg.oneForthExternalGuideVert.position, frame.origin.y + (frame.size.height / 4), 0.2, @"Not Same");
}

- (void)testGuideGroupThreeFourthsHorizExternal{
    IonGuideGroup* gg;
    CGRect frame;
    
    frame = (CGRect) { (CGPoint){ 100, 10}, (CGSize){ 100, 30} };
    gg = [[IonGuideGroup alloc] initWithFrame: frame];
    
    XCTAssertEqualWithAccuracy( gg.threeForthsExternalGuideHoriz.position, frame.origin.x + ( 3 * frame.size.width / 4), 0.2, @"Not Same");
}

- (void)testGuideGroupThreeFourthsVertExternal{
    IonGuideGroup* gg;
    CGRect frame;
    
    frame = (CGRect) { (CGPoint){ 100, 10}, (CGSize){ 100, 30} };
    gg = [[IonGuideGroup alloc] initWithFrame: frame];
    
    XCTAssertEqualWithAccuracy( gg.threeForthsExternalGuideVert.position, frame.origin.y + ( 3 * frame.size.height / 4), 0.2, @"Not Same");
}
/** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
 *                                               UIView Specific
 * = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = */


#pragma mark UIView Specific

- (void)testUIViewLeftMargin {
    CGSize margin = (CGSize) { 5, 12};
    CGRect frame = (CGRect) { (CGPoint){ 100, 10}, (CGSize){ 100, 30} };
    UIView* view = [[UIView alloc] initWithFrame: frame];
    view.styleMargin = margin;
    
    
    XCTAssertEqualWithAccuracy( view.leftMargin.position, frame.origin.x - margin.width , 0.2, @"Not Same");
}

- (void)testUIViewRightMargin {
    CGSize margin = (CGSize) { 5, 12};
    CGRect frame = (CGRect) { (CGPoint){ 100, 10}, (CGSize){ 100, 30} };
    UIView* view = [[UIView alloc] initWithFrame: frame];
    view.styleMargin = margin;
    
    
    XCTAssertEqualWithAccuracy( view.rightMargin.position, frame.origin.x + frame.size.width+ margin.width , 0.2, @"Not Same");
}

- (void)testUIViewTopMargin {
    CGSize margin = (CGSize) { 5, 12};
    CGRect frame = (CGRect) { (CGPoint){ 100, 10}, (CGSize){ 100, 30} };
    UIView* view = [[UIView alloc] initWithFrame: frame];
    view.styleMargin = margin;
    
    
    XCTAssertEqualWithAccuracy( view.topMargin.position, frame.origin.y - margin.height , 0.2, @"Not Same");
}

- (void)testUIViewBottomMargin {
    CGSize margin = (CGSize) { 5, 12};
    CGRect frame = (CGRect) { (CGPoint){ 100, 10}, (CGSize){ 100, 30} };
    UIView* view = [[UIView alloc] initWithFrame: frame];
    view.styleMargin = margin;
    
    
    XCTAssertEqualWithAccuracy( view.bottomMargin.position, frame.origin.y + frame.size.height + margin.height , 0.2, @"Not Same");
}

@end

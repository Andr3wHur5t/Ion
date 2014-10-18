//
//  IACRouterTest.m
//  IACommunication
//
//  Created by Andrew Hurst on 10/7/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "IACRouter.h"
#import "IACLink.h"

@interface IACRouterTest : XCTestCase

@end

@implementation IACRouterTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark Construction

- (void)testRouterConstruction {
    XCTAssert( [[[IACRouter alloc] init] isKindOfClass: [IACRouter class]] , @"Pass");
}

#pragma mark Routing

- (void) testRouting {
    // This need to be properly tested.
    IACModule *module;
    IACRouter *router, *secondaryRouter;
    IACLink *testLink;
    
    module = [[IACModule alloc] init];
    router = [[IACRouter alloc] init];
    secondaryRouter = [[IACRouter alloc] init];
    
    [router addComponent: secondaryRouter forKey: @"Main"];
    [secondaryRouter addComponent: module forKey: @"people"];
    
    testLink = [IACLink linkWithURLString: @"ion:///Main/People/?id=124425"
                                   reason: @"Push Notification"
                          andReferralLink: [IACLink referralLinkWithURLString: @"ion:///Events/?id=24456"]];
    
    [router invokeLink: testLink];
    return;
}


@end

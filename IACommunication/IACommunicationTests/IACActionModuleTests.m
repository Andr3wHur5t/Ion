//
//  IACActionModuleTests.m
//  IACommunication
//
//  Created by Andrew Hurst on 10/7/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "IACActionModule.h"
#import "IACLink.h"
#import "IACRouter.h"

@interface IACActionModuleTests : XCTestCase

@end

@implementation IACActionModuleTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark Construction

- (void)testConstruction {
    XCTAssert( [[[IACActionModule alloc] init] isKindOfClass: [IACActionModule class]] , @"Pass");
}

#pragma mark Test Action Calls
- (void)testActionModule {
    IACActionModule *module;
    IACRouter *router, *secondaryRouter;
    IACLink *testLink, *addLink;
    
    module = [[IACActionModule alloc] initWithTarget: self];
    router = [[IACRouter alloc] init];
    secondaryRouter = [[IACRouter alloc] init];
    
    
    [router addComponent: secondaryRouter forKey: @"Main"];
    [secondaryRouter addComponent: module forKey: @"people"];
    [module addAction: @selector(openPersonWithLink:) toEndpoint:@"Open"];
    [module addAction: @selector(addPersonWithLink:) toEndpoint:@"Add"];
    
    testLink = [IACLink linkWithURLString: @"ion:///Main/People/Open/?id=124425"
                                   reason: @"Push Notification"
                          andReferralLink: [IACLink referralLinkWithURLString: @"ion:///Events/?id=24456"]];
    
    addLink = [IACLink linkWithURLString: @"ion:///Main/People/Add/?id=12445673" andReason: @"Button Press"];
    
    [router invokeLink: testLink];
    return;
}

#pragma mark Dummy Selectors

- (void) openPersonWithLink:(IACLink *)link {
    NSLog(@"Open Person With Id %@", [link.parameters objectForKey: @"id"]);
}

- (void) addPersonWithLink:(IACLink *)link {
    NSLog(@"Add Person With Id %@", [link.parameters objectForKey: @"id"]);
}

@end

//
//  IonModuleTests.m
//  Ion
//
//  Created by Andrew Hurst on 10/5/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "IonRouter.h"
#import "IonActionModule.h"

@interface IonModuleTests : XCTestCase

@end

@implementation IonModuleTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testRouter {
    IonModule *module;
    IonRouter *router, *secondaryRouter;
    IonLink *testLink;
    
    module = [[IonModule alloc] init];
    router = [[IonRouter alloc] init];
    secondaryRouter = [[IonRouter alloc] init];
    
    [router addComponent: secondaryRouter forKey: @"Main"];
    [secondaryRouter addComponent: module forKey: @"people"];
    
    testLink = [IonLink linkWithURLString: @"ion:///Main/People/?id=124425"
                                   reason: @"Push Notification"
                          andReferralLink: [IonLink referralLinkWithURLString: @"ion:///Events/?id=24456"]];
    
    [router invokeLink: testLink];
    return;
}

- (void)testActionModule {
    IonActionModule *module;
    IonRouter *router, *secondaryRouter;
    IonLink *testLink, *addLink;
    
    module = [[IonActionModule alloc] initWithTarget: self];
    router = [[IonRouter alloc] init];
    secondaryRouter = [[IonRouter alloc] init];
    
    
    [router addComponent: secondaryRouter forKey: @"Main"];
    [secondaryRouter addComponent: module forKey: @"people"];
    [module addAction: @selector(openPersonWithLink:) toEndpoint:@"Open"];
    [module addAction: @selector(addPersonWithLink:) toEndpoint:@"Add"];
    
    testLink = [IonLink linkWithURLString: @"ion:///Main/People/Open/?id=124425"
                                   reason: @"Push Notification"
                          andReferralLink: [IonLink referralLinkWithURLString: @"ion:///Events/?id=24456"]];
    
    addLink = [IonLink linkWithURLString: @"ion:///Main/People/Add/?id=12445673" andReason: @"Button Press"];
    
    [router invokeLink: testLink];
    return;
}

- (void) openPersonWithLink:(IonLink *)link {
    NSLog(@"Open Person With Id %@", [link.parameters objectForKey: @"id"]);
}

- (void) addPersonWithLink:(IonLink *)link {
    NSLog(@"Add Person With Id %@", [link.parameters objectForKey: @"id"]);
}


@end

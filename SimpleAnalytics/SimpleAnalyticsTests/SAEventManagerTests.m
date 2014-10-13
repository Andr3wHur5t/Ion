//
//  SAEventManagerTests.m
//  SimpleAnalytics
//
//  Created by Andrew Hurst on 10/10/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <SimpleAnalytics/SAEventManager.h>
#import <SimpleAnalytics/SAEvent.h>

@interface SAEventManagerTests : XCTestCase

@end

@implementation SAEventManagerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    for ( NSUInteger i = 0; i <= 750; ++i) {
        [[[SANamedEvent alloc]  initWithName: @"Test"] record];
    }
    
    return;
}



@end

//
//  IonPathTests.m
//  Ion
//
//  Created by Andrew Hurst on 8/1/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "IonPath.h"

@interface IonPathTests : XCTestCase

@end

@implementation IonPathTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

/**
 * Tests path creation at URL.
 */
- (void) testPathCreationFromURL {
    IonPath* path;
    NSURL* bundlePath;
    NSString *expected, *result;
    
    // Setup
    bundlePath = [[NSBundle mainBundle] bundleURL];
    path = [[IonPath alloc] initFromURL: bundlePath];
    
    expected = [bundlePath path];
    result = path.toString;
    
    // Run Test
    XCTAssert( [expected isEqualToString: result], @"Paths did not match");
    NSLog(@"<From URL> Result Path:\n%@ \nGoal Path:\n%@", result, expected);
}

/**
 * Test Appended Path Creation.
 */
- (void) testAppendedPathCreation {
    BOOL fail;
    IonPath* path;
    NSURL* bundlePath;
    NSString *expected, *result;
    
    // Setup
    fail = FALSE;
    bundlePath = [[NSBundle mainBundle] bundleURL];
    path = [[IonPath alloc] initWithPath:[[IonPath alloc] initFromURL:bundlePath]
                  appendedByElements:@[@"Hello",@"Me"]];
    expected = [[bundlePath path] stringByAppendingString:@"/Hello/Me"];
    result = path.toString;
    
    
    // Run Test
    fail = [result isEqualToString: expected];
    
    XCTAssert( fail, @"Paths did not match");
    NSLog(@"<From Appended Path> Result Path:\n%@ \nGoal Path:\n%@", result, expected);
}

/**
 * Tests Path To Sting Method
 */
- (void) testToString {
    NSArray* components;
    IonPath* path;
    NSString *result, *expected;
    
    // Parameters
    components = @[@"Hello",@"Me",@"Here.test"];
    expected = @"/Hello/Me/Here.test";
    
    // Run
    path = [[IonPath alloc] initFromComponents: components];
    result = path.toString;
    
    // Report
    XCTAssert( [expected isEqualToString: result] , @"Paths did not match");
    
     NSLog(@"<To String> Result Path:\n%@ \nGoal Path:\n%@", result, expected);
}


/**
 * Tests Components from URL.
 */
- (void) testComponentsFromURL {
    NSURL* target;
    NSArray *result, *expected;
    
    // Run
    target = [[NSURL alloc] initWithScheme:@"" host:@"" path:@"/me/you/him"];
    expected = @[@"me",@"you",@"him"];
    result = [IonPath componentsFromURL: target];
    
    
    // Check
    XCTAssert( [result isEqualToArray:  expected] , @"Objects do not match");
    NSLog(@"<Path Components> Got: %@\nExpected: %@",result, expected);
}


@end

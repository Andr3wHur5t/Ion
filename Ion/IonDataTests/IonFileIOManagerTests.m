//
//  IonFileIOManagerTests.m
//  Ion
//
//  Created by Andrew Hurst on 8/3/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSData+IonTypeExtension.h"
#import "IonFileIOmanager.h"
#import "IonFile.h"
#import "IonPath.h"

#define TargetFileName @"Cakfde.txt"

@interface IonFileIOManagerTests : XCTestCase

@end

@implementation IonFileIOManagerTests

- (void)setUp {
    [super setUp];
    NSLog(@"<Target> %@", [IonPath documentsDirectory]);
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark IO Tests

/**
 * Check Writeing a file in the application bundle by writeing it, then reading it.
 * This area of code is now dubed the file system triangle, because blocks randomly go missing here...
 */
- (void) testFileIOReadWrite {
    __block IonPath* targetPath;
    __block NSData *expected, *result;
    __block XCTestExpectation* completionException;
    __block BOOL called;
    
    // The block is being set To NULL in this function... WTF Why?
   
    // Construct
    called = false;
    targetPath = [[IonPath documentsDirectory] pathAppendedByElement: TargetFileName];
    expected = [NSData dataFromString:@"Hello There!"];
    
    // Do the test
    [self measureBlock: ^{
        result = NULL;
        completionException = [self expectationWithDescription:@"Read & Write Complete"];
        
        [IonFileIOmanager saveData: expected atPath: targetPath withCompletion: ^(NSError *error) {
            if ( error ) {
                [completionException fulfill];
                return;
            }
            
            [IonFileIOmanager openDataAtPath: targetPath withResultBlock: ^(id returnedObject) {
                result = returnedObject;
                [completionException fulfill];
            }];
        }];

    
        // Report
        [self waitForExpectationsWithTimeout: 0.5 handler: ^(NSError *error) {
            XCTAssert( [expected isEqualToData: result] , @"Output Didn't match expected.");
            called = TRUE;
        }];
    }];
    
    if ( !called )
        XCTFail(@"Was Not called.");
}

/**
 * Check Writeing a file in the application bundle by writeing it, then reading it.
 */
- (void) testNegitiveFileIOReadWrite {
    __block IonPath* targetPath;
    __block NSData *expected, *result;
    __block XCTestExpectation* completionException;
    __block BOOL called;
    
    // Construct
    called = false;
    targetPath = [[IonPath documentsDirectory] pathAppendedByElement: TargetFileName];
    expected = [NSData dataFromString:@"Hello There!"];
    
   // [self measureBlock: ^{
        result = NULL;
        // Do the test
        completionException = [self expectationWithDescription:@"Read & Write Complete"];
        [IonFileIOmanager saveData: [NSData dataFromString:@"Hello There! This is not the same!"] atPath: targetPath withCompletion: ^(NSError *error) {
            [IonFileIOmanager openDataAtPath: targetPath withResultBlock: ^(id returnedObject) {
                result = returnedObject;
                [completionException fulfill];
            }];
        }];
    
    
        // Report
        [self waitForExpectationsWithTimeout: 1 handler: ^(NSError *error) {
            XCTAssert( ![expected isEqualToData: result] , @"Output Didn't match expected.");
            called = TRUE;
        }];
   // }];
    // Clean Up
    [IonFileIOmanager deleteItem: targetPath withCompletion: NULL];
    
    
    if ( !called )
        XCTFail(@"Was Not called.");
}

/**
 * Checks if file delete works, by cereating a file, then deleting it.
 */
- (void) testFileDelete {
    __block IonPath* targetPath;
    __block NSError* resError;
    __block XCTestExpectation* completionException;
    __block BOOL called;
    
    // Construct
    targetPath = [[IonPath documentsDirectory] pathAppendedByElement: TargetFileName];
    called = false;
    
    [self measureBlock: ^{
        resError = NULL;
        // Do the test
        completionException = [self expectationWithDescription:@"Read & Write Complete"];
        [IonFileIOmanager saveData: [NSData dataFromString:@"Bye Bye!"] atPath: targetPath withCompletion: ^(NSError *lError) {
            if ( !lError )
                [IonFileIOmanager deleteItem: targetPath withCompletion:^(NSError *resultError) {
                    resError = resultError;
                    [completionException fulfill];
                }];
        }];
        
        
        // Report
        [self waitForExpectationsWithTimeout: 1 handler: ^(NSError *error) {
            XCTAssert( !resError , @"An error was returned.");
            called = TRUE;
        }];
    }];
    
    if ( !called )
        XCTFail(@"Was Not called.");
    
}

/**
 * Checks if invalid file delete works, by deleting a non-exsitinsg file then checking for an error.
 */
- (void) testNegitiveFileDelete {
    __block IonPath* targetPath;
    __block NSError* resError;
    __block XCTestExpectation* completionException;
    __block BOOL called;
    
    // Construct
    called = false;
    targetPath = [[IonPath documentsDirectory] pathAppendedByElement: @"thisIsNotAFile.wtf"];
    
    // Make sure its not there before testing...
    [IonFileIOmanager deleteItem: targetPath
                  withCompletion: ^(NSError *resultError) {
        // Test
        [self measureBlock: ^{
            // Do the test
            completionException = [self expectationWithDescription:@"Delete Complete"];
        
            [IonFileIOmanager deleteItem: targetPath withCompletion:^(NSError *resultError) {
                resError = resultError;
                [completionException fulfill];
            }];
        
            // Report
            [self waitForExpectationsWithTimeout: 1 handler: ^(NSError *error) {
                XCTAssert( (BOOL)resError , @"Output was not an error!");
                called = TRUE;
            }];
        }];
    }];
    
    if ( !called )
        XCTFail(@"Was Not called.");
}

/**
 * Tests Item Lists, by placing a bunch of items, then reading the list for their names.
 */
- (void) testDirectoryListing {
    __block IonPath* targetPath;
    __block NSArray *targetItems, *resultArray;
    __block XCTestExpectation* completionException;
    __block BOOL called;
    
    called = false;
    targetPath = [IonPath documentsDirectory];
    targetItems = @[ @"hello.t", @"here.there", @"xcode.test" ];

    
    for ( NSString* item in targetItems)
        [IonFileIOmanager saveData: [NSData dataFromString: item]
                            atPath: [targetPath pathAppendedByElement: item]
                    withCompletion: ^(NSError* err) {
                        completionException = [self expectationWithDescription:@"Delete Complete"];
                        
                        // List Items
                        [IonFileIOmanager listItemsAtPath:targetPath withResultBlock:^(id returnedObject) {
                            resultArray = returnedObject;
                            [completionException fulfill];
                        }];
                        // Report
                        [self waitForExpectationsWithTimeout: 1 handler: ^(NSError *error) {
                            XCTAssert( [targetItems isEqualToArray: resultArray], @"The result dose not meet our expetatons!");
                            called = TRUE;
                        }];
                    }];
    
    // Clean the enviorment!
    
    if ( !called )
        XCTFail(@"Was Not called.");
}





#pragma mark Test Utilities


@end

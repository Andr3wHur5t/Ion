//
//  IonSimpleCacheTests.m
//  Ion
//
//  Created by Andrew Hurst on 8/7/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "IonSimpleCache.h"
#import "IonPath.h"

@interface IonSimpleCacheTests : XCTestCase {
    BOOL cacheIsReady;
    IonSimpleCache* simpleCache;
    IonDirectory* simpleCacheRefrenceDirectory;
    IonPath* ionCachePath;
}


@end


/**
 * Note we can't test the Simple cache because it is Block Based and XCTest is giving us issures... :(
 */
@implementation IonSimpleCacheTests

- (void)setUp {
    [super setUp];
    cacheIsReady = FALSE;
    ionCachePath = [[IonPath cacheDirectory] pathAppendedByElement:@"Unit Test Path"];
    simpleCache = [[IonSimpleCache alloc] initAtPath:ionCachePath withLoadCompletion: ^(NSError *error) {
        cacheIsReady = TRUE;
    }];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testCache {
}


@end

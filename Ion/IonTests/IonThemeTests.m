//
//  IonThemeObjectTests.m
//  Ion
//
//  Created by Andrew Hurst on 8/1/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "IonTheme.h"
#import <IonData/NSData+IonTypeExtension.h>

@interface IonThemeObjectTests : XCTestCase {
    IonTheme* target;
}

/**
 * Gets the raw JSON for the theme.
 * @returns {NSString*} the raw theme
 */
+ (NSString*) rawTheme;

@end

@implementation IonThemeObjectTests

- (void)setUp {
    [super setUp];
    target = [[IonTheme alloc] initWithConfiguration:[NSJSONSerialization JSONObjectWithData:[NSData dataFromString: [IonThemeObjectTests rawTheme]] options:0 error:NULL]];
    
}

- (void)tearDown {
    
    target = NULL;
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testStyleForKey {
    // This is an example of a functional test case.
    
    
    XCTAssert( TRUE, @"Pass");
}


/**
 * Gets the raw JSON for the theme.
 * @returns {NSString*} the raw theme
 */
+ (NSString*) rawTheme {
    return @"{\"name\":\"testTheme\",\"type\":\"theme\",\"colors\":{\"WHITE\":\"#FFFFFF\",\"BLACK\":\"#000000\",\"TROLOLO\":\"Purple\",\"LEET\":\"#001337\",\"green\":\"TROLOLO\",\"Purple\":\"#921\",\"yellow\":\"green\",\"wow\":\"much\",\"much\":\"wow\",\"cleanWhite\":\"#F5F5F5\"},\"images\":{\"Image1\":\"Path1.png\",\"Image2\":\"Path2.png\"},\"kvp\":{\"PointlessProperty\":\"PointlessValue\",\"UsefulProperty\":\"UsefulValue\"},\"gradients\":{\"Spottr\":{\"type\":\"linear\",\"angle\":90,\"colorWeights\":[{\"color\":\"#f1592a\",\"weight\":1.0},{\"color\":\"#ef4036\",\"weight\":0.0}]},\"Meadow\":{\"type\":\"linear\",\"angle\":90,\"colorWeights\":[{\"color\":\"#AFD044\",\"weight\":1.0},{\"color\":\"#43B34E\",\"weight\":0.0}]},\"Abyss\":{\"type\":\"linear\",\"angle\":90,\"colorWeights\":[{\"color\":\"#1A75B8\",\"weight\":1.0},{\"color\":\"#272662\",\"weight\":0.0}]},\"Sky\":{\"type\":\"linear\",\"angle\":90,\"colorWeights\":[{\"color\":\"#9FDCF7\",\"weight\":1.0},{\"color\":\"#1EB2EE\",\"weight\":0.0}]},\"Inferno\":{\"type\":\"linear\",\"angle\":90,\"colorWeights\":[{\"color\":\"#ED413E\",\"weight\":1.0},{\"color\":\"#BF2232\",\"weight\":0.0}]},\"Mocha\":{\"type\":\"linear\",\"angle\":90,\"colorWeights\":[{\"color\":\"#B17C52\",\"weight\":1.0},{\"color\":\"#5F4023\",\"weight\":0.0}]},\"Tranquil\":{\"type\":\"linear\",\"angle\":90,\"colorWeights\":[{\"color\":\"#35A6AF\",\"weight\":1.0},{\"color\":\"#71B496\",\"weight\":0.0}]},\"Nebula\":{\"type\":\"linear\",\"angle\":90,\"colorWeights\":[{\"color\":\"#D65068\",\"weight\":1.0},{\"color\":\"#323B8D\",\"weight\":0.0}]},\"Ash\":{\"type\":\"linear\",\"angle\":90,\"colorWeights\":[{\"color\":\"#808284\",\"weight\":1.0},{\"color\":\"#58585A\",\"weight\":0.0}]},\"Citrus\":{\"type\":\"linear\",\"angle\":90,\"colorWeights\":[{\"color\":\"#FAAF4D\",\"weight\":1.0},{\"color\":\"#F59432\",\"weight\":0.0}]},\"Cedar\":{\"type\":\"linear\",\"angle\":90,\"colorWeights\":[{\"color\":\"#149348\",\"weight\":1.0},{\"color\":\"#0B693B\",\"weight\":0.0}]},\"Nightfall\":{\"type\":\"linear\",\"angle\":90,\"colorWeights\":[{\"color\":\"#272461\",\"weight\":1.0},{\"color\":\"#293A8D\",\"weight\":0.0}]},\"Oceanview\":{\"type\":\"linear\",\"angle\":90,\"colorWeights\":[{\"color\":\"#1CA59B\",\"weight\":1.0},{\"color\":\"#EA463E\",\"weight\":0.0}]},\"Scorch\":{\"type\":\"linear\",\"angle\":90,\"colorWeights\":[{\"color\":\"#FAAE4C\",\"weight\":1.0},{\"color\":\"#EE453E\",\"weight\":0.0}]},\"Mint\":{\"type\":\"linear\",\"angle\":90,\"colorWeights\":[{\"color\":\"#29B68D\",\"weight\":1.0},{\"color\":\"#32B478\",\"weight\":0.0}]},\"Cream\":{\"type\":\"linear\",\"angle\":90,\"colorWeights\":[{\"color\":\"#E0A488\",\"weight\":1.0},{\"color\":\"#C3996F\",\"weight\":0.0}]},\"Princess\":{\"type\":\"linear\",\"angle\":90,\"colorWeights\":[{\"color\":\"#E02977\",\"weight\":1.0},{\"color\":\"#D8215E\",\"weight\":0.0}]},\"Sanguine\":{\"type\":\"linear\",\"angle\":90,\"colorWeights\":[{\"color\":\"#912835\",\"weight\":1.0},{\"color\":\"#6E2B37\",\"weight\":0.0}]},\"Royal\":{\"type\":\"linear\",\"angle\":90,\"colorWeights\":[{\"color\":\"#8F2C8E\",\"weight\":1.0},{\"color\":\"#2A2462\",\"weight\":0.0}]},\"Arctic\":{\"type\":\"linear\",\"angle\":90,\"colorWeights\":[{\"color\":\"#8FBDE3\",\"weight\":1.0},{\"color\":\"#D0D2D4\",\"weight\":0.0}]},\"Pebble\":{\"type\":\"linear\",\"angle\":90,\"colorWeights\":[{\"color\":\"#C2B49C\",\"weight\":1.0},{\"color\":\"#9A867B\",\"weight\":0.0}]},\"Hive\":{\"type\":\"linear\",\"angle\":90,\"colorWeights\":[{\"color\":\"#F5EC48\",\"weight\":1.0},{\"color\":\"#FAB14C\",\"weight\":0.0}]},\"Onyx\":{\"type\":\"linear\",\"angle\":90,\"colorWeights\":[{\"color\":\"#383839\",\"weight\":1.0},{\"color\":\"#020202\",\"weight\":0.0}]},\"Clean\":{\"type\":\"linear\",\"angle\":90,\"colorWeights\":[{\"color\":\"cleanWhite\",\"weight\":1.0},{\"color\":\"cleanWhite\",\"weight\":0.25},{\"color\":\"#9C9C9C\",\"weight\":0.0}]},\"Ion\":{\"type\":\"linear\",\"angle\":90,\"colorWeights\":[{\"color\":\"#33ACE0\",\"weight\":1.0},{\"color\":\"#1274B9\",\"weight\":0.0}]},\"OceanviewTest\":{\"type\":\"linear\",\"angle\":75,\"colorWeights\":[{\"color\":\"#1CA59B\",\"weight\":1.0},{\"color\":\"#FFFFFF\",\"weight\":0.25},{\"color\":\"#EA463E\",\"weight\":0.0}]}},\"styles\":{\"default\":{\"background\":{\"type\":\"color\",\"name\":\"#0000\"},\"fontColor\":{\"type\":\"color\",\"name\":\"BLACK\"}},\"body\":{\"background\":{\"type\":\"gradient\",\"name\":\"Onyx\"},\"fontColor\":{\"type\":\"color\",\"name\":\"BLACK\"}},\"titleBar\":{\"background\":{\"type\":\"gradient\",\"name\":\"Royal\"},\"fontColor\":{\"type\":\"color\",\"name\":\"BLACK\"}},\"cls_simpleStyle\":{\"background\":{\"type\":\"color\",\"name\":\"BLACK\"},\"fontColor\":{\"type\":\"color\",\"name\":\"BLACK\"}},\"id_simpleStyle\":{\"background\":{\"type\":\"gradient\",\"name\":\"Inferno\"}},\"cls_secondaryStyle\":{\"background\":{\"type\":\"color\",\"name\":\"#ffffff\"},\"fontColor\":{\"type\":\"color\",\"name\":\"BLACK\"},\"cornerRadius\":10.0,\"shadow\":{\"color\":\"BLACK\",\"radius\":10,\"offset\":{\"x\":20,\"y\":20}},\"border\":{\"color\":\"#1CA59B\",\"width\":10},\"parameters\":{\"data\":\"things,andstuff\"}}}}";
}


@end

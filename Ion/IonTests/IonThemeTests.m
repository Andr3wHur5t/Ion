//
//  IonThemeObjectTests.m
//  Ion
//
//  Created by Andrew Hurst on 8/1/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "IonTheme.h"
#import <IonData/UIColor+IonColor.h>
#import <IonData/IonGradientConfiguration.h>


/**
 * Hex Stash: some valid hex colors
 */
#define sColorCleanWhite @"#F5F5F5"
#define sColorNicePurple @"#23F275"
#define sColorGoodBrown  @"#748A23"
#define sColorCoolGreen  @"#F423E7"

/**
 * values to check for.
 */
#define sColorKey @"white"
#define sColorHex sColorCleanWhite

/**
 * Color resolve reference test
 */
#define sColorReferenceOneKey @"stuff"
#define sColorReferenceTwoKey @"things"

/**
 * Color cyclic reference test
 */
#define sColorCyclicReferenceOneKey @"wow"
#define  sColorCyclicReferenceTwoKey @"much"

/**
 * Gradient configurations test
 */
#define sGradientPreresolvedKey @"preresolvedGradient"
#define sGradientUnresolvedKey @"unresolvedGradient"
#define sGradientLinearPreresolvedKey @"preresolvedLinearGradient"
#define sGradientLinearAngleTest @45.5



@interface IonThemeObjectTests : XCTestCase {
    IonTheme* target;
}

/**
 * Gets The Minimized Theme
 */
+ (NSDictionary*) minimizedThemeConfiguration;

#pragma mark Color Weight Arrays
/**
 * Gets a static resolved color weight array
 */
+ (NSArray*) resolvedColorWeightMap;
/**
 * Gets a static unresolved color weight array
 */
+ (NSArray*) unresolvedColorWeightMap;

@end

@implementation IonThemeObjectTests

- (void)setUp {
    [super setUp];
    target = [[IonTheme alloc] initWithConfiguration: [IonThemeObjectTests minimizedThemeConfiguration]];;
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


#pragma mark Gradient Resolution
// NOTE: gradients are dependent on color resolution

/**
 * Check For General Gradient Resolution.
 */
- (void) testGeneralGradientReslution {
    IonGradientConfiguration *result, *expected;
    NSArray* colorWeights;
    
    colorWeights = [IonColorWeight colorWeightArrayFromMap: [IonThemeObjectTests resolvedColorWeightMap] andAttrubutes: target];
    expected = [[IonGradientConfiguration alloc] initWithColorWeights:colorWeights ];
    result = [target resolveGradientAttribute: sGradientLinearPreresolvedKey];
    
    XCTAssert( [expected isEqual: result], @"Configuration Mismatch.");
}

/**
 * Checks For Linear Geradient Resolution.
 */
- (void) testLinearGradientResolution {
    IonGradientConfiguration *result, *expected;
    NSArray* colorWeights;
    NSNumber* angle;
    
    
    colorWeights = [IonColorWeight colorWeightArrayFromMap: [IonThemeObjectTests resolvedColorWeightMap] andAttrubutes: target];
    angle = sGradientLinearAngleTest;
    expected = [[IonLinearGradientConfiguration alloc] initWithColor:colorWeights andAngel: [angle floatValue] ];
    
    result = [target resolveGradientAttribute: sGradientLinearPreresolvedKey];
    NSLog(@"<asfid> Grad res:%@, exp:%@", result, expected);
    XCTAssert( [expected isEqual: result], @"Configuration Mismatch.");
}

#pragma mark Color Resolution

/**
 * Checks for color hex resolution
 * NOTE: dependent on Color from hex string.
 */
- (void) testColorHexResolution {
    UIColor *result, *expected;
    
    // Get Items
    expected = [UIColor colorFromHexString: sColorHex ];
    result = [target colorFromMapWithKey: sColorKey ];
    
    // Test
    XCTAssert( [expected isEqual: result], @"Color is not the expected color. exp: %@ got: %@", [expected toHex], [result toHex]);
}

/**
 * Checks for color reference resolution
 * NOTE: dependent on hex resolution
 */
- (void) testColorReferenceResolution {
    UIColor *result, *expected;
    
    // Get Items
    expected = [UIColor colorFromHexString: sColorHex];
    result = [target colorFromMapWithKey: sColorReferenceTwoKey]; // get from the top key
    
    // Test
    XCTAssert( [expected isEqual: result], @"Color is not the expected color. exp:%@ got:%@", [expected toHex], [result toHex]);
}

/**
 * Checks for cyclic color reference resolution
 */
- (void) testColorCyclicColorReferenceResolution {
    UIColor* result;
    
    // Get Items
    result = [target colorFromMapWithKey: sColorCyclicReferenceOneKey];
    
    // Test
    XCTAssert( !result , @"Color is not NULL. got:%@", [result toHex]);
}


#pragma Mark Generation Utilities

/**
 * Gets a static resolved color weight array
 */
+ (NSArray*) resolvedColorWeightMap {
    return  @[
                @{ sGradientColorKey: sColorNicePurple, sGradientWeightKey: @1.0 },
                @{ sGradientColorKey: sColorGoodBrown, sGradientWeightKey: @0.8 },
                @{ sGradientColorKey: sColorCoolGreen, sGradientWeightKey: @0.2 },
                @{ sGradientColorKey: sColorCleanWhite, sGradientWeightKey: @0.0 }
            ];
}

/**
 * Gets a static unresolved color weight array
 */
+ (NSArray*) unresolvedColorWeightMap {
    return  @[
                @{ sGradientColorKey: sColorNicePurple, sGradientWeightKey: @0.9 },
                @{ sGradientColorKey: sColorGoodBrown, sGradientWeightKey: @0.75 },
                @{ sGradientColorKey: sColorCoolGreen, sGradientWeightKey: @0.255 },
                @{ sGradientColorKey: sColorCleanWhite, sGradientWeightKey: @0.1 }
              ];
}

/**
 * Gets The Minimized Theme
 */
+ (NSDictionary*) minimizedThemeConfiguration {
    return @{
             // Color Tests
             sColorsGroupKey: @{
                     // Hex Resolution Test
                     sColorKey: sColorHex,
                     
                     // Refrence Test
                     sColorReferenceOneKey: sColorKey,
                     sColorReferenceTwoKey: sColorReferenceOneKey,
                     
                     // Cicilic Refrence Test
                     sColorCyclicReferenceOneKey: sColorCyclicReferenceTwoKey,
                     sColorCyclicReferenceTwoKey: sColorCyclicReferenceOneKey
                     
                     // Unresolved Gradient Colors
                     },
             sGradientsGroupKey: @{
                     // Preresolved Gradient test
                     sGradientPreresolvedKey: @{
                             sGradientColorWeightsKey: [IonThemeObjectTests resolvedColorWeightMap]
                             },
                     // Unresolved Gradient test
                     sGradientUnresolvedKey: @{
                             
                             },
                     // Preresolved Linear Gradient Test
                     sGradientLinearPreresolvedKey: @{
                        sGradientTypeKey: sGradientLinearKey,
                        sGradientLinearAngleKey: sGradientLinearAngleTest,
                        sGradientColorWeightsKey: [IonThemeObjectTests resolvedColorWeightMap]
                        }
                    },
             sImagesGroupKey: @{
                     
                     },
             sKVPGroupKey: @{
                     
                     },
             sStylesGroupKey: @{
                     
                     
                     }
             };
}

@end

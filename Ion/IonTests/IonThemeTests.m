//
//  IonThemeObjectTests.m
//  Ion
//
//  Created by Andrew Hurst on 8/1/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "IonTheme.h"
#import "IonStyle.h"
#import "IonStyle+IonStdStyleApplyMethods.h"
#import <IonData/UIColor+IonColor.h>
#import <IonData/IonGradientConfiguration.h>
#import <IonData/IonKeyValuePair.h>


/**
 * Hex Stash: some valid hex colors
 */
#define sColorCleanWhiteKey @"cleanWhite"
#define sColorCleanWhite @"#F5F5F5"

#define sColorNicePurpleKey @"nicePurple"
#define sColorNicePurple @"#23F275"

#define sColorGoodBrownKey @"goodBrown"
#define sColorGoodBrown  @"#748A23"

#define sColorCoolGreenKey @"coolGreen"
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

/**
 * KVP Resolution
 */
#define sKVPItemKey @"itemOne"
#define sKVPItemObject @[@"hello"]

/**
 * Style Resolution
 */
#define sStyleItemKey @"itemOne"
#define sStyleCornerRadiusValue @5




@interface IonThemeObjectTests : XCTestCase {
    IonTheme* target;
}

/**
 * Gets The Minimized Theme
 */
+ (NSDictionary*) minimizedTestThemeConfiguration;

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
    target = [[IonTheme alloc] initWithConfiguration: [IonThemeObjectTests minimizedTestThemeConfiguration]];
}

- (void)tearDown {
    target = NULL;
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}




#pragma mark Color Weights Resolution
// NOTE: Dependent on color resolution.

/**
 * Check if color weights resolve correctly.
 */
- (void) testColorWeightsResolution {
    __block NSArray *expected, *result;
    
    [self measureBlock:^{
        expected = [IonColorWeight colorWeightArrayFromMap: [IonThemeObjectTests resolvedColorWeightMap]
                                             andAttrubutes: target];
        result = [IonColorWeight colorWeightArrayFromMap: [IonThemeObjectTests unresolvedColorWeightMap]
                                           andAttrubutes: target];
    
        XCTAssert( [expected isEqualToArray: result], @"Configuration Mismatch.");
    }];
}

#pragma mark Gradient Resolution
// NOTE: gradients are dependent on color weight resolution

/**
 * Check For General Gradient Resolution.
 */
- (void) testGeneralGradientReslution {
    __block IonGradientConfiguration *result, *expected;
    __block NSArray* colorWeights;
    
    [self measureBlock:^{
        colorWeights = [IonColorWeight colorWeightArrayFromMap: [IonThemeObjectTests resolvedColorWeightMap]
                                                 andAttrubutes: target];
        expected = [[IonGradientConfiguration alloc] initWithColorWeights:colorWeights ];
        result = [target resolveGradientAttribute: sGradientLinearPreresolvedKey];
    
        XCTAssert( [expected isEqual: result], @"Configuration Mismatch.");
    }];
}

/**
 * Checks For Linear Geradient Resolution.
 */
- (void) testLinearGradientResolution {
    __block IonGradientConfiguration *result, *expected;
    __block NSArray* colorWeights;
    __block NSNumber* angle;
    
    [self measureBlock:^{
        colorWeights = [IonColorWeight colorWeightArrayFromMap: [IonThemeObjectTests resolvedColorWeightMap]
                                                 andAttrubutes: target];
        angle = sGradientLinearAngleTest;
        expected = [[IonLinearGradientConfiguration alloc] initWithColor:colorWeights
                                                                andAngel: [angle floatValue] ];
    
        result = [target resolveGradientAttribute: sGradientLinearPreresolvedKey];
    
        XCTAssert( [expected isEqual: result], @"Configuration Mismatch.");
    }];
}

#pragma mark Color Resolution

/**
 * Checks for color hex resolution
 * NOTE: dependent on Color from hex string.
 */
- (void) testColorHexResolution {
    __block UIColor *result, *expected;
    [self measureBlock:^{
        // Get Items
        expected = [UIColor colorFromHexString: sColorHex ];
        result = [target colorFromMapWithKey: sColorKey ];
    
        // Test
        XCTAssert( [expected isEqual: result], @"Color is not the expected color. exp: %@ got: %@", [expected toHex], [result toHex]);
    }];
}

/**
 * Checks for color reference resolution
 * NOTE: dependent on hex resolution
 */
- (void) testColorReferenceResolution {
    __block UIColor *result, *expected;
    
    [self measureBlock:^{
        // Get Items
        expected = [UIColor colorFromHexString: sColorHex];
        result = [target colorFromMapWithKey: sColorReferenceTwoKey]; // get from the top key
    
        // Test
        XCTAssert( [expected isEqual: result], @"Color is not the expected color. exp:%@ got:%@", [expected toHex], [result toHex]);
    }];
}

/**
 * Checks for cyclic color reference resolution
 */
- (void) testColorCyclicColorReferenceResolution {
    __block UIColor* result;
    
    [self measureBlock:^{
        // Get Items
        result = [target colorFromMapWithKey: sColorCyclicReferenceOneKey];
    
        // Test
        XCTAssert( !result , @"Color is not NULL. got:%@", [result toHex]);
    }];
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
                @{ sGradientColorKey: sColorNicePurpleKey, sGradientWeightKey: @1.0 },
                @{ sGradientColorKey: sColorGoodBrownKey, sGradientWeightKey: @0.8 },
                @{ sGradientColorKey: sColorCoolGreenKey, sGradientWeightKey: @0.2 },
                @{ sGradientColorKey: sColorCleanWhiteKey, sGradientWeightKey: @0.0 }
              ];
}

/**
 * Gets a static resolved style.
 */
+ (NSDictionary*) staticTestStyle {
    return @{
             sStyleSTDBackgroundKey: sColorCleanWhiteKey,
             sStyleSTDCornerRadiusKey: @30,
             sStyleSTDShadowKey:@{
                     sShadowColorKey:sColorGoodBrown,
                     sShadowOffsetKey:@{ @"x":@20,@"y":@15 },
                     sShadowRadiusKey: @13
                     }
             };
}

/**
 * Gets the static test color map.
 */
+ (NSDictionary*) staticTestColorMap {
    return @{
             // Hex Resolution Test
             sColorKey: sColorHex,
             
             // Refrence Test
             sColorReferenceOneKey: sColorKey,
             sColorReferenceTwoKey: sColorReferenceOneKey,
             
             // Cicilic Refrence Test
             sColorCyclicReferenceOneKey: sColorCyclicReferenceTwoKey,
             sColorCyclicReferenceTwoKey: sColorCyclicReferenceOneKey,
             
             // Unresolved Gradient Colors
             sColorCleanWhiteKey: sColorCleanWhite,
             sColorNicePurpleKey: sColorNicePurple,
             sColorGoodBrownKey: sColorGoodBrown,
             sColorCoolGreenKey: sColorCoolGreen
             };
}

/**
 * Gets the static gradient map
 */
+ (NSDictionary*) staticTestGradientMap {
    return @{
             // Preresolved Gradient test
             sGradientPreresolvedKey: @{
                     sGradientColorWeightsKey: [IonThemeObjectTests resolvedColorWeightMap]
                     },
             // Unresolved Gradient test
             sGradientUnresolvedKey: @{ },
             // Preresolved Linear Gradient Test
             sGradientLinearPreresolvedKey: @{
                     sGradientTypeKey: sGradientLinearKey,
                     sGradientLinearAngleKey: sGradientLinearAngleTest,
                     sGradientColorWeightsKey: [IonThemeObjectTests resolvedColorWeightMap]
                     }
             };
}

/**
 * Gets The Minimized Theme
 */
+ (NSDictionary*) minimizedTestThemeConfiguration {
    return @{
             // Color Tests
             sColorsGroupKey: [IonThemeObjectTests staticTestColorMap],
             sGradientsGroupKey: [IonThemeObjectTests staticTestGradientMap],
             sKVPGroupKey: @{
                     // KVP Item Resolution
                     sKVPItemKey: sKVPItemObject
                     },
             sStylesGroupKey: @{
                     sStyleItemKey: [IonThemeObjectTests staticTestStyle]
                     }
             };
}

@end

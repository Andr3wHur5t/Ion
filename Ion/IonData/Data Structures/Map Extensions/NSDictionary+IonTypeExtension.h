//
//  NSDictionary+IonTypeExtension.h
//  Ion
//
//  Created by Andrew Hurst on 7/22/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <FOUtilities/FOUtilities.h>

@class IonImageRef;
@class IonColorWeight;
@class IonGradientConfiguration;
@class IonLinearGradientConfiguration;


/**
 * Contains commonly used dictionary utilities, as well as Ion type conversions.
 * Type conversion function name notation is as fallows: <typeShortName>forKey:(id) key;
 * if the type is derived from a dictionary you should also use: to<typeShortName>;
 */
@interface NSDictionary (IonTypeExtension)
#pragma mark Gradients
/**
 * Gets the IonColorWeight of the keyed value.
 * @param key - the key to get the value from.
 */
- (IonColorWeight *)colorWeightForKey:(id) key;

/**
 * Gets the IonColorWeight equivalent of the dictionary.
 */
- (IonColorWeight *)toColorWeight;

/**
 * Gets an NSArray of IonColorWeights from the keyed value.
 * @param key - the key to get the value from.
 */
- (NSArray *)colorWeightsForKey:(id) key;

/**
 * Gets the IonGradientConfiguration of the keyed value.
 * @param key - the key to get the value from.
 */
- (IonGradientConfiguration *)gradientConfigurationForKey:(id) key;

/**
 * Gets the IonGradientConfiguration equivalent of the dictionary.
 */
- (IonGradientConfiguration *)toGradientConfiguration;

/**
 * Gets the IonLinearGradientConfiguration of the keyed value.
 * @param key - the key to get the value from.
 */
- (IonLinearGradientConfiguration*) linearGradientConfigurationForKey:(id) key;

/**
 * Gets the IonGradientConfiguration equivalent of the dictionary.
 * @retruns {IonColorWeight*} a valid IonLinearGradientConfiguration, or NULL if invalid.
 */
- (IonLinearGradientConfiguration*) toLinearGradientConfiguration;

/**
 * Gets the IonImageRef of the keyed value.
 * @param key - the key to get the value from.
 * @retruns {IonImageRef*} a valid IonImageRef, or NULL if invalid.
 */
- (IonImageRef*) imageRefFromKey:(id) key;
@end

#pragma mark Color Weight
static NSString* sIonColorKey = @"color";
static NSString* sIonColorWeightsKey = @"colorWeights";
static NSString* sIonWeightKey = @"weights";

#pragma mark Gradients
static NSString* sIonGradientTypeKey = @"type";
static NSString* sIonGradientTypeLinear = @"linear";
static NSString* sIonGradientTypeRadial = @"radial";

static NSString* sIonGradientAngleKey = @"angle";

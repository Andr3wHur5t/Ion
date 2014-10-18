//
//  NSDictionary+IonTypeExtension.m
//  Ion
//
//  Created by Andrew Hurst on 7/22/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "NSDictionary+IonTypeExtension.h"
#import <FOUtilities/FOUtilities.h>
#import "IonKeyValuePair.h"
#import "IonImageRef.h"
#import "IonGradientConfiguration.h"

// Enviorment variables
#define DebugIonTheme [[[[NSProcessInfo processInfo] environment] objectForKey: @"DebugIonTheme"] boolValue]
#define DebugIonThemeEmpty [[[[NSProcessInfo processInfo] environment] objectForKey: @"DebugIonThemeEmpty"] boolValue]

// Log Functions
#define IonReport(args...) if( DebugIonTheme ) NSLog(@"%s - %@",__PRETTY_FUNCTION__, [NSString stringWithFormat: args]);
#define IonReportEmpty(args...) if( DebugIonThemeEmpty ) IonReport(args);

@implementation NSDictionary (IonTypeExtension)

/**
 * Gets the IonColorWeight of the keyed value.
 * @param {id} the key to get the value from.
 * @retruns {IonColorWeight*} a valid IonColorWeight, or NULL if invalid.
 */
- (IonColorWeight*) colorWeightForKey:(id) key {
    NSDictionary* dict;
    
    NSParameterAssert( key );
    if ( !key ) {
        IonReport( @"No key specified." );
        return NULL;
    }
    
    dict = [self dictionaryForKey: key];
    if ( !dict )
        return NULL;
    
    return [dict toColorWeight];
}

/**
 * Gets the IonColorWeight equivalent of the dictionary.
 * @retruns {IonColorWeight*} a valid IonColorWeight, or NULL if invalid.
 */
- (IonColorWeight*) toColorWeight {
    IonColorWeight* result;
    UIColor* color;
    NSNumber* weight;
    
    color = [self colorFromKey: sIonColorKey];
    weight = [self numberForKey: sIonWeightKey];
    if ( !color || !weight )
        return NULL;
    
    result = [[IonColorWeight alloc] initWithColor: color andWeight: [weight floatValue]];
    return result;
}

/**
 * Gets an NSArray of IonColorWeights from the keyed value.
 * @param {id} the key to get the value from.
 * @retruns {NSArray*} a valid NSArray of IonColorWeights, or NULL if invalid.
 */
- (NSArray*) colorWeightsForKey:(id) key {
    NSDictionary* dict;
    NSArray *rawColorWeights;
    NSMutableArray* colorWeights;
    
    NSParameterAssert( key );
    if ( !key ) {
        IonReport( @"No key specified." );
        return NULL;
    }
    
    dict = [self dictionaryForKey: key];
    if ( !dict )
        return NULL;
    
    
    rawColorWeights = [self arrayForKey: sIonWeightKey];
    if ( !rawColorWeights )
        return NULL;
    
    colorWeights = [[NSMutableArray alloc] init];
    for ( NSDictionary* cw in rawColorWeights )
        [colorWeights addObject: [cw toColorWeight]];
    
    return colorWeights;
}

/**
 * Gets the IonGradientConfiguration of the keyed value.
 * @param {id} the key to get the value from.
 * @retruns {IonGradientConfiguration*} a valid IonGradientConfiguration, or NULL if invalid.
 */
- (IonGradientConfiguration*) gradientConfigurationForKey:(id) key {
    NSDictionary* dict;
    NSParameterAssert( key );
    if ( !key ) {
        IonReport( @"No key specified." );
        return NULL;
    }
    
    dict = [self dictionaryForKey: key];
    if ( !dict )
        return NULL;
        
    return [dict toGradientConfiguration];
}

/**
 * Gets the IonGradientConfiguration equivalent of the dictionary.
 * @retruns {IonGradientConfiguration*} a valid IonGradientConfiguration, or NULL if invalid.
 */
- (IonGradientConfiguration*) toGradientConfiguration {
    IonGradientConfiguration* gradConfig;
    NSString* type;
    
    type = [self stringForKey: sIonGradientTypeKey];
    if ( !type )
        return NULL;
        
    if ( [type isEqualToString: sIonGradientTypeLinear] )
        gradConfig = [self toLinearGradientConfiguration];
    else
        gradConfig = [self toLinearGradientConfiguration];
    
    return gradConfig;
}

/**
 * Gets the IonLinearGradientConfiguration of the keyed value.
 * @param {id} the key to get the value from.
 * @retruns {IonLinearGradientConfiguration*} a valid IonLinearGradientConfiguration, or NULL if invalid.
 */
- (IonLinearGradientConfiguration*) linearGradientConfigurationForKey:(id) key {
    NSDictionary* dict;
    NSParameterAssert( key );
    if ( !key ) {
        IonReport( @"No key specified." );
        return NULL;
    }
    
    dict = [self dictionaryForKey: key];
    if ( !dict )
        return NULL;
    
    return [dict toLinearGradientConfiguration];
}

/**
 * Gets the IonGradientConfiguration equivalent of the dictionary.
 * @retruns {IonColorWeight*} a valid IonLinearGradientConfiguration, or NULL if invalid.
 */
- (IonLinearGradientConfiguration*) toLinearGradientConfiguration {
    NSNumber* angle;
    NSArray* colorWeights;
    
    colorWeights = [self colorWeightsForKey: sIonColorWeightsKey];
    if ( !colorWeights )
        return NULL;
    
    angle = [self numberForKey: sIonGradientAngleKey];
    if ( !angle ) {
        IonReport( @"No valid angle specified defaulting to 90" );
        angle = @90.0f;
    }
    
    return [[IonLinearGradientConfiguration alloc] initWithColor: colorWeights andAngel: [angle floatValue]];
}


/**
 * Gets the IonImageRef of the keyed value.
 * @param {id} the key to get the value from.
 * @retruns {IonImageRef*} a valid IonImageRef, or NULL if invalid.
 */
- (IonImageRef*) imageRefFromKey:(id) key {
    NSString* fileNameString;
    IonImageRef* result;
    NSParameterAssert( key );
    if ( !key ) {
        IonReport( @"No key specified." );
        return NULL;
    }
    
    result = [[IonImageRef alloc] init];
    fileNameString = [self stringForKey: key];
    if ( !fileNameString )
        return NULL;
    
    result.fileName = fileNameString;
    return result;
}
@end

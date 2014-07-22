//
//  IonStyle.m
//  Ion
//
//  Created by Andrew Hurst on 7/16/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonStyle.h"
#import "IonStyle+IonStdStyleApplyMethods.h"

#import "IonKVPAccessBasedGenerationMap.h"
#import "IonThemePointer.h"




@interface IonStyle ()

@end

@implementation IonStyle
/**
 * This will resolve a style using a map and an Attribute Set.
 * @param {NSDictionary*} the map to process
 * @param {IonThemeAttributes*} the theme attributes set to do our searches on if needed.
 * @returns {UIColor*} representation, or NULL of invalid
 */
+ (IonStyle*) resolveWithMap:(NSDictionary*) map andAttributes:(IonKVPAccessBasedGenerationMap*) attributes {
    if ( !attributes || !map)
        return NULL;
    
    IonStyle* result = [[IonStyle alloc] init];
    
    [result setResolutionAttributes: attributes];
    [result setObjectConfig: map];
    
    return result;
}

#pragma mark Constructors

/**
 * This is the default constructor
 * @returns {instancetpe}
 */
- (instancetype) init {
    self = [super init];
    if ( self ) {
        _proprietyMethodMap = [[IonMethodMap alloc] initWithTarget: self];
        [self addIonStdStyleApplyProprieties];
    }
    
    return self;
}

#pragma mark External Interface

/**
 * This sets the object config.
 * @param {NSDictionary*} the configuration to set.
 * @returns {void}
 */
- (void) setObjectConfig:(NSDictionary*) configMap {
    if ( !configMap )
        return;
    
    _config = [[NSMutableDictionary alloc] initWithDictionary:configMap];
}
/**
 * This sets the attributes that we should resolve with.
 * @param {IonThemeAttributes*} the attributes we should resolve with.
 * @returns {void}
 */
- (void) setResolutionAttributes:(IonKVPAccessBasedGenerationMap*) attributes {
    if ( !attributes )
        return;
    
    _attributes = attributes;
}


/**
 * This applies the current style to the inputted view.
 * @param {UIView*} the view to apply the style to.
 * @returns {void}
 */
- (void) applyToView:(UIView*) view {
    NSArray* keys;
    if ( !_attributes || !_config)
        return;
    
    keys =  _config.allKeys;
    
    // Call all setting to view here
    //[self setBackgroundOnView: view];
    
    // Set each
    [UIView animateWithDuration:1.5 animations:^{
        for ( NSString* key in keys )
            [_proprietyMethodMap invokeMethodOnTargetWithKey: key withObject: view];
    }];
    
}


/**
 * This overrides the current styles proprieties with the inputed style.
 * @param {IonStyle*} the style to override the current style
 * @returns {IonStyle*} the net style of the override
 */
- (IonStyle*) overrideStyleWithStyle:(IonStyle*) overridingStyle {
    id newObject;
    NSArray* keys;
    IonStyle* result;
    if ( !overridingStyle )
        return self;
    
    // Construct Object
    result = [IonStyle resolveWithMap: _config andAttributes: _attributes];
    
    // Get Keys
    keys = [overridingStyle.config allKeys];
    
   
    //override proprieties with the overriding styles proprieties.
    for ( id key in keys ) {
        newObject = [overridingStyle.config objectForKey:key];
        if ( !newObject )
            break;
        
        [result.config setValue: newObject forKey: key];
    }
    
    return result;
}

/**
 * This returns the description of our config manifest.
 * @return {NSString*}
 */
- (NSString*) description {
    return [_config description];
}

@end

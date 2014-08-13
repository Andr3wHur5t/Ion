//
//  IonTransformAnimation.m
//  Ion
//
//  Created by Andrew Hurst on 8/12/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonTransformAnimation.h"
#import <IonData/IonData.h>

@interface IonTransformAnimation () {
    NSDictionary* configuration;
    
    /**
     * Appearance
     */
    IonVec3* positionVector;
    IonVec3* rotationVector;
    IonVec3* scaleVector;
    
    
    CGFloat alpha;
    
    /**
     * Meta
     */
    CGFloat delay;
    CGFloat durration;
    
    UIViewKeyframeAnimationOptions options;
    
    /**
     * Targeting
     */
    NSString* targetTransformation;
    
}

@end

@implementation IonTransformAnimation
#pragma mark Constructors
/**
 * Default Constructor
 */
- (instancetype) init {
    self = [super init];
    if ( self ) {
        configuration = [self defaultConfiguration];
        [self setStaticDefaults];
    }
    return self;
}

/**
 * Constructs the transform using the inputted dictionary.
 * @param {NSDictionary*} config
 * @returns {instancetype}
 */
- (instancetype) initWithDictionary:(NSDictionary*) config {
    if ( !config || ![config isKindOfClass: [NSDictionary class]] )
        return NULL;
    self = [self init];
    if ( self ) {
        configuration = config;
        [self matchStateWithConfig];
        
    }
    return self;
}

#pragma mark Configuration

/**
 * Matches state with the current configuration.
 * @retruns {void}
 */
- (void) matchStateWithConfig {
    [self normalize];
    // Meta
    delay = [[configuration numberForKey: sIonTransformAnimation_DelayKey] floatValue];
    durration = [[configuration numberForKey: sIonTransformAnimation_DurationKey] floatValue];
    
    targetTransformation = [configuration stringForKey: sIonTransformAnimation_TargetTransformKey];
    
    // Appearance
    positionVector = [[IonVec3 alloc] initWithDictionary: [configuration dictionaryForKey:sIonTransformAnimation_PositionKey]];
    if ( !positionVector )
        positionVector = [IonVec3 vectorZero];
    
    rotationVector = [[IonVec3 alloc] initWithDictionary: [configuration dictionaryForKey:sIonTransformAnimation_RotationKey]];
    if ( !rotationVector )
        rotationVector = [IonVec3 vectorZero];
    
    scaleVector = [[IonVec3 alloc] initWithDictionary: [configuration dictionaryForKey:sIonTransformAnimation_ScaleKey]];
    if ( !scaleVector )
        scaleVector = [IonVec3 vectorOne];
    
    alpha = [[configuration numberForKey: sIonTransformAnimation_AlphaKey] floatValue];
    return;
}

/**
 * Normalizes the configuration by filling in empty values.
 * @returns {void}
 */
- (void) normalize {
    configuration = [[self defaultConfiguration] overriddenByDictionary: configuration];
    return;
}


#pragma mark Execution
/**
 * Executes the transform frame on the inputted view.
 * @param {UIView*} targetView
 * @param {void(^)( NSString* nextTarget )} The Completion.
 */
- (void) executeTransformAnimationOn:(UIView*) view withCompletion:(void(^)( NSString* nextTarget )) completion {
    if ( !view || ![view isKindOfClass: [UIView class]] )
        return;

    [self matchStateWithConfig];
    [UIView animateKeyframesWithDuration: durration
                                   delay: delay
                                 options: options
                              animations: ^{
                                  [self applyToView: view];
                              }
                              completion:^(BOOL finished) {
                                  if ( completion )
                                      completion( targetTransformation );
                              }];
    
}

#pragma mark Application

/**
 * Applies the transform appearance properties to the view
 */
- (void) applyToView:(UIView*) view {
    if ( !view || ![view isKindOfClass: [UIView class]] )
        return;
    
    // Set the transform
    view.layer.transform = [self endTransformOnView: view];
    view.layer.opacity = alpha;
}


/**
 * Combines translations
 */
- (CATransform3D) endTransformOnView:(UIView*) view {
    IonVec3 *netVector;
    
    netVector = [IonVec3 vectorWithX: view.frame.size.width
                                   Y: view.frame.size.height
                                andZ: (view.frame.size.height + view.frame.size.width)/ 2 ];
    
    return CATransform3DConcat ( [scaleVector toScaleTransform],
                                CATransform3DConcat ( [rotationVector toRotationTransform],
                                                     [[positionVector multiplyBy:netVector] toPositionTransform]));
}


#pragma mark Default Configuration

/**
 * Sets the static default values.
 * @retuns {void}
 */
- (void) setStaticDefaults {
    // Meta
    delay = 0.0f;
    durration = 0.3f;
    options = 0;
    
    // Appearance
    rotationVector = [IonVec3 vectorZero];
    positionVector = [IonVec3 vectorZero];
    scaleVector = [IonVec3 vectorOne];
    alpha = 1.0f;
}

/**
 * Gets the default configuration
 * Note All values must be set here
 * @returns {NSDictionary*}
 */
- (NSDictionary*) defaultConfiguration {
    return @{
             // Meta
             sIonTransformAnimation_DelayKey: @0.0f,
             sIonTransformAnimation_DurationKey: @0.3f,
             
             
             // Appearance
             sIonTransformAnimation_PositionKey: [[IonVec3 vectorZero] toString],
             sIonTransformAnimation_RotationKey: [[IonVec3 vectorZero] toString],
             sIonTransformAnimation_ScaleKey: [[IonVec3 vectorOne] toString],
             
             sIonTransformAnimation_AlphaKey: @1.0f
             };
}

@end

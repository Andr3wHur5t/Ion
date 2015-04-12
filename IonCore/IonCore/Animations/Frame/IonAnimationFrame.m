//
//  IonTransformAnimation.m
//  Ion
//
//  Created by Andrew Hurst on 8/12/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonAnimationFrame.h"
#import <IonData/IonData.h>
#import <SimpleMath/SimpleMath.h>

@implementation IonAnimationFrame
#pragma mark Constructors
/**
 * Default Constructor
 */
- (instancetype)init {
  self = [super init];
  if (self) self.configuration = [[self class] defaultConfiguration];
  return self;
}

/**
 * Constructs the transform using the inputted dictionary.
 * @param {NSDictionary*} config
 */
- (instancetype)initWithDictionary:(NSDictionary *)config {
  NSParameterAssert(config && [config isKindOfClass:[NSDictionary class]]);
  if (!config || ![config isKindOfClass:[NSDictionary class]]) return NULL;
  self = [self init];
  if (self) self.configuration = config;
  return self;
}

/**
 * Constructs the frame using the provided dictionary, and name.
 * @param {NSDictionary*} the dictionary to use for configuration.
 * @param {NSString*} the name of the frame, used in debugging.
 */
- (instancetype)initWithDictionary:(NSDictionary *)config
                           andName:(NSString *)name {
  self = [self initWithDictionary:config];
  if (self) self.name = name;
  return self;
}

/**
 * Constructs a frame using the provided dictionary.
 * @param {NSDictionary*} the dictionary to use for configuration.
 */
+ (instancetype)frameWithDictionary:(NSDictionary *)config {
  return [[[self class] alloc] initWithDictionary:config];
}

/**
 * Constructs a frame using the provided dictionary, and name.
 * @param {NSDictionary*} the dictionary to use for configuration.
 * @param {NSString*} the name of the frame, used in debugging.
 */
+ (instancetype)frameWithDictionary:(NSDictionary *)config
                            andName:(NSString *)name {
  return [[[self class] alloc] initWithDictionary:config andName:name];
}

#pragma mark Execution
/**
 * Executes the transform frame on the inputted view.
 * @param {UIView*} targetView
 * @param {void(^)( NSString* nextTarget )} The Completion.
 */
- (void)executeTransformationOn:(UIView *)view
                 withCompletion:(FrameAnimationCompletion)completion {
  if (!view || ![view isKindOfClass:[UIView class]]) return;
  [UIView animateWithDuration:self.executionDuration
      delay:self.executionDelay
      options:self.options | UIViewAnimationOptionAllowUserInteraction
      animations:^{ [self applyToView:view]; }
      completion:^(BOOL finished) {
          if (completion) completion(self.targetFrameName);
      }];
}

/**
 * Applies the current configuration to the view without state preservation.
 * @param {UIView*} the view to apply the frames configuration to.
 */
- (void)applyToView:(UIView *)view {
  if (!view || ![view isKindOfClass:[UIView class]]) return;

  // Set the transform
  view.layer.transform = [self compositeTransformOnView:view];
  view.layer.opacity = (float)self.alpha;

  if (self.debugText) NSLog(@"%@", self.debugText);

  if (self.color) view.layer.backgroundColor = self.color.CGColor;
}

#pragma mark Composite Value Calculation
/**
 * Gets the resulting composite transformation for the frames state, and the
 * inputted views size.
 * @param {UIView*} the view to apply to.
 */
- (CATransform3D)compositeTransformOnView:(UIView *)view {
  SMVec3 *sizeVector;
  // Gets a size vector to multiply the the frames position vector,
  // so that animations work no matter the size of the view.
  sizeVector =
      [SMVec3 vectorWithX:view.frame.size.width
                        Y:view.frame.size.height
                     andZ:(view.frame.size.height + view.frame.size.width) / 2];
  return CATransform3DConcat(
      [self.scale toScaleTransform],
      CATransform3DConcat(
          [self.rotation toRotationTransform],
          [[self.position multiplyBy:sizeVector] toPositionTransform]));
}

#pragma mark Configuration
/**
 * Sets the configurations KVO mode to manual.
 */
+ (BOOL)automaticallyNotifiesObserversOfConfiguration {
  return FALSE;
}

/**
 * Sets the internal state to match the inputted configuration dictionary.
 * @param {NSDictionary*} the dictionary representing our new states.
 */
- (void)setConfiguration:(NSDictionary *)configuration {
  NSDictionary *normalizedConfiguration;
  NSParameterAssert(configuration &&
                    [configuration isKindOfClass:[NSDictionary class]]);
  if (!configuration || ![configuration isKindOfClass:[NSDictionary class]])
    return;

  normalizedConfiguration = [[[self class] defaultConfiguration]
      overriddenByDictionaryRecursively:configuration];

  // We are going to update our states with the inputted configuration inform
  // for KVO compliance.
  [self willChangeValueForKey:@"configuration"];

  // Frame Metadata
  self.executionDelay = [[normalizedConfiguration
      numberForKey:sIonTransformAnimation_DelayKey] doubleValue];
  self.executionDuration = [[normalizedConfiguration
      numberForKey:sIonTransformAnimation_DurationKey] doubleValue];
  self.targetFrameName = [normalizedConfiguration
      stringForKey:sIonTransformAnimation_TargetTransformKey];

  // Frame Appearance Transformations
  self.color =
      [normalizedConfiguration colorFromKey:sIonTransformAnimation_ColorKey];
  self.alpha = [[normalizedConfiguration
      numberForKey:sIonTransformAnimation_AlphaKey] floatValue];

  // Frame Perspective Transformations
  self.position = [[SMVec3 alloc]
      initWithDictionary:
          [normalizedConfiguration
              dictionaryForKey:sIonTransformAnimation_PositionKey]];
  self.rotation = [[SMVec3 alloc]
      initWithDictionary:
          [normalizedConfiguration
              dictionaryForKey:sIonTransformAnimation_RotationKey]];
  self.scale = [[SMVec3 alloc]
      initWithDictionary:[normalizedConfiguration
                             dictionaryForKey:sIonTransformAnimation_ScaleKey]];

  // Debugging
  self.debugText =
      [normalizedConfiguration stringForKey:sIonTransformAnimation_LogKey];

  // We finished our configuration, we can reconstruct the configuration
  // dictionary now.
  [self didChangeValueForKey:@"configuration"];
}

/**
 * Gets our frame state configuration in dictionary forum.
 * @return {NSDictionary*}
 */
- (NSDictionary *)configuration {
  return @{
    // Metadata
    sIonTransformAnimation_DelayKey :
        [NSNumber numberWithDouble:self.executionDelay],
    sIonTransformAnimation_DurationKey :
        [NSNumber numberWithDouble:self.executionDuration],
    sIonTransformAnimation_TargetTransformKey :
        self.targetFrameName ? self.targetFrameName : @"",

    // Perspective Transforms.
    sIonTransformAnimation_PositionKey : [self.position toDictionary],
    sIonTransformAnimation_RotationKey : [self.rotation toRotationalDictionary],
    sIonTransformAnimation_ScaleKey : [self.scale toDictionary],

    // Debugging
    sIonTransformAnimation_LogKey : self.debugText ? self.debugText : @""
  };
}

/**
 * Our constant default configuration.
 * @return {NSDictionary*}
 */
+ (NSDictionary *)defaultConfiguration {
  // NOTE: ALL values must be set here!
  return @{
    // Meta
    sIonTransformAnimation_DelayKey : @0.0f,
    sIonTransformAnimation_DurationKey : @0.3f,

    // Appearance
    sIonTransformAnimation_PositionKey : [[SMVec3 vectorZero] toDictionary],
    sIonTransformAnimation_RotationKey :
        [[SMVec3 vectorZero] toRotationalDictionary],
    sIonTransformAnimation_ScaleKey : [[SMVec3 vectorOne] toDictionary],

    sIonTransformAnimation_AlphaKey : @1.0f
  };
}

#pragma mark Position
/**
 * Switch KVO to manual mode.
 */
+ (BOOL)automaticallyNotifiesObserversOfPosition {
  return FALSE;
}

/**
 * Sets the position.
 */
- (void)setPosition:(SMVec3 *)position {
  if (!position) {
    if (!_position) self.position = [SMVec3 vectorZero];
    return;
  }

  [self willChangeValueForKey:@"position"];
  _position = position;
  [self didChangeValueForKey:@"position"];
}

#pragma mark Rotation
/**
 * Switch KVO to manual mode.
 */
+ (BOOL)automaticallyNotifiesObserversOfRotation {
  return FALSE;
}

/**
 * Sets the position.
 */
- (void)setRotation:(SMVec3 *)rotation {
  if (!rotation) {
    if (!_rotation) self.rotation = [SMVec3 vectorZero];
    return;
  }

  [self willChangeValueForKey:@"rotation"];
  _rotation = rotation;
  [self didChangeValueForKey:@"rotation"];
}

#pragma mark scale
/**
 * Switch KVO to manual mode.
 */
+ (BOOL)automaticallyNotifiesObserversOfScale {
  return FALSE;
}

/**
 * Sets the position.
 */
- (void)setScale:(SMVec3 *)scale {
  if (!scale) {
    if (!_scale) self.scale = [SMVec3 vectorOne];
    return;
  }

  [self willChangeValueForKey:@"scale"];
  _scale = scale;
  [self didChangeValueForKey:@"scale"];
}

@end

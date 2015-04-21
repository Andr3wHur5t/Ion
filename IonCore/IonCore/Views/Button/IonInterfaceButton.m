//
//  IonButton.m
//  Ion
//
//  Created by Andrew Hurst on 8/10/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonInterfaceButton.h"
#import "UIView+IonAnimation.h"
#import "UIView+IonBackgroundUtilities.h"
#import "IonButtonBehaviorSimpleFade.h"
#import <IonCore/UIView+IonGuideLine.h>
#import <IonData/IonData.h>

static NSString* sIonButtonConfigurationFileExtension = @".button";

@interface IonInterfaceButton () {
  NSDictionary* behaviorInfo;
  CGFloat _alpha;
}

@property(strong, nonatomic, readwrite) NSUUID* setID;
@property(assign, nonatomic, readwrite) BOOL hasSetImage;

@end

/** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
 * = =
 *                               Interface
 * = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
 * = */

@implementation IonInterfaceButton

/**
 * Default constructor
 */
- (instancetype)init {
  self = [super init];
  if (self) {
    self.behavior = [[IonButtonBehaviorSimpleFade alloc] init];
    self.baseImageKey = NULL;
    self.manualSizeMode = TRUE;
    self.hasSetImage = FALSE;
    _alpha = 1.0f;
  }
  return self;
}

/**
 * Constructs an Ion button for the inputted Dictionary configuration.
 * @param {CGPoint} the origin of the button.
 * @param {NSDictionary*} the button configuration.
 */
- (instancetype)initWithOrigin:(CGPoint)origin
              andConfiguration:(NSDictionary*)configuration {
  self = [self init];
  if (self) {
    [self setConfiguration:configuration];
    self.frame = (CGRect){origin, self.frame.size};
  }
  return self;
}

/**
 * Constructs an Ion button for the inputted Dictionary configuration.
 * @param {NSDictionary*} the button configuration.
 */
- (instancetype)initWithConfiguration:(NSDictionary*)configuration {
  return [self initWithOrigin:CGPointZero andConfiguration:configuration];
}

/**
 * Constructs the button with an origin, using the button file.
 * NOTE: loads configuration synchronously.
 * @param {CGPoint} the origin of the button.
 * @param {IonPath*} buttons' configuration file path.
 */
- (instancetype)initWithOrigin:(CGPoint)origin andPath:(IonPath*)path {
  NSDictionary* configuration;
  if (!path || ![path isKindOfClass:[IonPath class]]) return NULL;

  // Load File
  if (![[NSFileManager defaultManager] fileExistsAtPath:[path toString]])
    return NULL;

  configuration = [[[NSFileManager defaultManager]
      contentsAtPath:[path toString]] toJsonDictionary];
  return [self initWithOrigin:origin andConfiguration:configuration];
}

/**
 * Constructs the button with an origin, using the button file.
 * NOTE: loads configuration synchronously.
 * @param {IonPath*} buttons' configuration file path.
 */
- (instancetype)initWithPath:(IonPath*)path {
  return [self initWithOrigin:CGPointZero andPath:path];
}

/**
 * Constructs the button with an origin, using the button file.
 * NOTE: loads configuration synchronously.
 * @param {CGPoint} the origin of the button.
 * @param {NSString*} buttons' configuration file name.
 */
- (instancetype)initWithOrigin:(CGPoint)origin andFileName:(NSString*)name {
  IonPath* targetPath;
  if (!name || ![name isKindOfClass:[NSString class]]) return NULL;

  targetPath = [[IonPath bundleDirectory]
      pathAppendedByElement:
          [name stringByAppendingString:sIonButtonConfigurationFileExtension]];
  return [self initWithOrigin:origin andPath:targetPath];
}

/**
 * Constructs the button with an origin, using the button file.
 * NOTE: loads configuration synchronously.
 * @param {NSString*} buttons' configuration file name.
 */
- (instancetype)initWithFileName:(NSString*)name {
  return [self initWithOrigin:CGPointZero andFileName:name];
}

#pragma mark Configuration

/**
 * Setter for the configuration object, Updates the button to match the inputted
 * configuration.
 * @param {NSDictionary*} the new configuration.
 */
- (void)setConfiguration:(NSDictionary*)configuration {
  if (!configuration || ![configuration isKindOfClass:[NSDictionary class]])
    return;
  _configuration = configuration;

  [self updateToMatchConfiguration];
}

/**
 * Processes the configuration make us match it.
 */
- (void)updateToMatchConfiguration {
  // Get Behavior Delegate
  [self
      setBehaviorUsingBehaviorConfigObject:
          [_configuration dictionaryForKey:sIonButtonConfigurationBehaviorKey]];

  // Get State Image Keys
  self.baseImageKey =
      [_configuration stringForKey:sIonButtonConfigurationBaseImageKey];

  // Update our self
  if (_behavior)
    [_behavior updateButtonToMatchState:self.currentState animated:FALSE];
}

/**
 * Sets the bbehavior using the behavior configuration object.
 * @param {NSDictionary*} the behavior configuration object.
 */
- (void)setBehaviorUsingBehaviorConfigObject:(NSDictionary*)config {
  id<IonButtonBehaviorDelegate> behaviorDeligate;
  if (!config || ![config isKindOfClass:[NSDictionary class]]) return;

  // Get the behavior object
  behaviorDeligate = [IonInterfaceButton
      behaviorForKey:[config stringForKey:sIonButtonConfigurationItemKey]];
  if (!behaviorDeligate) return;

  // Set the behavoir info.
  behaviorInfo =
      [config dictionaryForKey:sIonButtonConfigurationBehavior_InfoKey];

  // set the behavior object
  self.behavior = behaviorDeligate;
}

/**
 * Responds to changes to our behavior delegate, and ensures that it can fulfill
 * our requests.
 * @param {id<IonBehaviorDelegate>} the new delegate object.
 */
- (void)setBehavior:(id<IonButtonBehaviorDelegate>)behavior {
  if (!behavior ||
      ![behavior conformsToProtocol:@protocol(IonButtonBehaviorDelegate)])
    return;
  _behavior = behavior;

  // Setup Button with our info.
  [_behavior setUpWithButton:self andInfoObject:behaviorInfo];
}

/**
 * Responds to changes of the base image key.
 * @param {NSString*} the new base image key
 */
- (void)setBaseImageKey:(NSString*)baseImageKey {
  if (baseImageKey || [baseImageKey isKindOfClass:[NSString class]])
    _baseImageKey = baseImageKey;

  // Post check
  if (!_baseImageKey || ![_baseImageKey isKindOfClass:[NSString class]])
    _baseImageKey = @"placeholder";

  // Update ourself
  [self updateBaseMaskImage];
}

#pragma mark Style Application

- (void)applyStyle:(IonStyle*)style {
  [super applyStyle:style];
  if (_behavior) [_behavior styleWasApplyed:style];
}

#pragma mark Utilities

/**
 * Update ourself to match the current state.
 */
- (void)updateBaseMaskImage {
  // Don't waste our time if we dont hace a valid size.
  if (CGSizeEqualToSize(self.frame.size, CGSizeZero) ||
      CGSizeEqualToSize(self.frame.size, CGSizeUndefined))
    return;

  // Set to the ciew
  [self setMaskImageUsingKey:self.baseImageKey
                inRenderMode:IonBackgroundRenderFilled
                  completion:[self imageSetCompletionForState]];

  // Inform the behavior that we should update, in case it is manageing the
  // content image
  if (_behavior)
    [_behavior updateButtonToMatchState:self.currentState
                               animated:[self isVisible]];
}

- (void (^)(NSError* e))imageSetCompletionForState {
  __block void (^completion)(void);
  __block NSUUID* currentSetId;

  if (!self.hasSetImage) {
    super.alpha = 0.0f;
    completion = ^{
      super.alpha = _alpha;
    };
  } else {
    completion = ^{
    };
  }

  currentSetId = [[NSUUID alloc] init];
  self.setID = currentSetId;
  return ^(NSError* e) {
    if ([e isKindOfClass:[NSError class]]) {
      NSLog(@"%s -- %@", __func__, e.localizedDescription);
    }
    // If we are the most recent set id then set
    if ([currentSetId.UUIDString isEqualToString:self.setID.UUIDString])
      completion();

    self.hasSetImage = true;
  };
}

- (void)setAlpha:(CGFloat)alpha {
  _alpha = alpha;
  [super setAlpha:alpha];
}

#pragma mark Button Event Response

/**
 * Respond to State Change With an animation.
 */
- (void)setCurrentState:(IonButtonStates)currentState {
  // Update super
  [super setCurrentState:currentState];

  // Inform the behavior to respond to the state change
  if (_behavior)
    [_behavior updateButtonToMatchState:self.currentState animated:TRUE];
}

/**
 * Gets called when there is a valid complete tap.
 */
- (void)validTapCompleted {
  if (_behavior) [_behavior validTapCompleted];
}

/**
 * Gets called when there has been an invalid tap.
 * @return {void}
 */
- (void)invalidTapCompleted {
  if (_behavior) [_behavior invalidTapCompleted];
}

#pragma mark Frame

/**
 * Respond to changes to the frame by resizing the image.
 */
- (void)setFrame:(CGRect)frame {
  [super setFrame:frame];

  // Update mask
  [self updateBaseMaskImage];

  // Update via behavior
  if (_behavior)
    [_behavior updateButtonToMatchState:self.currentState animated:FALSE];
}

#pragma mark Behavior Retrevial

/**
 * This gets an IonButtonBehavior Delegate object for the specified key.
 * Note: this gets objects from their literal class name, if you class name
 * follows the standard format it will auto implement.
 * @param {NSString*} the key of the behavior delegate to get.
 * @return {id<IonButtonBehaviorDelegate>}
 */
+ (id<IonButtonBehaviorDelegate>)behaviorForKey:(NSString*)key {
  id resultingObject;
  NSString* fullClassName;
  if (!key || ![key isKindOfClass:[NSString class]]) return NULL;

  // Get the full Class name
  fullClassName = [sIonButtonBehaviorRootClassKey stringByAppendingString:key];

  // Get the Object from the set.
  resultingObject = [[NSClassFromString(fullClassName) alloc] init];
  if (!resultingObject ||
      ![resultingObject
          conformsToProtocol:@protocol(IonButtonBehaviorDelegate)])
    return NULL;

  // Return the verified object
  return resultingObject;
}

@end

//
//  IonButton.h
//  Ion
//
//  Created by Andrew Hurst on 8/10/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonButton.h"
#import "UIView+IonTheme.h"

/**
 * Root behavior class key
 */
static NSString* sIonButtonBehaviorRootClassKey = @"IonButtonBehavior";

/**
 * Button Keys
 */
static NSString* sIonButtonConfigurationItemKey = @"key";
static NSString* sIonButtonConfigurationBaseImageKey = @"baseImage";

static NSString* sIonButtonConfigurationStatsKey = @"states";
static NSString* sIonButtonConfigurationStats_NormKey = @"norm";
static NSString* sIonButtonConfigurationStats_DownKey = @"down";
static NSString* sIonButtonConfigurationStats_SelectedKey = @"selected";
static NSString* sIonButtonConfigurationStats_DisabledKey = @"disabled";


static NSString* sIonButtonConfigurationBehaviorKey = @"behavior";
static NSString* sIonButtonConfigurationBehavior_InfoKey = @"info";

static NSString* sIonButtonConfigurationTextKey = @"text";
static NSString* sIonButtonConfigurationText_WillDisplayKey = @"display";

@class IonPath;
@class IonInterfaceButton;


/** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
 *                              IonButtonBehavior
 * = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =  */
@protocol IonButtonBehaviorDelegate <NSObject>

/**
 * Sets up the behavior with the button, and the info object.
 * @param {IonInterfaceButton*} the button that the delegate will administrate.
 * @param {NSDictionary*} the info object associated with the behavior
 * @returns {void}
 */
- (void) setUpWithButton:(IonInterfaceButton*) button andInfoObject:(NSDictionary*) infoObject;

/**
 * Gets called when there is a valid complete tap.
 * @returns {void}
 */
- (void) validTapCompleted;

/**
 * Gets called when there has been an invalid tap.
 * @return {void}
 */
- (void) invalidTapCompleted;

/**
 * Informs the delegate to update the button to match the inputted state.
 * @param {IonButtonStates} currentState the current state.
 * @param {BOOL} states if the change is animated.
 * @returns {void}
 */
- (void) updateButtonToMatchState:(IonButtonStates) currentState animated:(BOOL) animated;

@end

/** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
 *                              IonInterfaceButton
 * = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =  */
@interface IonInterfaceButton : IonButton
#pragma mark Construction

/**
 * Constructs the button with an origin, using the button file.
 * NOTE: loads configuration synchronously.
 * @param {CGPoint} the origin of the button.
 * @param {IonPath*} buttons' configuration file path.
 * @returns {instancetype}
 */
- (instancetype) initWithOrigin:(CGPoint) origin andPath:(IonPath*) path;

/**
 * Constructs the button with an origin, using the button file.
 * NOTE: loads configuration synchronously.
 * @param {IonPath*} buttons' configuration file path.
 * @returns {instancetype}
 */
- (instancetype) initWithPath:(IonPath*) path;

/**
 * Constructs the button with an origin, using the button file.
 * NOTE: loads configuration synchronously.
 * @param {CGPoint} the origin of the button.
 * @param {NSString*} buttons' configuration file name.
 * @returns {instancetype}
 */
- (instancetype) initWithOrigin:(CGPoint) origin andFileName:(NSString*) name;

/**
 * Constructs the button with an origin, using the button file.
 * NOTE: loads configuration synchronously.
 * @param {NSString*} buttons' configuration file name.
 * @returns {instancetype}
 */
- (instancetype) initWithFileName:(NSString*) name;

/**
 * Constructs an Ion button for the inputted Dictionary configuration.
 * @param {CGPoint} the origin of the button.
 * @param {NSDictionary*} the button configuration.
 * @returns {instancetype}
 */
- (instancetype) initWithOrigin:(CGPoint) origin andConfiguration:(NSDictionary*) configuration;

/**
 * Constructs an Ion button for the inputted Dictionary configuration.
 * @param {NSDictionary*} the button configuration.
 * @returns {instancetype}
 */
- (instancetype) initWithConfiguration:(NSDictionary*) configuration;


#pragma mark Configuration

/**
 * The current configuration of the button.
 */
@property (strong, nonatomic) NSDictionary* configuration;

/**
 * The base images key.
 */
@property (strong, nonatomic) NSString* baseImageKey;

/**
 * Our behavior delegate
 */
@property (strong, nonatomic) id<IonButtonBehaviorDelegate> behavior;

#pragma mark Behavior Singletons

/**
 * This gets an IonButtonBehavior Delegate object for the specified key.
 * Note: this gets objects from their literal class name, if you class name follows the standard format it will auto implement.
 * @param {NSString*} the key of the behavior delegate to get.
 * @returns {id<IonButtonBehaviorDelegate>}
 */
+ (id<IonButtonBehaviorDelegate>) behaviorForKey:(NSString*) key;
@end

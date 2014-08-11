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
#import <IonData/IonData.h>

static NSString* sIonButtonConfigurationFileExtension = @".button";

@interface IonInterfaceButton () {
    
    /**
     * State Colors (NOTE: Change to effect objects)
     */
    NSMutableArray* colorStates;
    
    /**
     * State Mask Images.
     */
    NSMutableArray* maskStates;
    
    /**
     * The behavior info Dictionary
     */
    NSDictionary* behaviorInfo;
    
}

@end

/** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
 *                               Interface
 * = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = */

@implementation IonInterfaceButton

/**
 * Default constructor
 * @returns {instancetype}
 */
-(instancetype) init {
    self = [super init];
    if ( self ) {
        colorStates = [[NSMutableArray alloc] init];
        maskStates = [[NSMutableArray alloc] init];
        
        // Test Colors
        [colorStates setObject:UIColorFromRGB( 0xf5f5f5 ) atIndexedSubscript: IonButtonState_Norm];
        [colorStates setObject:UIColorFromRGB( 0x8C8C8C ) atIndexedSubscript: IonButtonState_Down];
        [colorStates setObject:UIColorFromRGB( 0xE8E8E8 ) atIndexedSubscript: IonButtonState_Selected];
        [colorStates setObject:UIColorFromRGB( 0x525252 ) atIndexedSubscript: IonButtonState_Disabled];
    }
    return self;
}

/**
 * Constructs an Ion button for the inputted Dictionary configuration.
 * @param {CGPoint} the origin of the button.
 * @param {NSDictionary*} the button configuration.
 * @returns {instancetype}
 */
- (instancetype) initWithOrigin:(CGPoint) origin andConfiguration:(NSDictionary*) configuration {
    self = [self init];
    if ( self ) {
        [self setConfiguration: configuration];
        self.frame = (CGRect){ origin, self.frame.size };
    }
    return self;
}

/**
 * Constructs an Ion button for the inputted Dictionary configuration.
 * @param {NSDictionary*} the button configuration.
 * @returns {instancetype}
 */
- (instancetype) initWithConfiguration:(NSDictionary*) configuration {
    return [self initWithOrigin: CGPointZero andConfiguration: configuration];
}

/**
 * Constructs the button with an origin, using the button file.
 * NOTE: loads configuration synchronously.
 * @param {CGPoint} the origin of the button.
 * @param {IonPath*} buttons' configuration file path.
 * @returns {instancetype}
 */
- (instancetype) initWithOrigin:(CGPoint) origin andPath:(IonPath*) path {
    NSDictionary* configuration;
    if ( !path || ![path isKindOfClass: [IonPath class]] )
        return NULL;
    
    //Load File
    if ( ![[NSFileManager defaultManager] fileExistsAtPath: [path toString]] )
        return NULL;
    
    configuration = [[[NSFileManager defaultManager] contentsAtPath: [path toString]] toJsonDictionary];
    return [self initWithOrigin: origin andConfiguration: configuration];
}

/**
 * Constructs the button with an origin, using the button file.
 * NOTE: loads configuration synchronously.
 * @param {IonPath*} buttons' configuration file path.
 * @returns {instancetype}
 */
- (instancetype) initWithPath:(IonPath*) path {
    return [self initWithOrigin: CGPointZero andPath: path];
}

/**
 * Constructs the button with an origin, using the button file.
 * NOTE: loads configuration synchronously.
 * @param {CGPoint} the origin of the button.
 * @param {NSString*} buttons' configuration file name.
 * @returns {instancetype}
 */
- (instancetype) initWithOrigin:(CGPoint) origin andFileName:(NSString*) name {
    IonPath* targetPath;
    if ( !name || ![name isKindOfClass: [NSString class]] )
        return NULL;
    
    targetPath = [[IonPath bundleDirectory] pathAppendedByElement: [name stringByAppendingString:sIonButtonConfigurationFileExtension]];
    return [self initWithOrigin: origin andPath: targetPath];
}

/**
 * Constructs the button with an origin, using the button file.
 * NOTE: loads configuration synchronously.
 * @param {NSString*} buttons' configuration file name.
 * @returns {instancetype}
 */
- (instancetype) initWithFileName:(NSString*) name {
    return [self initWithOrigin: CGPointZero andFileName: name];
}

#pragma mark Configuration

/**
 * Setter for the configuration object, Updates the button to match the inputted configuration.
 * @param {NSDictionary*} the new configuration.
 * @returns {void}
 */
- (void) setConfiguration:(NSDictionary*) configuration {
    if ( !configuration || ![configuration isKindOfClass:[NSDictionary class]] )
        return;
    _configuration = configuration;
    
    [self updateToMatchConfiguration];
}

/**
 * Processes the configuration make us match it.
 * @returns {void}
 */
- (void) updateToMatchConfiguration {
    // Get Behavior Delegate
    
    // Get State Image Keys
    [self stateImagesFromStateConfiguration: [_configuration dictionaryForKey: sIonButtonConfigurationStatsKey]];
    
    
    // Update our self
    [self updateToMatchCurrentState];
}

/**
 * Gets the State Images from the state configuration map.
 * @param {NSDictionary*} the configuration.
 * @returns {void}
 */
- (void) stateImagesFromStateConfiguration:(NSDictionary*) stateDictionary {
    if ( !stateDictionary || ![stateDictionary isKindOfClass: [NSDictionary class]] ) {
        // Set our norm image to a placeholder
        return;
    }
    
    // Norm
    [maskStates setObject: [stateDictionary stringForKey: sIonButtonConfigurationStats_NormKey]
       atIndexedSubscript: IonButtonState_Norm];
    
    // Down
    [maskStates setObject: [stateDictionary stringForKey: sIonButtonConfigurationStats_DownKey]
       atIndexedSubscript: IonButtonState_Down];
    
    // Selected
    [maskStates setObject: [stateDictionary stringForKey: sIonButtonConfigurationStats_SelectedKey]
       atIndexedSubscript: IonButtonState_Selected];
    
    // Disabled
    [maskStates setObject: [stateDictionary stringForKey: sIonButtonConfigurationStats_DisabledKey]
       atIndexedSubscript: IonButtonState_Disabled];
    
    // Verify Norm is set
    if ( ![maskStates objectAtIndex: IonButtonState_Norm] ) {
        [maskStates setObject: @"placeholder"   // Replace with a place holder image
           atIndexedSubscript: IonButtonState_Norm];
        NSLog(@"WARN: Button Missing Norm State Mask!");
    }
    
}


/**
 * Responds to changes to our behavior delegate, and ensures that it can fulfill our requests.
 * @param {id<IonBehaviorDelegate>} the new delegate object.
 * @returns {void}
 */
- (void) setBehavior:(id<IonButtonBehaviorDelegate>) behavior {
    if ( !behavior || ![behavior conformsToProtocol: @protocol(IonButtonBehaviorDelegate)] )
        return;
    _behavior = behavior;
    
    // Setup Button with our info.
    [_behavior setUpWithButton: self andInfoObject: behaviorInfo];
}

#pragma mark Utilities

/**
 * Update ourself to match the current state.
 * @returns {void}
 */
- (void) updateToMatchCurrentState {
    NSString* stateMaskKey;
    // Background Color
    self.backgroundColor = [colorStates objectAtIndex: self.currentState];
    
    // Mask
    if ( CGSizeEqualToSize( self.frame.size, CGSizeZero) || CGSizeEqualToSize( self.frame.size, CGSizeUndefined ) )
        return;
    
    stateMaskKey = [maskStates objectAtIndex: self.currentState];
    if ( !stateMaskKey || ![stateMaskKey isKindOfClass: [NSString class]] )
        stateMaskKey = [maskStates objectAtIndex: IonButtonState_Norm];
    [self setMaskImageUsingKey: stateMaskKey];
    
    
    if ( _behavior )
        [_behavior updateButtonToMatchState: self.currentState animated: TRUE];
}



#pragma mark Button Event Response

/**
 * Respond to State Change With an animation.
 */
- (void) setCurrentState:(IonButtonStates)currentState {
    // Update super
    [super setCurrentState: currentState];
    
    // Respond
    [UIView animateWithDuration: 0.3 animations: ^{
        [self updateToMatchCurrentState];
        
    }];
}

/**
 * Respond to changes to the frame by resizing the image.
 */
- (void) setFrame:(CGRect)frame {
    [super setFrame: frame];
    [self updateToMatchCurrentState];
}


#pragma mark Behavior Singletons

/**
 * This gets an IonButtonBehavior Delegate object for the specified key.
 * Note: this gets objects from their literal class name, if you class name follows the standard format it will auto implement.
 * @param {NSString*} the key of the behavior delegate to get.
 * @returns {id<IonButtonBehaviorDelegate>}
 */
- (id<IonButtonBehaviorDelegate>) behaviorForKey:(NSString*) key {
    return NULL;
}

@end

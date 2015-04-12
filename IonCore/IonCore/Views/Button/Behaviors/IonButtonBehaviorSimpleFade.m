//
//  IonButtonBehaviorSimpleFade.m
//  Ion
//
//  Created by Andrew Hurst on 8/11/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonButtonBehaviorSimpleFade.h"
#import "NSDictionary+IonThemeResolution.h"
#import <IonData/IonData.h>

@interface IonButtonBehaviorSimpleFade () {
  SMVec3* currentVector;
}

@end

@implementation IonButtonBehaviorSimpleFade
#pragma mark Constructors

/**
 * Default constructor
 */
- (instancetype)init {
  self = [super init];
  if (self) {
    _stateEffects = [[NSMutableDictionary alloc] init];
    [self setDefaultEffectStates];
    currentVector = [SMVec3 vectorZero];
  }
  return self;
}

#pragma mark Defaults

- (void)setDefaultEffectStates {
  [_stateEffects
      setObject:UIColorFromRGB(0xf5f5f5)
         forKey:[IonButtonBehavior keyForButtonState:IonButtonState_Norm]];
  [_stateEffects
      setObject:UIColorFromRGB(0x8C8C8C)
         forKey:[IonButtonBehavior keyForButtonState:IonButtonState_Down]];
  [_stateEffects
      setObject:UIColorFromRGB(0x525252)
         forKey:[IonButtonBehavior keyForButtonState:IonButtonState_Selected]];
  [_stateEffects
      setObject:UIColorFromRGB(0x8C8C8C)
         forKey:[IonButtonBehavior keyForButtonState:IonButtonState_Disabled]];
}

#pragma mark Behavior Protocol Implementation

/**
 * Sets up the behavior with the button, and the info object.
 * @param {IonInterfaceButton*} the button that the delegate will administrate.
 * @param {NSDictionary*} the info object associated with the behavior
 */
- (void)setUpWithButton:(IonInterfaceButton*)button
          andInfoObject:(NSDictionary*)infoObject {
  [super setUpWithButton:button andInfoObject:infoObject];
  if (!button || ![button isKindOfClass:[IonInterfaceButton class]]) return;
}

/**
 * Informs the delegate to update the button to match the inputted state.
 * @param {IonButtonStates} currentState the current state.
 * @param {BOOL} states if the change is animated.
 */
- (void)updateButtonToMatchState:(IonButtonStates)currentState
                        animated:(BOOL)animated {
  [super updateButtonToMatchState:currentState animated:animated];
  __block NSString* stateKey;
  void (^ContentChangeBlock)();

  // Set
  stateKey = [IonButtonBehavior keyForButtonState:currentState];

  // The changes to execute
  ContentChangeBlock = ^{
      // Apply the effect to the view
      self.button.backgroundColor = [_stateEffects objectForKey:stateKey];
  };

  // Commit the changes.
  if (!animated)
    ContentChangeBlock();
  else
    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:ContentChangeBlock
                     completion:NULL];
}

/**
 * Informs the behavior that the view was applyed with a style.
 * @param {IonStyle*} the new style.
 */
- (void)styleWasApplyed:(IonStyle*)style {
  NSDictionary* dict;
  UIColor* norm, *down, *selected, *disabled;
  if (!style || ![style isKindOfClass:[IonStyle class]]) return;

  dict = [style.configuration dictionaryForKey:sIonButtonSimpleFade_States];
  if (!dict) return;

  norm = [dict colorForKey:sIonButtonSimpleFade_States_Norm
                usingTheme:style.theme];
  if (norm)
    [_stateEffects
        setObject:norm
           forKey:[IonButtonBehavior keyForButtonState:IonButtonState_Norm]];

  down = [dict colorForKey:sIonButtonSimpleFade_States_Down
                usingTheme:style.theme];
  if (down)
    [_stateEffects
        setObject:down
           forKey:[IonButtonBehavior keyForButtonState:IonButtonState_Down]];

  selected = [dict colorForKey:sIonButtonSimpleFade_States_Selected
                    usingTheme:style.theme];
  if (selected)
    [_stateEffects setObject:selected
                      forKey:[IonButtonBehavior
                                 keyForButtonState:IonButtonState_Selected]];

  disabled = [dict colorForKey:sIonButtonSimpleFade_States_Disabled
                    usingTheme:style.theme];
  if (disabled)
    [_stateEffects setObject:disabled
                      forKey:[IonButtonBehavior
                                 keyForButtonState:IonButtonState_Disabled]];

  [self updateButtonToMatchState:self.button.currentState animated:FALSE];
}
@end

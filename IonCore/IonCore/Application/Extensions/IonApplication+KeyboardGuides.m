//
//  IonApplication+KeyboardGuides.m
//  BPMainPages
//
//  Created by Andrew Hurst on 1/26/15.
//  Copyright (c) 2015 21e6. All rights reserved.
//

#import "IonApplication+KeyboardGuides.h"
#import "IonApplication+Keyboard.h"

@implementation IonApplication (KeyboardGuides)

+ (IonGuideLine *)keybordTopGuideWithGuide:(IonGuideLine *)defaultGuide {
  return [self ifKeybordOutUse:[IonApplication sharedApplication].keyboardTop
                       elseUse:defaultGuide];
}

+ (IonGuideLine *)ifKeybordOutUse:(IonGuideLine *)keybordOut
                          elseUse:(IonGuideLine *)keybordIn {
  NSString *kKeybordTopKey = @"keyboardTop", *kKeybordNormKey = @"keyboardNorm",
           *kOutKey = @"out", *kInKey = @"in";
  IonGuideLine *guide;

  // Validate
  NSParameterAssert([keybordOut isKindOfClass:[IonGuideLine class]]);
  NSParameterAssert([keybordIn isKindOfClass:[IonGuideLine class]]);
  if (![keybordIn isKindOfClass:[IonGuideLine class]] ||
      ![keybordIn isKindOfClass:[IonGuideLine class]])
    return NULL;

  guide = [[@0 toGuideLine]
      guideAsChildUsingCalcBlock:^CGFloat(NSDictionary *values) {
          NSNumber *outNum, *inNum, *keyboardNum, *keyboardNormNum;
          CGFloat outVal = 0.0f, inVal = 0.0f, keyboardVal = 0.0f,
                  keyboardNormVal = 0.0f;

          // get the in number
          inNum = [values objectForKey:kInKey];
          if ([inNum isKindOfClass:[NSNumber class]])
            inVal = [inNum floatValue];
          else
            return 0.0f;  // No Vals

          // get the out number
          outNum = [values objectForKey:kOutKey];
          if ([outNum isKindOfClass:[NSNumber class]])
            outVal = [outNum floatValue];
          else
            return inVal;  // Return Default (Missing Value)

          // get the normal keyboard number
          keyboardNormNum = [values objectForKey:kKeybordNormKey];
          if ([keyboardNormNum isKindOfClass:[NSNumber class]])
            keyboardNormVal = [keyboardNormNum floatValue];
          else
            return inVal;  // Return Default (Missing Value)

          // Get the current keyboard number
          keyboardNum = [values objectForKey:kKeybordTopKey];
          if ([keyboardNum isKindOfClass:[NSNumber class]]) {
            keyboardVal = [keyboardNum floatValue];

            // if the values are equal then the keyboard isn't out
            if (keyboardNormVal == keyboardVal)
              return inVal;  // Keyboard not out
            else
              return outVal;  // Keyboard is out
          } else
            return inVal;  // Return Default (Missing Value)

      }];

  // Set the dependent guides
  [guide addTargetGuide:[IonApplication sharedApplication].keyboardTop
               withName:kKeybordTopKey];

  [guide addTargetGuide:[IonApplication sharedApplication].window.sizeGuideVert
               withName:kKeybordNormKey];

  [guide addTargetGuide:keybordIn withName:kInKey];

  [guide addTargetGuide:keybordOut withName:kOutKey];

  return guide;
}

@end

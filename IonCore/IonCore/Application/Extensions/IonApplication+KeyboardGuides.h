//
//  IonApplication+KeyboardGuides.h
//  BPMainPages
//
//  Created by Andrew Hurst on 1/26/15.
//  Copyright (c) 2015 21e6. All rights reserved.
//

#import <IonCore/IonCore.h>

@interface IonApplication (KeyboardGuides)

+ (IonGuideLine *)keybordTopGuideWithGuide:(IonGuideLine *)defaultGuide
    __attribute__((deprecated));

+ (IonGuideLine *)keyboardTopGuideWithGuide:(IonGuideLine *)defaultGuide;

+ (IonGuideLine *)ifKeybordOutUse:(IonGuideLine *)keybordOut
                          elseUse:(IonGuideLine *)keybordIn
    __attribute__((deprecated));

+ (IonGuideLine *)ifKeyboardOutUse:(IonGuideLine *)keyboardOut
                           elseUse:(IonGuideLine *)keyboardIn;
@end

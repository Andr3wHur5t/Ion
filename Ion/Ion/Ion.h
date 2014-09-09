//
//  Ion.h
//  Ion
//
//  Created by Andrew Hurst on 6/26/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IonData/IonData.h>

//! Project version number for Ion.
FOUNDATION_EXPORT double IonVersionNumber;

//! Project version string for Ion.
FOUNDATION_EXPORT const unsigned char IonVersionString[];

#import "IonApplication.h"
#import "IonApplication+StatusBar.h"
#import "IonStatusBarBehaviorMotionGestureDisplay.h"

// TODO CLEAN
#import "IonCompleteGuideGroup.h"
#import "IonGuideGroup+GuidePositioning.h"
#import "IonKVP+IonTheme.h"
#import "IonTransformAnimation.h"
#import "IonTransformAnimationMap.h"
#import "NSDictionary+IonThemeResolution.h"
#import "IonButtonBehavior.h"
#import "IonButtonBehaviorSimpleFade.h"
#import "IonButtonBehaviorTapTransform.h"
#import "UIView+IonGuideGroup.h"

/** Ion Rapid Start System */
#import "IonRapidStartViewController.h"
#import "IonRapidStartManager.h"

/** Fundmental UI */
#import "IonView.h"
#import "IonViewController.h"

/** Buttons */
#import "IonButton.h"
#import "IonInterfaceButton.h"

/** UI Items*/
#import "IonLabel.h"
#import "IonTitleBar.h"

/** Guide Lines */
#import "IonGuideLine.h"
#import "IonGuideLine+DefaultConstructors.h"
#import "IonViewGuideSet.h"
#import "IonGuideGroup.h"

/** UI Extensions */
#import "UIView+IonGuideLine.h"
#import "UIView+IonGuideGroup.h"
#import "UIView+IonAnimation.h"
#import "UIView+IonBackgroundUtilities.h"
#import "UIView+IonViewProperties.h"
#import "UIView+IonPositionAndOrientation.h"

/** Theme Stytem */
#import "IonThemePointer.h"
#import "IonStyle.h"
#import "IonStyle+IonStdStyleApplyMethods.h"
#import "IonTheme.h"
#import "IonAttrubutesStanderdResolution.h"

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

/** Application */
#import "IonApplication.h"
#import "IonApplication+StatusBar.h"
#import "IonApplication+Keyboard.h"
#import "IonApplication+Metrics.h"
#import "IonApplication+plistGetters.h"
#import "IonApplication+Responders.h"

/** Status Bar Behaviors */
#import "IonStatusBarBehaviorMotionGestureDisplay.h"

/** Ion Rapid Start System */
#import "IonRapidStartViewController.h"

#pragma mark Guides
/** Guide Lines */
#import "IonCompleteGuideGroup.h"
#import "IonGuideLine.h"
#import "IonGuideLine+DefaultConstructors.h"
#import "IonGuideGroup+GuidePositioning.h"

/** Guide Sets */
#import "IonGuideSet.h"
#import "IonViewGuideSet.h"

/** Guide Groups*/
#import "IonGuideGroup.h"

#pragma mark UI
/** Fundmental UI */
#import "IonView.h"
#import "IonViewController.h"

/** UI Extensions */
#import "UIView+IonGuideLine.h"
#import "UIView+IonGuideGroup.h"
#import "UIView+IonAnimation.h"
#import "UIView+IonBackgroundUtilities.h"
#import "UIView+IonViewProperties.h"
#import "UIView+IonPositionAndOrientation.h"
#import "UIView+IonGuideGroup.h"

/** UI Items*/
#import "IonIcon.h"
#import "IonLabel.h"
#import "IonTitleBar.h"
#import "IonTextField.h"
#import "IonTextBar.h"
#import "IonButton.h"
#import "IonInterfaceButton.h"
#import "IonScrollView.h"

/** Scroll Actions */
#import "IonScrollAction.h"
#import "IonScrollRefreshAction.h"
#import "IonScrollThresholdAction.h"

/** Scroll Action View */
#import "IonScrollActionView.h"
#import "IonScrollRefreshActionView.h"

/** Button Behaviors */
#import "IonButtonBehavior.h"
#import "IonButtonBehaviorSimpleFade.h"
#import "IonButtonBehaviorTapTransform.h"

#pragma mark Animation System
/** Animation */
#import "IonAnimationFrame.h"
#import "IonAnimationSession.h"

#pragma mark Theme System
/** Theme System */
#import "IonThemePointer.h"
#import "IonStyle.h"
#import "IonStyle+IonStdStyleApplyMethods.h"
#import "IonTheme.h"
#import "IonAttrubutesStanderdResolution.h"

// old
#import "IonKVP+IonTheme.h"
#import "NSDictionary+IonThemeResolution.h"

#pragma mark Validation
/** Input Filtering */
#import "IonInputFilter.h"

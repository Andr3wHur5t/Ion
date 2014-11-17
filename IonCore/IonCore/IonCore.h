//
//  IonCore.h
//  IonCore
//
//  Created by Andrew Hurst on 10/10/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//
//  This is Ions' core UI framework, it's dependent on 'IonFoundation', 'FOUtilities', 'SimpleMath', 'SimpleAnalytics',
//  and 'IACommunication'. 'IACommunication' is statically linked so you don't need to include it in you project.
//

#import <UIKit/UIKit.h>

//! Project version number for IonCore.
FOUNDATION_EXPORT double IonCoreVersionNumber;

//! Project version string for IonCore.
FOUNDATION_EXPORT const unsigned char IonCoreVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <IonCore/PublicHeader.h>


/** Application */
#import <IonCore/IonApplication.h>
#import <IonCore/IonApplication+StatusBar.h>
#import <IonCore/IonApplication+Keyboard.h>
#import <IonCore/IonApplication+Metrics.h>
#import <IonCore/IonApplication+plistGetters.h>
#import <IonCore/IonApplication+Responders.h>
#import <IonCore/IonApplication+RapidSplash.h>
#import <IonCore/IonApplication+InterappComunication.h>
#import <IonCore/IonApplication+ControllerManager.h>

/** Status Bar Behaviors */
#import <IonCore/IonStatusBarBehaviorMotionGestureDisplay.h>

/** Windows */
#import <IonCore/UIWindow+IonWindow.h>

/** Communication */
#import <IonCore/IACLink.h>
#import <IonCore/IACLink+IonApplication.h>
#import <IonCore/IACModule.h>
#import <IonCore/IACActionModule.h>
#import <IonCore/IACRouter.h>

/** Ion Rapid Start System */
#import <IonCore/IonRapidStartViewController.h>

#pragma mark Guides
/** Guide Lines */
#import <IonCore/IonCompleteGuideGroup.h>
#import <IonCore/IonGuideLine.h>
#import <IonCore/IonGuideLine+DefaultConstructors.h>
#import <IonCore/IonGuideGroup+GuidePositioning.h>

/** Guide Sets */
#import <IonCore/IonGuideSet.h>
#import <IonCore/IonViewGuideSet.h>

/** Guide Groups*/
#import <IonCore/IonGuideGroup.h>

#pragma mark UI
/** Fundmental UI */
#import <IonCore/IonView.h>
#import <IonCore/IonViewController.h>

/** UI Extensions */
#import <IonCore/UIView+IonGuideLine.h>
#import <IonCore/UIView+IonGuideGroup.h>
#import <IonCore/UIView+IonAnimation.h>
#import <IonCore/UIView+IonBackgroundUtilities.h>
#import <IonCore/UIView+IonViewProperties.h>
#import <IonCore/UIView+FirstResponderSearch.h>
#import <IonCore/UIView+IonPositionAndOrientation.h>
#import <IonCore/UIView+IonGuideGroup.h>

/** UI Items*/
#import <IonCore/IonIcon.h>
#import <IonCore/IonLabel.h>
#import <IonCore/IonLabelOverflowBehavior.h>
#import <IonCore/IonTitleBar.h>
#import <IonCore/IonTextField.h>
#import <IonCore/IonTextBar.h>
#import <IonCore/IonButton.h>
#import <IonCore/IonInterfaceButton.h>
#import <IonCore/IonScrollView.h>
#import <IonCore/IonPaginationView.h>
#import <IonCore/IonPaginationController.h>
#import <IonCore/IonTextView.h>

/** Scroll Actions */
#import <IonCore/IonScrollAction.h>
#import <IonCore/IonScrollRefreshAction.h>
#import <IonCore/IonScrollThresholdAction.h>

/** Scroll Action View */
#import <IonCore/IonScrollActionView.h>
#import <IonCore/IonScrollRefreshActionView.h>

/** Table View */
#import <IonCore/FODataModel.h> // TODO: Move to FOUtils
#import <IonCore/IonTableView.h>
#import <IonCore/IonCell.h>

/** Button Behaviors */
#import <IonCore/IonButtonBehavior.h>
#import <IonCore/IonButtonBehaviorSimpleFade.h>
#import <IonCore/IonButtonBehaviorTapTransform.h>

#pragma mark Animation System
/** Animation */
#import <IonCore/IonAnimationFrame.h>
#import <IonCore/IonAnimationMap.h>
#import <IonCore/IonAnimationSession.h>

#pragma mark Theme System
/** Theme System */
#import <IonCore/IonThemePointer.h>
#import <IonCore/IonStyle.h>
#import <IonCore/IonStyle+IonStdStyleApplyMethods.h>
#import <IonCore/IonTheme.h>
#import <IonCore/IonAttrubutesStanderdResolution.h>

// old
#import <IonCore/IonKVP+IonTheme.h>
#import <IonCore/NSDictionary+IonThemeResolution.h>

#pragma mark Validation
/** Input Filtering */
#import <IonCore/IonInputFilter.h>
//
//  IonData.h
//  IonData
//
//  Created by Andrew Hurst on 7/22/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FOUtilities/FOUtilities.h>
#import <SimpleMath/SimpleMath.h>

//! Project version number for IonData.
FOUNDATION_EXPORT double IonDataVersionNumber;

//! Project version string for IonData.
FOUNDATION_EXPORT const unsigned char IonDataVersionString[];


#import <IonData/NSDictionary+IonTypeExtension.h>
#import "NSDictionary+IonFile.h"
// TMP
#include "IonKeyValuePair.h"

#pragma mark Data Structures
// Data Sources
#import "IonMutableDictionary.h"

// Method Map
#import "IonMethodMap.h"

// Access Based Generation Map
#import "IonBalancedAccessBasedGenerationMap.h"
#import "IonKVPAccessBasedGenerationMap.h"
#import "IonAccessBasedGenerationMap.h"
#import "IonAsyncAccessBasedGenerationMap.h"

#pragma mark IO Managers
// File IO Manager
#import "IonPath.h"
#import "IonDirectory.h"
#import "IonFile.h"
#import "IonFileIOmanager.h"

#pragma mark Render Utilities
// Render Configuration Objects
#import "IonGradientConfiguration.h"

// Base Rendering
#include "IonRenderUtilities.h"

#pragma mark Data Store Managers
// Simple Cache
#import "IonSimpleCache.h"

// Image Manager
#import "IonImageRef.h"
#import "UIImage+IonImage.h"
#import "IonImageManager.h"

#pragma mark Callbacks
#import "IonDataTypes.h"

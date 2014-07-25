//
//  IonData.h
//  IonData
//
//  Created by Andrew Hurst on 7/22/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for IonData.
FOUNDATION_EXPORT double IonDataVersionNumber;

//! Project version string for IonData.
FOUNDATION_EXPORT const unsigned char IonDataVersionString[];


#pragma mark Math
// Standerd math Utilities
#include "IonMath.h"

#pragma mark Data Utilities
// Color Conversion 
#import "UIColor+IonColor.h"

// Data conversion
#import "NSData+IonTypeExtension.h"

// TMP
#include "IonKeyValuePair.h"

#pragma mark Data Structures
// Method Map
#include "IonMethodMap.h"

// Access Based Generation Map
#include "IonBalancedAccessBasedGenerationMap.h"
#include "IonKVPAccessBasedGenerationMap.h"
#include "IonAccessBasedGenerationMap.h"

// Extensions
#import "NSDictionary+IonTypeExtension.h"

#pragma mark IO Managers
// File IO Manager
#include "IonPath.h"
#include "IonDirectory.h"
#include "IonFile.h"
#include "IonFileIOmanager.h"

// URL Request Manager

#pragma mark Render Utilities
// Render Configuration Objects
#include "IonGradientConfiguration.h"

// Base Rendering
#include "IonRenderUtilities.h"

#pragma mark Data Store Managers
// Image Manager
#include "IonImageRef.h"
#include "IonImage.h"


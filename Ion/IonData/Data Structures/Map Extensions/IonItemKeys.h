//
//  IonItemKeys.h
//  Ion
//
//  Created by Andrew Hurst on 7/30/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#ifndef IonItemKeys
#define IonItemKeys

#import <Foundation/Foundation.h>

#pragma mark Color
static NSString* sIonColorKey = @"color";

#pragma mark Color Weight
static NSString* sIonColorWeightsKey = @"colorWeights";
static NSString* sIonWeightKey = @"weights";

#pragma mark Gradients
static NSString* sIonGradientTypeKey = @"type";
static NSString* sIonGradientTypeLinear = @"linear";
static NSString* sIonGradientTypeRadial = @"radial";

static NSString* sIonGradientAngleKey = @"angle";

#pragma mark Fonts
static NSString* sIonFontName = @"name";
static NSString* sIonFontSize = @"size";

#pragma mark UIKit Conversions
static NSString* sIonXKey = @"x";
static NSString* sIonYKey = @"y";

static NSString* sIonWidthKey = @"width";
static NSString* sIonHeightKey = @"height";

#endif // IonItemKeys
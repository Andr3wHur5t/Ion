//
//  IonDataTypes.h
//  Ion
//
//  Created by Andrew Hurst on 7/31/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef IonDataTypes
#define IonDataTypes

#pragma mark Callbacks

@class IonFile;

/**
 * General purpose result block.
 * @param {id} the returned object.
 */
typedef void(^IonResultBlock)( id returnedObject );

/**
 * General purpose completion block.
 * @param {NSError*} the returned error if any.
 */
typedef void(^IonCompletionBlock)(  NSError* error  );

/**
 * General purpose completion block.
 * @param {NSError*} the returned error if any.
 */
typedef void(^IonFileResultBlock)(  IonFile* error  );



#endif
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
 * @param returnedObject - the returned object.
 */
typedef void(^IonResultBlock)( id returnedObject );

/**
 * General purpose completion block.
 * @param error - the returned error if any.
 */
typedef void(^IonCompletionBlock)(  NSError *error  );

/**
 * General purpose completion block.
 * @param error - the returned error if any.
 */
typedef void(^IonFileResultBlock)(  IonFile *error  );

/**
 * The image return callback
 * @param image - the resulting image.
 
 */
typedef void(^IonImageReturn)( UIImage *image );



#endif
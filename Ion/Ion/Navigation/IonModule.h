//
//  IonModule.h
//  Ion
//
//  Created by Andrew Hurst on 10/5/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IonLink.h"

/**
 * An abstract endpoint class for Ions' navigation system.
 */
@interface IonModule : NSObject
#pragma mark Endpoint Interface
/**
 * Performs actions acording to the request in the link.
 * @param link - the link which caused the request to be invoked.
 * @returns True if the action was successfull, otherwise False.
 */
- (BOOL) invokeLink:(IonLink *)link;

@end

//
//  IACModule.h
//  IACommunication
//
//  Created by Andrew Hurst on 10/7/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IACLink;

/**
 * An abstract endpoint class.
 */
@interface IACModule : NSObject
/**
 * Performs actions acording to the request in the link.
 * @param link - the link which caused the request to be invoked.
 * @returns True if the action was successfull, otherwise False.
 */
- (BOOL) invokeLink:(IACLink *)link;

@end

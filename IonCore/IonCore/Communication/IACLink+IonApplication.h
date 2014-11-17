//
//  IACLink+IonApplication.h
//  IonCore
//
//  Created by Andrew Hurst on 10/14/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "IACLink.h"

@interface IACLink (IonApplication)

/**
 * Invokes the link on the current applications IACRouter.
 */
- (BOOL) invoke;

@end

//
//  IonApplication+InterappComunication.h
//  IonCore
//
//  Created by Andrew Hurst on 10/14/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <IonCore/IonApplication.h>

@class IACRouter;

@interface IonApplication (InterappComunication)

/**
 * Our application router, which all application comunication should go through.
 */
@property (nonatomic, readonly) IACRouter *router;

@end

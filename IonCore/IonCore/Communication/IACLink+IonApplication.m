//
//  IACLink+IonApplication.m
//  IonCore
//
//  Created by Andrew Hurst on 10/14/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "IACLink+IonApplication.h"
#import <IonCore/IonApplication.h>
#import <IonCore/IonApplication+InterappComunication.h>
#import "IonApplication+plistGetters.h"
#import <IonCore/IACRouter.h>

@implementation IACLink (IonApplication)

- (BOOL) invoke {
    IonApplication *sharedApplication;
    sharedApplication = [IonApplication sharedApplication];
    if ( !sharedApplication )
        return FALSE;
  
  if ( [IonApplication respondsToScheme:[NSURL URLWithString:self.urlString].scheme])
    // Invoke the link on our shared applications router
    return [sharedApplication.router invokeLink: self];
  else
    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.urlString]];
}

@end

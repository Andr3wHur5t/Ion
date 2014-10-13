//
//  UIWindow+IonWindow.m
//  Ion
//
//  Created by Andrew Hurst on 10/11/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "UIWindow+IonWindow.h"
#import "UIView+IonTheme.h"

@implementation UIWindow (IonWindow)
#pragma mark System Theme

- (void) setSystemTheme:(IonTheme *)systemTheme {
    if ( !systemTheme )
        return;
    
    [self.categoryVariables setObject: systemTheme forKey: @"systemTheme"];
    [self setIonTheme: self.systemTheme];
}

- (IonTheme *)systemTheme {
    return [self.categoryVariables objectForKey: @"systemTheme"];
}

@end

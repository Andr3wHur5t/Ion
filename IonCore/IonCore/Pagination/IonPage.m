//
//  IonPage.m
//  IonCore
//
//  Created by Andrew Hurst on 10/16/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "IonPage.h"

@implementation IonPage

@synthesize size = _size;
#pragma mark Construction

- (instancetype) initWithSize:(NSUInteger)size {
  self = [self init];
  if ( self )
    _size = size;
  return self;
}


@end

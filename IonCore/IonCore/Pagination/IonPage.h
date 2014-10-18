//
//  IonPage.h
//  IonCore
//
//  Created by Andrew Hurst on 10/16/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IonPage : NSObject

#pragma mark Refrence Objects
/**
 * Refrence to the next page.
 */
@property (strong, nonatomic, readonly) IonPage *nextPage;

/**
 * Refrence to the previous page.
 */
@property (strong, nonatomic, readonly) IonPage *previousPage;

@end

//
//  IonPage.h
//  IonCore
//
//  Created by Andrew Hurst on 10/16/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IonPage : NSObject

#pragma mark Construction
/*!
 @brief Constructs the page with the specified size score.
 
 @param size The size score of the page
 
 @return The configured page object.
 */
- (instancetype) initWithSize:(NSUInteger) size;

#pragma mark Scoring
/*!
 @brief The size score of the page.
 */
@property (assign, nonatomic, readonly) NSUInteger size;

#pragma mark Refrence Objects
/*!
 @brief Refrence to the next page.
 */
@property (strong, nonatomic, readwrite) IonPage *nextPage;

/*!
 @brief Refrence to the previous page.
 */
@property (strong, nonatomic, readwrite) IonPage *previousPage;

@end

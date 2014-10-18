//
//  PHText.h
//  PHData
//
//  Created by Andrew Hurst on 10/7/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PHText : NSObject
#pragma mark Lorem Ipsum
/**
 * Generates Lorem Ipsum text for the specified count of words.
 * @param wordCount - the ammount of words to generate.
 */
+ (NSString *)loremWithWordCount:(NSUInteger) wordCount;

@end

//
//  SAEventProcessor.h
//  SimpleAnalytics
//
//  Created by Andrew Hurst on 10/10/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SAEventsProcessor : NSObject

#pragma mark Interface
/**
 * Make the event processor process the inputted chunk.
 * @param chunk - the chunk to process.
 */
- (void) processChunk:(NSArray *)chunk;

@end

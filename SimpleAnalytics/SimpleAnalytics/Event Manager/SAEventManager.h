//
//  SAEventManager.h
//  SimpleAnalytics
//
//  Created by Andrew Hurst on 10/10/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SAEventFilter;
@class SAEventsProcessor;
@class SAEvent;

typedef enum : NSUInteger {
    SAEventManagerLoggingDepth_None = 0,
    SAEventManagerLoggingDepth_Shallow = 1,
    SAEventManagerLoggingDepth_Deep = 2,
} SAEventManagerLoggingDepth;

@interface SAEventManager : NSObject
#pragma mark Meta
/**
 * Number of entries per chunk.
 */
@property (assign, nonatomic, readwrite) NSUInteger chunkSize;

/**
 * The event recording filter to use.
 */
@property (strong, nonatomic, readonly) SAEventFilter *recordingFilter;

/**
 * The current depth of logging for the event manager.
 */
@property (assign, nonatomic, readwrite) SAEventManagerLoggingDepth loggingDepth;

#pragma mark Event Interface
/**
 * Adds the inputted event to the chunk.
 */
- (void) recordEvent:(SAEvent *)event;

#pragma mark Processor Management
/**
 * Adds the inputted chunk processor.
 * @param processor - the chunk processor to add.
 */
- (void) addProcessor:(SAEventsProcessor *)processor;

/**
 * Removes the inputted chunk processor.
 * @param processor - the chunk processor to remove.
 */
- (void) removeProcessor:(SAEventsProcessor *)processor;

/**
 * Removes all chunk processors.
 */
- (void) removeAllProcessors;

#pragma mark Singletons
/**
 * Gets the default event manager.
 */
+ (instancetype) defaultEventManager;

/**
 * Gets the method timing event manager.
 */
+ (instancetype) methodTimingEventManager;

@end

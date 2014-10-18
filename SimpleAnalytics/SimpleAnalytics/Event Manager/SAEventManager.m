//
//  SAEventManager.m
//  SimpleAnalytics
//
//  Created by Andrew Hurst on 10/10/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "SAEventManager.h"
#import "SAEventsProcessor.h"
#import "SAEventFilter.h"
#import "SAEvent.h"

const NSUInteger sSAEventManagerDefaultChunkSize = 250;

@interface SAEventManager ()

/**
 * Our processors array.
 */
@property (strong, nonatomic, readonly) NSMutableArray *processors;

/**
 * Our current chunk.
 */
@property (strong, nonatomic, readonly) NSMutableArray *currentChunk;
@end

@implementation SAEventManager

@synthesize processors = _processors;
@synthesize currentChunk = _currentChunk;

#pragma mark Constructors 

- (instancetype) init {
    self = [super init];
    if ( self ) {
        self.loggingDepth = SAEventManagerLoggingDepth_None;
        self.chunkSize = sSAEventManagerDefaultChunkSize;
    }
    return self;
}

#pragma mark Chunk Managent

- (NSMutableArray *)currentChunk {
    if ( !_currentChunk )
        _currentChunk = [[NSMutableArray alloc] init];
    return _currentChunk;
}

- (void) recordEvent:(SAEvent *)event {
    if ( ![event isKindOfClass: [SAEvent class]] /*![self.recordingFilter eventIsValid: event]*/ )
        return;
    [self.currentChunk addObject: event];
    [self checkChunk];
}

- (void) checkChunk {
    // Is the chunk full?
    if ( self.chunkSize <= self.currentChunk.count )
        [self reportChunk];
}

- (void) reportChunk {
    // Report the chunk to the processors.
    for ( SAEventsProcessor *processor in self.processors )
        [processor processChunk: self.currentChunk];
    
    // Clear chunk.
    [self.currentChunk removeAllObjects];
}

#pragma mark Processors

- (NSMutableArray *)processors {
    if ( !_processors )
        _processors = [[NSMutableArray alloc] init];
    return _processors;
}

- (void) addProcessor:(SAEventsProcessor *)processor {
    [self.processors addObject: processor];
}

- (void) removeProcessor:(SAEventsProcessor *)processor {
    [self.processors removeObject: processor];
}

- (void) removeAllProcessors {
    [self.processors removeAllObjects];
}

#pragma mark Singletons

+ (instancetype) defaultEventManager {
    static SAEventManager *defaultEventManager;
    static dispatch_once_t defaultEventManager_onceToken;
    dispatch_once( &defaultEventManager_onceToken, ^{
        defaultEventManager = [[[self class] alloc] init];
    });
    return defaultEventManager;
}

+ (instancetype) methodTimingEventManager{
    static SAEventManager *methodTimingEventManager;
    static dispatch_once_t methodTimingEventManager_onceToken;
    dispatch_once( &methodTimingEventManager_onceToken, ^{
        methodTimingEventManager = [[[self class] alloc] init];
    });
    return methodTimingEventManager;
}

@end

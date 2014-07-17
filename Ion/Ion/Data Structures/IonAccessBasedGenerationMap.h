//
//  IonAccessBasedGenerationMap.h
//  Ion
//
//  Created by Andrew Hurst on 7/16/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id(^IonGenerationBlock)( id data );

@interface IonAccessBasedGenerationMap : NSObject

/**
 * Constructors
 */
- (instancetype) initWithRawData:(NSDictionary*) data;
- (instancetype) initWithRawData:(NSDictionary*) data
              andGenerationBlock:(IonGenerationBlock) itemGenerationBlock;

-(void) setRawData:(NSDictionary*) data;

/**
 * This sets of the generation block.
 */
- (void) setGenerationBlock:(IonGenerationBlock) newGenerationBlock;

/**
 * This is where you request objects.
 */
- (id) objectForKey:(id) key;

@end

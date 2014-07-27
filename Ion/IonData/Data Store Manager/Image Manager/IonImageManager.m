//
//  IonImageManager.m
//  Ion
//
//  Created by Andrew Hurst on 7/25/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonImageManager.h"

@interface IonImageManager ()

/** Our image cache. where we store our raw and resized images.
 */
@property (strong, nonatomic) NSDictionary* cache;

/** Our key map.
 */
@property (strong, nonatomic) NSMutableDictionary* keyMap;

@end

@implementation IonImageManager

@end

/* ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== =====
 *                                      Ion Size
 * ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== */
@interface IonSize : NSObject
#pragma mark Constructors
/**
 * Constructs a Ion Size.
 * @returns {IonSize}
 */
+ (IonSize*) sizeWithSize:(CGSize) size;

/**
 * Constructs a Ion Size.
 * @returns {instancetype}
 */
- (instancetype) initIonSize:(CGSize) size;

#pragma mark Size
/** The size object
 */
@property (assign, nonatomic) CGSize size;

@end

@implementation IonSize

#pragma mark Constructors
/**
 * Constructs a Ion Size.
 * @returns {IonSize}
 */
+ (IonSize*) sizeWithSize:(CGSize) size {
    return [[IonSize alloc] initIonSize: size];
}

/**
 * Constructs a Ion Size.
 * @returns {instancetype}
 */
- (instancetype) initIonSize:(CGSize) size {
    self = [self init];
    if ( self )
        self.size = size;
    return self;
}

@end



//
//  IonGuideTargetToken.m
//  Ion
//
//  Created by Andrew Hurst on 9/21/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonGuideTargetToken.h"


@interface IonGuideTargetToken () {
    // There is an issue with auto sysntsization on blocks, we neet to keep this as an ivar.
    IonGuideLineProcessingBlock _processingBlock;
}

@end

@implementation IonGuideTargetToken
#pragma mark Constructors
/**
 * Constructs a token with the inputted key path, and observed object.
 * @param {id} the observed object.
 * @param {NSString*} the key path to observe.
 * @param {IonGuideLineProcessingBlock} the processing block used to process the value.
 * @returns {instancetype}
 */
- (instancetype) initWithObservedObject:(id) object
                                keyPath:(NSString *)keyPath
                     andProcessingBlock:(IonGuideLineProcessingBlock) processingBlock {
    self = [self init];
    if ( self ) {
        _observedObject = object;
        _keyPath = keyPath;
        self.processingBlock = processingBlock;
    }
    return self;
}

/**
 * Constructs a token with the inputted key path, and observed object.
 * @param {id} the observed object.
 * @param {NSString*} the key path to observe.
 * @returns {instancetype}
 */
- (instancetype) initWithObservedObject:(id) object andKeyPath:(NSString *)keyPath {
    return [self initWithObservedObject: object
                                keyPath: keyPath
                     andProcessingBlock: [[self class] defaultProcessingBlock]];
}


/**
 * Constructs a token with the inputted key path, and observed object.
 * @param {id} the observed object.
 * @param {NSString*} the key path to observe.
 * @param {IonGuideLineProcessingBlock} the processing block used to process the value.
 * @returns {instancetype}
 */
+ (instancetype) tokenWithObservedObject:(id) object
                                 keyPath:(NSString *)keyPath
                      andProcessingBlock:(IonGuideLineProcessingBlock) processingBlock {
    return [[[self class] alloc] initWithObservedObject: object
                                                keyPath: keyPath
                                     andProcessingBlock: processingBlock];
}

/**
 * Constructs a token with the inputted key path, and observed object.
 * @param {id} the observed object.
 * @param {NSString*} the key path to observe.
 * @returns {instancetype}
 */
+ (instancetype) tokenWithObservedObject:(id) object andKeyPath:(NSString *)keyPath {
    return [[[self class] alloc] initWithObservedObject: object
                                             andKeyPath: keyPath];
}

#pragma mark processing block
/**
 * Gets the set, or default processing block.
 * @returns {IonGuideLineProcessingBlock}
 */
- (IonGuideLineProcessingBlock) processingBlock {
    if ( !_processingBlock )
        _processingBlock = [[self class] defaultProcessingBlock];
    return _processingBlock;
}

/**
 * Sets the processing block.
 */
- (void) setProcessingBlock:(IonGuideLineProcessingBlock) processingBlock {
    _processingBlock = processingBlock;
}

#pragma mark Value
/**
 * Gets the current raw value of the target at the specified key path if any.
 * @returns {id}
 */
- (id) rawValue {
    if ( !self.observedObject || !self.keyPath || ![self.keyPath isKindOfClass: [NSString class]] ) {
         NSAssert( true, @"Can't get value, did not init with valid values. key path: %@, observed object: %@",
                  self.keyPath, self.observedObject );
        return NULL;
    }
    return [self.observedObject valueForKeyPath: self.keyPath];
}

/**
 * Gets the current processed value.
 * @returns {CGFloat}
 */
- (CGFloat) processedValue {
    return self.processingBlock( self.rawValue );
}

#pragma mark Observer
/**
 * Configures the observer to invokes the target with the selector.
 * @param {id} the observers target.
 * @param {SEL} the observers target selector.
 */
- (void) configureObserverWithTarget:(id) target andSelector:(SEL) selector {
    // Have we been configured?
    if ( !self.keyPath || !self.observedObject ) {
        NSAssert( true, @"Can't configure, did not init with valid values. key path: %@, observed object: %@", self.keyPath, self.observedObject );
        return;
    }
    _observer = [IonKeyValueObserver observeObject: self.observedObject
                                           keyPath: self.keyPath
                                            target: target
                                          selector: selector
                                           options: NSKeyValueObservingOptionNew |
                                                    NSKeyValueObservingOptionOld]; // Default options
}

#pragma mark Debug
/**
 * The description of the token.
 * @returns {NSString*}
 */
- (NSString *)description {
    return [NSString stringWithFormat:@"observing %@ on %@", self.keyPath, NSStringFromClass( [self.observedObject class])];
}


#pragma mark Processing Blocks

/**
 * The default processing block.
 * @returns {IonGuideLineProcessingBlock}
 */
+ (IonGuideLineProcessingBlock) defaultProcessingBlock {
    return ^CGFloat( id data ) {
        if ( !data || ![data isKindOfClass: [NSValue class]] )
            return 0.0f;
        return [(NSValue*)data toFloat];
    };
}

// Basic Blocks

/**
 * Rect size processing block.
 * @param {IonGuideLineFrameMode} the axis to extract
 * @returns {IonGuideLineProcessingBlock}
 */
+ (IonGuideLineProcessingBlock) rectSizeProcessingBlockUsingMode:(IonGuideLineFrameMode) mode {
    return ^CGFloat( id data ) {
        CGSize size;
        if ( !data || ![data isKindOfClass: [NSValue class]] )
            return 0.0f;
        
        size = [(NSValue*)data CGRectValue].size;
        return mode == IonGuideLineFrameMode_Vertical ? size.height : size.width;
    };
}

/**
 * Size processing block.
 * @param {IonGuideLineFrameMode} the axis to extract
 * @returns {IonGuideLineProcessingBlock}
 */
+ (IonGuideLineProcessingBlock) sizeProcessingBlockUsingMode:(IonGuideLineFrameMode) mode {
    return ^CGFloat( id data ) {
        CGSize size;
        if ( !data || ![data isKindOfClass: [NSValue class]] )
            return 0.0f;
        
        size = [(NSValue*)data CGSizeValue];
        return mode == IonGuideLineFrameMode_Vertical ? size.height : size.width;
    };
}

/**
 * Point processing block.
 * @param {IonGuideLineFrameMode} the axis to extract
 * @returns {IonGuideLineProcessingBlock}
 */
+ (IonGuideLineProcessingBlock) pointProcessingBlockUsingMode:(IonGuideLineFrameMode) mode {
    return ^CGFloat( id data ) {
        CGPoint point;
        if ( !data || ![data isKindOfClass: [NSValue class]] )
            return 0.0f;
        
        point = [(NSValue*)data CGPointValue];
        return mode == IonGuideLineFrameMode_Vertical ? point.y : point.x;
    };
}

/**
 * External position processing block.
 * @param {IonGuideLineFrameMode} the axis to extract
 * @returns {IonGuideLineProcessingBlock}
 */
+ (IonGuideLineProcessingBlock) externalPositioningProcessingBlockUsingMode:(IonGuideLineFrameMode) mode {
    return [[self class] externalPositioningProcessingBlockUsingMode: mode
                                                           andAmount: 1.0f];
}

/**
 * External position processing block.
 * @param {IonGuideLineFrameMode} the axis to extract
 * @param {CGFloat} the amount of the size to use
 * @returns {IonGuideLineProcessingBlock}
 */
+ (IonGuideLineProcessingBlock) externalPositioningProcessingBlockUsingMode:(IonGuideLineFrameMode) mode
                                                                  andAmount:(CGFloat) amount {
    return ^CGFloat( id data ) {
        CGRect frame;
        if ( !data || ![data isKindOfClass: [NSValue class]] )
            return 0.0f;
        frame = [(NSValue*)data CGRectValue];
        return ((mode == IonGuideLineFrameMode_Vertical ? frame.size.height : frame.size.width) * amount ) + (mode == IonGuideLineFrameMode_Vertical ? frame.origin.y : frame.origin.x);
    };
}

/**
 * Constant value processing block.
 * @param {CGFloat} the value to return
 * @returns {IonGuideLineProcessingBlock}
 */
+ (IonGuideLineProcessingBlock) constantProcessingBlockUsingValue:(CGFloat) val {
    return ^CGFloat( id data ) {
        return val;
    };
}


@end

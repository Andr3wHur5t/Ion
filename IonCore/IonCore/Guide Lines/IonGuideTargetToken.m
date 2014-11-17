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

- (instancetype) initWithObservedObject:(id) object andKeyPath:(NSString *)keyPath {
    return [self initWithObservedObject: object
                                keyPath: keyPath
                     andProcessingBlock: [[self class] defaultProcessingBlock]];
}

+ (instancetype) tokenWithObservedObject:(id) object
                                 keyPath:(NSString *)keyPath
                      andProcessingBlock:(IonGuideLineProcessingBlock) processingBlock {
    return [[[self class] alloc] initWithObservedObject: object
                                                keyPath: keyPath
                                     andProcessingBlock: processingBlock];
}

+ (instancetype) tokenWithObservedObject:(id) object andKeyPath:(NSString *)keyPath {
    return [[[self class] alloc] initWithObservedObject: object
                                             andKeyPath: keyPath];
}

#pragma mark processing block

- (IonGuideLineProcessingBlock) processingBlock {
    if ( !_processingBlock )
        _processingBlock = [[self class] defaultProcessingBlock];
    return _processingBlock;
}

- (void) setProcessingBlock:(IonGuideLineProcessingBlock) processingBlock {
    _processingBlock = processingBlock;
}

#pragma mark Value

- (id) rawValue {
    if ( !self.observedObject || !self.keyPath || ![self.keyPath isKindOfClass: [NSString class]] ) {
         NSAssert( true, @"Can't get value, did not init with valid values. key path: %@, observed object: %@",
                  self.keyPath, self.observedObject );
        return NULL;
    }
    return [self.observedObject valueForKeyPath: self.keyPath];
}

- (CGFloat) processedValue {
    return self.processingBlock( self.rawValue );
}

#pragma mark Observer

- (void) configureObserverWithTarget:(id) target andSelector:(SEL) selector {
    // Have we been configured?
    if ( !self.keyPath || !self.observedObject ) {
        NSAssert( true, @"Can't configure, did not init with valid values. key path: %@, observed object: %@", self.keyPath, self.observedObject );
        return;
    }
    _observer = [FOKeyValueObserver observeObject: self.observedObject
                                          keyPath: self.keyPath
                                           target: target
                                         selector: selector
                                          options: NSKeyValueObservingOptionNew |
                                                    NSKeyValueObservingOptionOld]; // Default options
}

#pragma mark Debug

- (NSString *)description {
    return [NSString stringWithFormat:@"observing %@ on %@", self.keyPath, NSStringFromClass( [self.observedObject class])];
}


#pragma mark Processing Blocks

+ (IonGuideLineProcessingBlock) defaultProcessingBlock {
    return ^CGFloat( id data ) {
        if ( ![data respondsToSelector: @selector(toFloat)] )
            return 0.0f;
        return [(NSValue*)data toFloat];
    };
}

// Basic Blocks

+ (IonGuideLineProcessingBlock) rectSizeProcessingBlockUsingMode:(IonGuideLineFrameMode) mode {
    return ^CGFloat( id data ) {
        CGSize size;
        if ( !data || ![data isKindOfClass: [NSValue class]] )
            return 0.0f;
        
        size = [(NSValue*)data CGRectValue].size;
        return mode == IonGuideLineFrameMode_Vertical ? size.height : size.width;
    };
}

+ (IonGuideLineProcessingBlock) sizeProcessingBlockUsingMode:(IonGuideLineFrameMode) mode
                                                   andAmount:(CGFloat) amount {
    return ^CGFloat( id data ) {
        CGSize size;
        if ( !data || ![data isKindOfClass: [NSValue class]] )
            return 0.0f;
        
        size = [(NSValue*)data CGSizeValue];
        return (mode == IonGuideLineFrameMode_Vertical ? size.height : size.width) * amount;
    };
}

+ (IonGuideLineProcessingBlock) sizeProcessingBlockUsingMode:(IonGuideLineFrameMode) mode {
    return [[self class] sizeProcessingBlockUsingMode: mode andAmount: 1.0f];
}


+ (IonGuideLineProcessingBlock) pointProcessingBlockUsingMode:(IonGuideLineFrameMode) mode
                                                    andAmount:(CGFloat) amount {
    return ^CGFloat( id data ) {
        CGPoint point;
        if ( !data || ![data isKindOfClass: [NSValue class]] )
            return 0.0f;
        
        point = [(NSValue*)data CGPointValue];
        return (mode == IonGuideLineFrameMode_Vertical ? point.y : point.x) * amount;
    };
}

+ (IonGuideLineProcessingBlock) pointProcessingBlockUsingMode:(IonGuideLineFrameMode) mode {
    return [[self class] pointProcessingBlockUsingMode: mode andAmount: 1.0f];
}

+ (IonGuideLineProcessingBlock) externalPositioningProcessingBlockUsingMode:(IonGuideLineFrameMode) mode {
    return [[self class] externalPositioningProcessingBlockUsingMode: mode
                                                           andAmount: 1.0f];
}

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

+ (IonGuideLineProcessingBlock) constantProcessingBlockUsingValue:(CGFloat) val {
    return ^CGFloat( id data ) {
        return val;
    };
}


@end

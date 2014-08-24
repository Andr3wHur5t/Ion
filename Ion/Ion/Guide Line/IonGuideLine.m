//
//  IonGuideLine.m
//  Ion
//
//  Created by Andrew Hurst on 8/21/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonGuideLine.h"
#import "IonView.h"
#import <IonData/IonData.h>

@interface IonGuideLine () {
    /**
     * The target observation token which maintains observation.
     */
    id targetObservationToken;
    
    // The calc block
    IonGuildLineCalcBlock _calcBlock;
    IonGuideLineProcessingBlock _processingBlock;
}

@end

@implementation IonGuideLine
#pragma mark Constructors

/**
 * Constructs a guide line with the inputted blocks, and target information.
 * @param {id} the target object to get the watched value from.
 * @param {NSString*} the key path of the value to watch on the target object.
 * @param {IonGuideLineProcessingBlock} the block to use in processing the watched value on updates.
 * @param {IonGuildLineCalcBlock} the calculation block used to calculate the resulting position.
 * @returns {instancetype}
 */
- (instancetype) initWithTarget:(id) target
                        keyPath:(NSString*) keyPath
                processingBlock:(IonGuideLineProcessingBlock) processingBlock
                   andCalcBlock:(IonGuildLineCalcBlock) calcBlock {
    self = [self init];
    if ( self ) {
        // force set the position.
        self.position = 0.0f;
        
        // Set Blocks
        _processingBlock = processingBlock;
        _calcBlock = calcBlock;
        
        // Set Target
        if ( target && keyPath && [keyPath isKindOfClass:[NSString class]] )
            [self setTarget: target usingKeyPath: keyPath];
        
    }
    return self;
}

/**
 * Constructs a guide line with the inputted block, and target information.
 * @param {id} the target object to get the watched value from.
 * @param {NSString*} the key path of the value to watch on the target object.
 * @param {IonGuildLineCalcBlock} the calculation block used to calculate the resulting position.
 * @returns {instancetype}
 */
- (instancetype) initWithTarget:(id) target
                        keyPath:(NSString*) keyPath
                   andCalcBlock:(IonGuildLineCalcBlock) calcBlock {
    return [self initWithTarget: target
                        keyPath: keyPath
                processingBlock: NULL
                   andCalcBlock: calcBlock];
}

/**
 * Constructs a guide line with the inputted block, and target information.
 * @param {id} the target object to get the watched value from.
 * @param {NSString*} the key path of the value to watch on the target object.
 * @param {IonGuideLineProcessingBlock} the block to use in processing the watched value on updates.
 * @returns {instancetype}
 */
- (instancetype) initWithTarget:(id) target
                        keyPath:(NSString*) keyPath
             andProcessingBlock:(IonGuideLineProcessingBlock) processingBlock {
    return [self initWithTarget: target
                        keyPath: keyPath
                processingBlock: processingBlock
                   andCalcBlock: NULL];
}


/**
 * Constructs a guide line with the target information.
 * @param {id} the target object to get the watched value from.
 * @param {NSString*} the key path of the value to watch on the target object.
 * @returns {instancetype}
 */
- (instancetype) initWithTarget:(id) target
                     andKeyPath:(NSString*) keyPath {
    return [self initWithTarget: target
                        keyPath: keyPath
                processingBlock: NULL
                   andCalcBlock: NULL];
}

/**
 * Constructs a guide line as a child of the current guide line with the specified calculation block.
 * @param {IonGuildLineCalcBlock} the calculation block used to calculate the resulting position.
 * @returns {instancetype}
 */
- (instancetype) guideAsChildUsingCalcBlock:(IonGuildLineCalcBlock) calcBlock {
    return [[self class] guideWithTarget: self keyPath: @"position" andCalcBlock: calcBlock];
}

/**
 * Constructs a guide line as a child of the current guide line.
 * @returns {instancetype}
 */
- (instancetype) guideAsChild {
    return [self guideAsChildUsingCalcBlock: NULL];
}

/**
 * Constructs a guide line with the inputted blocks, and target information.
 * @param {id} the target object to get the watched value from.
 * @param {NSString*} the key path of the value to watch on the target object.
 * @param {IonGuideLineProcessingBlock} the block to use in processing the watched value on updates.
 * @param {IonGuildLineCalcBlock} the calculation block used to calculate the resulting position.
 * @returns {instancetype}
 */
+ (instancetype) guideWithTarget:(id) target
                         keyPath:(NSString*) keyPath
                 processingBlock:(IonGuideLineProcessingBlock) processingBlock
                    andCalcBlock:(IonGuildLineCalcBlock) calcBlock {
    return [[self alloc] initWithTarget: target
                        keyPath: keyPath
                processingBlock: processingBlock
                   andCalcBlock: calcBlock];
}

/**
 * Constructs a guide line with the inputted block, and target information.
 * @param {id} the target object to get the watched value from.
 * @param {NSString*} the key path of the value to watch on the target object.
 * @param {IonGuildLineCalcBlock} the calculation block used to calculate the resulting position.
 * @returns {instancetype}
 */
+ (instancetype) guideWithTarget:(id) target
                         keyPath:(NSString*) keyPath
                    andCalcBlock:(IonGuildLineCalcBlock) calcBlock {
    return [[self alloc] initWithTarget: target
                                keyPath: keyPath
                        processingBlock: NULL
                           andCalcBlock: calcBlock];
}

/**
 * Constructs a guide line with the inputted block, and target information.
 * @param {id} the target object to get the watched value from.
 * @param {NSString*} the key path of the value to watch on the target object.
 * @param {IonGuideLineProcessingBlock} the block to use in processing the watched value on updates.
 * @returns {instancetype}
 */
+ (instancetype) guideWithTarget:(id) target
                         keyPath:(NSString*) keyPath
              andProcessingBlock:(IonGuideLineProcessingBlock) processingBlock {
    return [[self alloc] initWithTarget: target
                                keyPath: keyPath
                        processingBlock: processingBlock
                           andCalcBlock: NULL];
}

/**
 * Constructs a guide line with the target information.
 * @param {id} the target object to get the watched value from.
 * @param {NSString*} the key path of the value to watch on the target object.
 * @returns {instancetype}
 */
+ (instancetype) guideWithTarget:(id) target
                      andKeyPath:(NSString*) keyPath {
    return [[self alloc] initWithTarget: target
                                keyPath: keyPath
                        processingBlock: NULL
                           andCalcBlock: NULL];
}

#pragma mark Default UIView Based Guides

/**
 * Constructs a guide line based off the inputted view frames' size, using the mode to specify axis, and amount specifying how much.
 * @param {UIView*} the view to base the guide off of.
 * @param {CGFloat} the percentage to use.
 * @param {IonGuideLineFrameMode} the mode specifying axis to use
 * @returns {instancetype}
 */
+ (instancetype) guideFromViewFrameSize:(UIView*) view
                           usingAmount:(CGFloat) amount
                                andMode:(IonGuideLineFrameMode) mode {
    NSParameterAssert( view && [view isKindOfClass: [UIView class]]);
    if ( !view || ![view isKindOfClass:[UIView class]] )
        return NULL;
    
    return [[self class] guideWithTargetRectSize: view
                                usingRectKeyPath: @"frame"
                                          amount: amount
                                         andMode: mode];
}


/**
 * Constructs a guide line based off the inputted views' corner radius, using the mode to specify axis.
 * @param {UIView*} the view to base the guide off of.
 * @param {IonGuideLineFrameMode} the mode specifying axis to use
 * @returns {instancetype}
 */
+ (instancetype) guideFromViewCornerRadius:(UIView*) view usingMode:(IonGuideLineFrameMode) mode {
    NSParameterAssert( view && [view isKindOfClass: [UIView class]]);
    if ( !view || ![view isKindOfClass:[UIView class]] )
        return NULL;
    
    return [[self class] guideWithTarget: view andKeyPath: @"layer.cornerRadius"];
}

/**
 * Constructs a guide line based off the inputted views' style margin, using the mode to specify axis.
 * @param {IonView*} the view to base the guide off of.
 * @param {IonGuideLineFrameMode} the mode specifying axis to use
 * @returns {instancetype}
 */
+ (instancetype) guideFromViewStyleMargin:(IonView*) view usingMode:(IonGuideLineFrameMode) mode {
    NSParameterAssert( view && [view isKindOfClass: [UIView class]]);
    if ( !view || ![view isKindOfClass:[UIView class]] )
        return NULL;
    
    return [[self class] guideWithTarget: view
                                 keyPath: @"styleMargin"
                         processingBlock: [[self class] sizeProcessingBlockUsingMode: mode]
                            andCalcBlock: [[self class] defaultCalculationBlock]];
}

/**
 * Constructs a guide line based off the inputted views' corner radius, and style margin, using the mode to specify axis.
 * @param {IonView*} the view to base the guide off of.
 * @param {IonGuideLineFrameMode} the mode specifying axis to use
 * @returns {instancetype}
 */
+ (instancetype) guideFromViewAutoMargin:(IonView*) view usingMode:(IonGuideLineFrameMode) mode  {
    NSParameterAssert( view && [view isKindOfClass: [UIView class]]);
    if ( !view || ![view isKindOfClass:[UIView class]] )
        return NULL;
    
    return [[self class] guideWithTarget: view
                                 keyPath: @"autoMargin"
                         processingBlock: [[self class] sizeProcessingBlockUsingMode: mode]
                            andCalcBlock: [[self class] defaultCalculationBlock]];
}

#pragma mark Frame Based Guides

/**
 * Constructs a guide line based off the inputted object frames' size, using the mode to specify axis, and amount specifying how much.
 * @param {id} the target object to base off of.
 * @param {NSString*} the key path of the rect to use.
 * @param {CGFloat} the amount to use.
 * @param {IonGuideLineFrameMode} the mode specifying axis to use
 * @returns {instancetype}
 */
+ (instancetype) guideWithTargetRectSize:(id) target
                        usingRectKeyPath:(NSString*) keyPath
                                  amount:(CGFloat) amount
                                 andMode:(IonGuideLineFrameMode) mode {
    NSParameterAssert( target );
    NSParameterAssert( keyPath && [keyPath isKindOfClass: [NSString class]]);
    if ( !target || !keyPath || ![keyPath isKindOfClass:[NSString class]] )
        return NULL;
    
    return [[self class] guideWithTarget: target
                                 keyPath: keyPath
                         processingBlock: [[self class] rectSizeProcessingBlockUsingMode: mode]
                            andCalcBlock: ^CGFloat(CGFloat target) {
                                return target * amount;
                            }];
}

/**
 * Constructs a guide line based off the inputted object frames' size combined with origin to get the external position, using the mode to specify axis, and amount specifying how much of the size to use.
 * @param {id} the target object to base off of.
 * @param {NSString*} the key path of the rect to use.
 * @param {CGFloat} the amount to use.
 * @param {IonGuideLineFrameMode} the mode specifying axis to use
 * @returns {instancetype}
 */
+ (instancetype) guideWithTargetRectPosition:(id) target
                            usingRectKeyPath:(NSString*) keyPath
                                      amount:(CGFloat) amount
                                     andMode:(IonGuideLineFrameMode) mode {
    NSParameterAssert( target );
    NSParameterAssert( keyPath && [keyPath isKindOfClass: [NSString class]]);
    if ( !target || !keyPath || ![keyPath isKindOfClass:[NSString class]] )
        return NULL;
    
    return [[self class] guideWithTarget: target
                                 keyPath: keyPath
                      andProcessingBlock: [[self class] externalPositioningProcessingBlockUsingMode: mode
                                                                                          andAmount: amount]];
}

#pragma mark Change Subscription

/**
 * Configures a guideline to subscribe to changes in this guide line as a child.
 * @param {IonGuideLine*} the guide line to set.
 * @returns {void}
 */
- (void) configureGuideLineAsChild:(IonGuideLine*) line {
    NSParameterAssert( line && [line isKindOfClass: [IonGuideLine class]] );
    if ( !line || ![line isKindOfClass:[IonGuideLine class]] )
        return;
    
    [line setTarget: self usingKeyPath: @"position"];
}

/**
 * Sets the target value to base our position off of.
 * @param {id} the targets' object.
 * @param {NSString*} the key to observe.
 * @returns {void}
 */
- (void) setTarget:(id) target usingKeyPath:(NSString*) keyPath {
    NSParameterAssert( target );
    NSParameterAssert( keyPath && [keyPath isKindOfClass: [NSString class]] );
    if ( !target || !keyPath || ![keyPath isKindOfClass:[NSString class]] )
        return;
    
    targetObservationToken = NULL;
    targetObservationToken = [IonKeyValueObserver observeObject: target
                                                        keyPath: keyPath
                                                         target: self
                                                       selector: @selector(processChange:)
                                                        options: NSKeyValueObservingOptionInitial |
                                                                 NSKeyValueObservingOptionNew ];
}

#pragma mark Block Getters

/**
 * Gets the processing block, if the processing block doesn't exist replace it with the default one.
 * @returns {IonGuideLineProcessingBlock}
 */
- (IonGuideLineProcessingBlock) processingBlock {
    if ( !_processingBlock )
        _processingBlock = [IonGuideLine defaultProcessingBlock];
    return _processingBlock;
}

/**
 * Sets the processing block
 * @param {IonGuideLineProcessingBlock} the new processing block
 * @returns {void}
 */
- (void) setProcessingBlock:(IonGuideLineProcessingBlock)processingBlock {
    _processingBlock = processingBlock;
}

/**
 * Gets the calculation block, if it doesn't exist replace it with the default one.
 * @returns {IonGuildLineCalcBlock} the calculation block, or default calculation block if it has not been set
 */
- (IonGuildLineCalcBlock) calcBlock {
    if ( !_calcBlock )
        _calcBlock = [IonGuideLine defaultCalculationBlock];
    return _calcBlock;
}

/**
 * Sets the calcBlock
 * @param {IonGuildLineCalcBlock} the new calc block
 * @returns {void}
 */
- (void) setCalcBlock:(IonGuildLineCalcBlock)calcBlock {
    _calcBlock = calcBlock;
}


#pragma mark Calculation

/**
 * Updates the position to be compliant with the target.
 * @param {NSDictionary*} the dictionary representing the KVO change.
 * @returns {void}
 */
- (void) processChange:(NSDictionary*) change {
    id newValue;
    NSParameterAssert( change && [change isKindOfClass:[NSDictionary class]] );
    NSParameterAssert( self.processingBlock );
    if ( !change || ![change isKindOfClass:[NSDictionary class]] || !self.processingBlock )
        return;
    
    // Get the raw data
    newValue = [change objectForKey: NSKeyValueChangeNewKey];
    
    // Process and update
    [self updatePosition: self.processingBlock( newValue ) ];
}

/**
 * Updates the position to match the inputted position after calculation.
 * @param {CGFloat} the new position to use for calculation.
 * @returns {void}
 */
- (void) updatePosition:(CGFloat) newPosition {
    CGFloat newVal;
    NSParameterAssert( self.calcBlock );
    if ( !self.calcBlock || newPosition == self.position)
        return;
    
    newVal = self.calcBlock( newPosition );
    if ( self.position != newVal )
        self.position = newVal;
}

/**
 * Debug Description
 */
- (NSString*) description {
    return [NSString stringWithFormat:@"%f", _position];
}
#pragma mark Calculation Blocks

/**
 * The default calculation block.
 * @returns {IonGuildLineCalcBlock}
 */
+ (IonGuildLineCalcBlock) defaultCalculationBlock {
    return ^CGFloat( CGFloat target ) {
        return target;
    };
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
        return  ((mode == IonGuideLineFrameMode_Vertical ? frame.size.height : frame.size.width)  * amount )+
                (mode == IonGuideLineFrameMode_Vertical ? frame.origin.y : frame.origin.x);
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

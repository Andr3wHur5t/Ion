//
//  IonGuideLine.m
//  Ion
//
//  Created by Andrew Hurst on 8/21/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonGuideLine.h"
#import <IonData/IonData.h>

@interface IonGuideLine () {
    /**
     * The target observation token which maintains observation.
     */
    id targetObservationToken;
    
    // The calc block
    IonGuildLineCalcBlock _calcBlock;
    IonGuideLineProcessingBlock _processingBlock;
    
    // Dependents
    NSMutableArray* _dependentVariables;
}

/**
 * The dependent variables
 */
@property (strong, nonatomic, readonly) NSMutableArray* dependentVariables;
@end

@implementation IonGuideLine
#pragma mark Constructors

/**
 * Constructs a guide line based off the inputted value.
 * @param {CGFloat} the value to return.
 * @returns {instancetype}
 */
- (instancetype) initWithStaticValue:(CGFloat) value {
    self = [super init];
    if ( self ) {
        self.position = value;
    }
    return self;
}

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

#pragma mark Dependents

/**
 * Gets, or creates the dependent variables list.
 * @returns {NSMutableDictionary*}
 */
- (NSMutableArray*) dependentVariables {
    if ( !_dependentVariables )
        _dependentVariables = [[NSMutableArray alloc] init];
    return _dependentVariables;
}

/**
 * Adds a dependent variable for us to subcribe to changes to.
 * @param {id} the target of the dependent variable.
 * @param {NSString*} the key path of the dependent variable.
 * @rerurns {void}
 */
- (void) addDependentTarget:(id) target andKeyPath:(NSString*) keyPath {
    [self.dependentVariables addObject: [IonKeyValueObserver observeObject: target
                                                                   keyPath: keyPath
                                                                    target: self
                                                                  selector: @selector(updatePosition)
                                                                   options: NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew]];
    return;
}

/**
 * Removes a dependent variable, and unsubscribes to the changes.
 * @param {id} the target of the dependent variable.
 * @param {NSString*} the key path of the dependent variable.
 * @rerurns {void}
 */
- (void) removeDependentTarget:(id) target andKeyPath:(NSString*) keyPath {
    NSParameterAssert( target );
    NSParameterAssert( keyPath && [keyPath isKindOfClass: [NSString class]] );
    if ( !target || !keyPath || ![keyPath isKindOfClass: [NSString class]] )
        return;
    
    for ( IonKeyValueObserver* obv in self.dependentVariables )
        if ( [obv matchesTarget: target andKeyPath: keyPath] )
            [self.dependentVariables removeObject: obv];
}

/**
 * Updates the position based off of dependents.
 * @returns {void}
 */
- (void) updatePosition {
    CGFloat newVal;
    
    newVal = self.calcBlock( self.position );
    if ( self.position != newVal )
        self.position = newVal;
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

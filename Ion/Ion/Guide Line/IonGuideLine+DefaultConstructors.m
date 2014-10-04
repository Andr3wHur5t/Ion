//
//  IonGuideLine+DefaultConstructors.m
//  Ion
//
//  Created by Andrew Hurst on 8/26/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonGuideLine+DefaultConstructors.h"
#import "IonGuideLine+DependentGuides.h"
#import "UIView+IonTheme.h"

@implementation IonGuideLine (DefaultConstructors)
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
 * @param {UIView*} the view to base the guide off of.
 * @param {IonGuideLineFrameMode} the mode specifying axis to use
 * @returns {instancetype}
 */
+ (instancetype) guideFromViewStyleMargin:(UIView*) view usingMode:(IonGuideLineFrameMode) mode {
    NSParameterAssert( view && [view isKindOfClass: [UIView class]]);
    if ( !view || ![view isKindOfClass:[UIView class]] )
        return NULL;
    
    return [[self class] guideWithTarget: view
                                 keyPath: @"styleMargin"
                         processingBlock: [IonGuideTargetToken sizeProcessingBlockUsingMode: mode]
                            andCalcBlock: [[self class] defaultCalculationBlock]];
}

/**
 * Constructs a guide line based off the inputted views' style padding, using the mode to specify axis.
 * @param {UIView*} the view to base the guide off of.
 * @param {IonGuideLineFrameMode} the mode specifying axis to use
 * @returns {instancetype}
 */
+ (instancetype) guideFromViewStylePadding:(UIView*) view usingMode:(IonGuideLineFrameMode) mode {
    NSParameterAssert( view && [view isKindOfClass: [UIView class]]);
    if ( !view || ![view isKindOfClass:[UIView class]] )
        return NULL;
    
    return [[self class] guideWithTarget: view
                                 keyPath: @"stylePadding"
                         processingBlock: [IonGuideTargetToken sizeProcessingBlockUsingMode: mode]
                            andCalcBlock: [[self class] defaultCalculationBlock]];
}

/**
 * Constructs a guide line based off the inputted views' corner radius, and style margin, using the mode to specify axis.
 * @param {UIView*} the view to base the guide off of.
 * @param {IonGuideLineFrameMode} the mode specifying axis to use
 * @returns {instancetype}
 */
+ (instancetype) guideFromViewAutoMargin:(UIView*) view usingMode:(IonGuideLineFrameMode) mode  {
    NSParameterAssert( view && [view isKindOfClass: [UIView class]]);
    if ( !view || ![view isKindOfClass:[UIView class]] )
        return NULL;
    
    return [[self class] guideWithTarget: view
                                 keyPath: @"autoMargin"
                         processingBlock: [IonGuideTargetToken sizeProcessingBlockUsingMode: mode]
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
                         processingBlock: [IonGuideTargetToken rectSizeProcessingBlockUsingMode: mode]
                            andCalcBlock: ^CGFloat( NSDictionary *targetValues ) {
                                return [[self class] defaultCalculationBlock]( targetValues ) * amount;
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
                      andProcessingBlock: [IonGuideTargetToken externalPositioningProcessingBlockUsingMode: mode
                                                                                          andAmount: amount]];
}

/**
 * Constructs a guide line based off the inputted value.
 * @param {CGFloat} the value to return.
 * @returns {instancetype}
 */
+ (instancetype) guideWithStaticValue:(CGFloat) value {
    return [[[self class] alloc] initWithStaticValue: value];
}

/**
 * Gets the negative guide of that guide line.
 * @returns {instancetype}
 */
- (instancetype) negativeGuide {
    return [[self class] guideWithGuide: self
                                modType: IonValueModType_Multiply
                         andSecondGuide: [@(-1) toGuideLine]];
}

@end


@implementation  NSNumber (IonGuideLine)

/**
 * Converts the current number into a static guide line.
 */
- (IonGuideLine *)toGuideLine {
    return [IonGuideLine guideWithStaticValue: [self floatValue]];
}

@end

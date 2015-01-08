//
//  IonGuideLine+DefaultConstructors.m
//  Ion
//
//  Created by Andrew Hurst on 8/26/14.
//  Copyright (c) 2014 Ion. All rights reserved.
//

#import "IonGuideLine+DefaultConstructors.h"
#import "IonGuideLine+DependentGuides.h"
#import "IonApplication.h"
#import "UIView+IonTheme.h"

@implementation IonGuideLine (DefaultConstructors)
#pragma mark Default UIView Based Guides

+ (instancetype)guideFromViewFrameSize:(UIView *)view
                           usingAmount:(CGFloat)amount
                               andMode:(IonGuideLineFrameMode)mode {
  NSParameterAssert(view && [view isKindOfClass:[UIView class]]);
  if (!view || ![view isKindOfClass:[UIView class]]) return NULL;

  return [[self class] guideWithTargetRectSize:view
                              usingRectKeyPath:@"frame"
                                        amount:amount
                                       andMode:mode];
}

+ (instancetype)guideFromViewCornerRadius:(UIView *)view
                                usingMode:(IonGuideLineFrameMode)mode {
  NSParameterAssert(view && [view isKindOfClass:[UIView class]]);
  if (!view || ![view isKindOfClass:[UIView class]]) return NULL;

  return [[self class] guideWithTarget:view andKeyPath:@"layer.cornerRadius"];
}

+ (instancetype)guideFromViewStyleMargin:(UIView *)view
                               usingMode:(IonGuideLineFrameMode)mode {
  NSParameterAssert(view && [view isKindOfClass:[UIView class]]);
  if (!view || ![view isKindOfClass:[UIView class]]) return NULL;

  return [[self class]
      guideWithTarget:view
              keyPath:@"styleMargin"
      processingBlock:[IonGuideTargetToken sizeProcessingBlockUsingMode:mode]
         andCalcBlock:[[self class] defaultCalculationBlock]];
}

+ (instancetype)guideFromViewStylePadding:(UIView *)view
                                usingMode:(IonGuideLineFrameMode)mode {
  NSParameterAssert(view && [view isKindOfClass:[UIView class]]);
  if (!view || ![view isKindOfClass:[UIView class]]) return NULL;

  return [[self class]
      guideWithTarget:view
              keyPath:@"stylePadding"
      processingBlock:[IonGuideTargetToken sizeProcessingBlockUsingMode:mode]
         andCalcBlock:[[self class] defaultCalculationBlock]];
}

+ (instancetype)guideFromViewAutoMargin:(UIView *)view
                              usingMode:(IonGuideLineFrameMode)mode {
  NSParameterAssert(view && [view isKindOfClass:[UIView class]]);
  if (!view || ![view isKindOfClass:[UIView class]]) return NULL;

  return [[self class]
      guideWithTarget:view
              keyPath:@"autoMargin"
      processingBlock:[IonGuideTargetToken sizeProcessingBlockUsingMode:mode]
         andCalcBlock:[[self class] defaultCalculationBlock]];
}

#pragma mark Frame Based Guides

+ (instancetype)guideWithTargetRectSize:(id)target
                       usingRectKeyPath:(NSString *)keyPath
                                 amount:(CGFloat)amount
                                andMode:(IonGuideLineFrameMode)mode {
  NSParameterAssert(target);
  NSParameterAssert(keyPath && [keyPath isKindOfClass:[NSString class]]);
  if (!target || !keyPath || ![keyPath isKindOfClass:[NSString class]])
    return NULL;

  return
      [[self class] guideWithTarget:target
                            keyPath:keyPath
                    processingBlock:[IonGuideTargetToken
                                        rectSizeProcessingBlockUsingMode:mode]
                       andCalcBlock:^CGFloat(NSDictionary *targetValues) {
                           return [[self class] defaultCalculationBlock](
                               targetValues)*amount;
                       }];
}

+ (instancetype)guideWithTargetRectPosition:(id)target
                           usingRectKeyPath:(NSString *)keyPath
                                     amount:(CGFloat)amount
                                    andMode:(IonGuideLineFrameMode)mode {
  NSParameterAssert(target);
  NSParameterAssert(keyPath && [keyPath isKindOfClass:[NSString class]]);
  if (!target || !keyPath || ![keyPath isKindOfClass:[NSString class]])
    return NULL;

  return [[self class]
         guideWithTarget:target
                 keyPath:keyPath
      andProcessingBlock:[IonGuideTargetToken
                             externalPositioningProcessingBlockUsingMode:
                                 mode andAmount:amount]];
}

#pragma mark Size Based Guides

+ (instancetype)guideFromSizeOnTarget:(id)target
                         usingKeyPath:(NSString *)keyPath
                               amount:(CGFloat)amount
                              andMode:(IonGuideLineFrameMode)mode {
  NSParameterAssert(target);
  NSParameterAssert(keyPath && [keyPath isKindOfClass:[NSString class]]);
  if (!target || !keyPath || ![keyPath isKindOfClass:[NSString class]])
    return NULL;

  return
      [[self class] guideWithTarget:target
                            keyPath:keyPath
                 andProcessingBlock:[IonGuideTargetToken
                                        sizeProcessingBlockUsingMode:mode
                                                           andAmount:amount]];
}

+ (instancetype)guideFromSizeOnTarget:(id)target
                         usingKeyPath:(NSString *)keyPath
                              andMode:(IonGuideLineFrameMode)mode {
  return [[self class] guideFromSizeOnTarget:target
                                usingKeyPath:keyPath
                                      amount:1.0f
                                     andMode:mode];
}

#pragma mark Point Based Guides

/**
 * Constructs a guide line based off the inputted objects point at the specified
 * key path.
 * @param target - the target object to base off of.
 * @param keyPath - the key path of the point to use.
 * @param amount - the amount of the axis to use.
 * @param mode - the mode specifying axis to use
 */
+ (instancetype)guideFromPointOnTarget:(id)target
                          usingKeyPath:(NSString *)keyPath
                                amount:(CGFloat)amount
                               andMode:(IonGuideLineFrameMode)mode {
  NSParameterAssert(target);
  NSParameterAssert(keyPath && [keyPath isKindOfClass:[NSString class]]);
  if (!target || !keyPath || ![keyPath isKindOfClass:[NSString class]])
    return NULL;

  return
      [[self class] guideWithTarget:target
                            keyPath:keyPath
                 andProcessingBlock:[IonGuideTargetToken
                                        pointProcessingBlockUsingMode:mode
                                                            andAmount:amount]];
}

+ (instancetype)guideFromPointOnTarget:(id)target
                          usingKeyPath:(NSString *)keyPath
                               andMode:(IonGuideLineFrameMode)mode {
  return [[self class] guideFromPointOnTarget:target
                                 usingKeyPath:keyPath
                                       amount:1.0f
                                      andMode:mode];
}

#pragma mark Special Guides
+ (instancetype)guideWithStaticValue:(CGFloat)value {
  return [[[self class] alloc] initWithStaticValue:value];
}

- (instancetype)negativeGuide {
  return [[self class] guideWithGuide:self
                              modType:IonValueModType_Multiply
                       andSecondGuide:[@(-1) toGuideLine]];
}

@end

@implementation NSNumber (IonGuideLine)

- (IonGuideLine *)toGuideLine {
  return [IonGuideLine guideWithStaticValue:[self floatValue]];
}

@end
